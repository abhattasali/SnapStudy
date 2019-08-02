//
//  WordToggleTest.swift
//  SnapStudy
//
//  Created by Arun Bhattasali on 7/22/19.
//  Copyright © 2019 Arun Bhattasali. All rights reserved.
//

import UIKit
import MobileCoreServices
import TesseractOCR
import GPUImage
import Reductio
import Foundation

class WordToggleTest: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var createButton: UIButton!
    
    var wt_flashset: FlashSet!
    var terms = [String]()
    var numWords = 0
    
    var addedTerms = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createButton.layer.cornerRadius = 10
        for keyword in wt_flashset.myWordCards.keys.sorted() {
            add(keyword)
        }
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let cardWrapperVC = segue.destination as? LottieViewController else { return }
        cardWrapperVC.wt_flashset = wt_flashset
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
                        //print("Removing \(cellKeyword)")
                    }
                    else if(addedTerms.contains(cellKeyword))    //is a good word, scrubs repeats
                    {
                        wt_flashset.myWordCards[cellKeyword] = Flashcard(keyword: cellKeyword, definition: jsonExtract(key: cellKeyword), image: UIImage())
                    }
                }
            }
        }
        
    }
    
    //Add Title button
    @IBAction func titleBtn(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add a title for your flash set!", message: nil, preferredStyle: .alert)
        alert.addTextField { (termTF) in
            termTF.placeholder = "Enter Term"
        }
        let action = UIAlertAction(title: "Add Title", style: .default) { (_) in
            guard let term = alert.textFields?.first?.text else { return }
            //print(term)
            if(term != "") {
                self.add(term)
                self.addedTerms.append(term)
            }
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: {
            action in
            // Called when user taps outside
        }))
        alert.addAction(action)
        present(alert, animated: true)

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
                self.addedTerms.append(term)
            }
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: {
            action in
            // Called when user taps outside
        }))
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    func doneMove(){
        performSegue(withIdentifier: "termsNavigation", sender: nil)
    } 
    func add(_ term: String) {
        let index = numWords
        terms.insert(term, at: index)
        numWords += 1
        
        let indexPath = IndexPath(row: index, section: 0)
        tableView.insertRows(at: [indexPath], with: .left)
    }
    

/**String Parser Functions**/
func cutDef(def: String) -> String {
    if(def.count <= 475) { return def }
    var firstPeriod = 475
    while(firstPeriod != def.count && def[def.index(def.startIndex, offsetBy: firstPeriod)] != ".") {
        firstPeriod = firstPeriod + 1
    }
    return def[0...firstPeriod]
}

/**String Parser Functions**/
func jsonExtract(key: String) -> String {
    let url = Bundle.main.url(forResource: "dictionary", withExtension: "json")!
    let data = try! Data(contentsOf: url)
    do {
        // make sure this JSON is in the format we expect
        if let jsonFile = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
            if let definition: String = jsonFile[key] as? String { return cutDef(def: definition) } //DEFINITION
        }
    }
    catch let error as NSError {
        print("Failed to load: \(error.localizedDescription)")
    }
    return "No definition available at the time."
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
        let appDel = UIApplication.shared.delegate as! AppDelegate
        if(appDel.isDyslexieOn)
        {
            cell.textLabel?.font =  UIFont(name: "OpenDyslexicMono-Regular", size: 18)
        }
        
        let switchView = UISwitch(frame: .zero)
        switchView.setOn(true, animated: true)
        switchView.onTintColor = UIColor(red: 229.0 / 255.0, green: 187.0 / 255.0, blue: 72.0 / 255.0, alpha: 1.0)
        switchView.tintColor = UIColor(red: 224.0 / 255.0, green: 68.0 / 255.0, blue: 20.0 / 255.0, alpha: 1.0)    //red as in no 224, 68, 20
        switchView.tag = indexPath.row                  // for detect which row switch Changed
        switchView.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
        cell.accessoryView = switchView
        return cell
    }
    
    @objc func switchChanged(_ sender : UISwitch!)
    {
        print("table row switch Changed \(sender.tag)")
        print("The switch is \(sender.isOn ? "ON" : "OFF")")
    }
    
    
}

