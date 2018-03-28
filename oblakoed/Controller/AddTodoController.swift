//
//  AddTodoController.swift
//  oblakoed
//
//  Created by Valery Silin on 23/03/2018.
//  Copyright © 2018 Valery Silin. All rights reserved.
//

import UIKit

class AddTodoController: CustomTableview {
    
    @IBOutlet var addTodoTableView: UITableView!
    
    let todosNetworking = TodosNetworking()
    
    
    var projects = [DataModel.Project]()
    
    var selectedRow: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "OpenSans-Light", size: 18)!, NSAttributedStringKey.foregroundColor: UIColor.white]

        updateProjects()
    }
    func updateProjects () {
        todosNetworking.getTodosData { (project, todo) in
            self.projects.removeAll()
            self.projects += project
            self.tableView.reloadData()
        }
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        var rows: Int
        if section == 0 {
            rows = 1
        } else {
            rows = projects.count
        }
        return rows
    }
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let todoTitleCell = "TodoTitle"
        let todoCategoryCell = "TodoCell"
        
        if indexPath.section == 0 {
            let titleCell = tableView.dequeueReusableCell(withIdentifier: todoTitleCell) as! AddTodoControllerCell
            return titleCell
        } else {
            
            let categoryCell = tableView.dequeueReusableCell(withIdentifier: todoCategoryCell)!
            categoryCell.textLabel?.text = projects[indexPath.row].title
            
            return categoryCell
        }
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 72
        } else {
            return 56
        }
    }
    override func tableView(_ tableView: UITableView,
                            titleForHeaderInSection section: Int) -> String? {
        var header = ""
        if section == 0 {
            header = "ЗАДАЧА"
        } else {
            header = "КАТЕГОРИЯ"
        }
        return header
    }
    override func tableView(_ tableView: UITableView,
                            willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if indexPath.section == 1 {
            selectedRow = indexPath.row
            return indexPath
        } else {
            return nil
        }
    }
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
        }
        
    }
    override func tableView(_ tableView: UITableView,
                            didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
        }
        
    }
    
    
    @IBAction func cancelPressed(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
        
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func addTodoPressed(_ sender: UIBarButtonItem) {
        
        let totalSection = addTodoTableView.numberOfSections
        for section in 0..<totalSection
        {
            let totalRows = addTodoTableView.numberOfRows(inSection: section)
            
            for row in 0..<totalRows
            {
                let cell = addTodoTableView.cellForRow(at: IndexPath(row: row, section: section))
                if let textField = cell?.viewWithTag(101) as? UITextField
                {
                    todosNetworking.addNewTodo(projectId: projects[selectedRow].id, text: textField.text!)
                    
                    navigationController?.popViewController(animated: true)
                    
                    dismiss(animated: true, completion: nil)
                }
            }
        }
    }
}



