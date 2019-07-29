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
    var numWords = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("test \(wt_flashset.getSetName())")
        for w in wt_flashset.myWordCards.keys {
            print("\(w)")
            print("\((wt_flashset.myWordCards[w]?.definition)!)\n\n")
        }
        
        for keyword in wt_flashset.myWordCards.keys.sorted() {
            add(keyword)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let flashDisplayNavigator = segue.destination as? UINavigationController
        guard let flashDisplayController = flashDisplayNavigator?.viewControllers.first as? FlashDisplay else {return}
        flashDisplayController.flashset = wt_flashset
    }
    
    //BUTTON COMPUTATION
    @IBAction func computeToggle(_ sender: UIButton) {

        
        if let cells = self.tableView.visibleCells as? Array<UITableViewCell>
        {
            for cell in cells {
                if  let cellNum = cell.accessoryView?.tag,
                    let switchCell = cell.accessoryView as? UISwitch {
                    let cellKeyword = terms[cellNum]
                    if(switchCell.isOn == false) {
                        wt_flashset.myWordCards[cellKeyword] = nil      //removes
                        print("Removing \(cellKeyword)")
                    }
                }
            }
        }
    }
    
    
    @IBAction func onAddTapped() {
        let alert = UIAlertController(title: "Add a term", message: nil, preferredStyle: .alert)
        alert.addTextField { (termTF) in
            termTF.placeholder = "Enter Term"
        }
        let action = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let term = alert.textFields?.first?.text else { return }
            //print(term)
            if(term != "") {
                self.add(term)
            }
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    
    func add(_ term: String) {
        let index = numWords
        terms.insert(term, at: index)
        numWords += 1
        
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
        switchView.setOn(true, animated: true)
        switchView.onTintColor = UIColor(red: 229.0 / 255.0, green: 187.0 / 255.0, blue: 72.0 / 255.0, alpha: 1.0)
        switchView.tintColor = UIColor(red: 224.0 / 255.0, green: 68.0 / 255.0, blue: 20.0 / 255.0, alpha: 1.0)    //red as in no 224, 68, 20
        switchView.tag = indexPath.row                  // for detect which row switch Changed
        switchView.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
        cell.accessoryView = switchView
        return cell
    }
    
    @objc func switchChanged(_ sender : UISwitch!){
        
        print("table row switch Changed \(sender.tag)")
        print("The switch is \(sender.isOn ? "ON" : "OFF")")
        print("hello")
        
    }
    
    
}

