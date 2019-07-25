//
//  WordToggleTest.swift
//  SnapStudy
//
//  Created by Arun Bhattasali on 7/22/19.
//  Copyright © 2019 Ray Wenderlich. All rights reserved.
//

import UIKit
import MobileCoreServices
import TesseractOCR
import GPUImage
import Reductio
import Foundation

class WordToggleTest: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var wt_flashset: FlashSet!
    var terms = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("test \(wt_flashset.getSetName())")
        for w in wt_flashset.myWordCards.keys {
            print("\(w)")
            print("\((wt_flashset.myWordCards[w]?.definition)!)\n\n")
        }
        
        for keyword in wt_flashset.myWordCards.keys.sorted()
        {
            add(keyword)
        }
    }
    
    @IBAction func onAddTapped() {
        let alert = UIAlertController(title: "Add a term", message: nil, preferredStyle: .alert)
        alert.addTextField { (termTF) in
            termTF.placeholder = "Enter Term"
        }
        let action = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let term = alert.textFields?.first?.text else { return }
            print(term)
            self.add(term)
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    
    func add(_ term: String) {
        let index = 0
        terms.insert(term, at: index)
        
        let indexPath = IndexPath(row: index, section: 0)
        tableView.insertRows(at: [indexPath], with: .left)
    }
    
    
}

extension WordToggleTest: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return terms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let term = terms[indexPath.row]
        cell.textLabel?.text = term
        
        let switchView = UISwitch(frame: .zero)
        switchView.setOn(false, animated: true)
        switchView.tag = indexPath.row // for detect which row switch Changed
        switchView.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
        cell.accessoryView = switchView
        
        return cell
    }
    
    /*func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     guard editingStyle == .delete else { return }
     terms.remove(at: indexPath.row)
     
     tableView.deleteRows(at: [indexPath], with: .automatic)
     }*/
    
    @objc func switchChanged(_ sender : UISwitch!){
        
        print("table row switch Changed \(sender.tag)")
        print("The switch is \(sender.isOn ? "ON" : "OFF")")
    }
    
    
}

