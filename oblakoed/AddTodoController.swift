//
//  AddTodoController.swift
//  oblakoed
//
//  Created by Valery Silin on 23/03/2018.
//  Copyright © 2018 Valery Silin. All rights reserved.
//

import UIKit

class AddTodoController: CustomTableview {
    @IBOutlet weak var todoTitleTextfield: UITextField!
    
    let todo = ["Семья", "Работа", "Прочее"]

    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var sectionsCount: Int
        if section == 0 {
            sectionsCount = 1
        } else {
            // FIXME: CONFIG SECTIONS
            sectionsCount = 3
        }
        return sectionsCount
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        if indexPath.section == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: "TodoTitle")!
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell")!
            cell.textLabel?.text = todo[indexPath.row]

            // FIXME: CONFIG ROWS

        }
        return cell
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var header = ""
        if section == 0 {
             header = "ЗАДАЧА"
        } else {
             header = "КАТЕГОРИЯ"

        }
        return header
    }

    @IBAction func cancelPressed(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addTodoPressed(_ sender: UIBarButtonItem) {
        
    }
    

   
   
}
