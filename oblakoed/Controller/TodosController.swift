//
//  TodosController.swift
//  oblakoed
//
//  Created by Valery Silin on 23/03/2018.
//  Copyright © 2018 Valery Silin. All rights reserved.
//

import UIKit
import M13Checkbox
class TodosController: CustomTableview {
    
    @IBOutlet weak var todoTableView: UITableViewCell!
    
    let todosNetworking  = TodosNetworking()
    var projects = [DataModel.Project]()
    var todos = [DataModel.Todo]()
    let decoder = JSONDecoder()
    
    @IBOutlet weak var addTodoButton: UINavigationItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: "CustomCheckboxCell", bundle: nil), forCellReuseIdentifier: "customCheckboxCell")
    }
    override func viewWillAppear (_ animated: Bool) {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "OpenSans-Light", size: 18)!, NSAttributedStringKey.foregroundColor: UIColor.white]

        prepareTableviewData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return projects.count
    }
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        let sectionId = projects[section].id
        var sectionRows: Int = 0
        todos.forEach { (todo) in
            if todo.projectId?.hashValue == sectionId {
                sectionRows += 1
            }
        }
        return sectionRows
    }
    override func tableView(_ tableView: UITableView,
                            titleForHeaderInSection section: Int) -> String? {
        let projectTitle = projects[section].title
        
        
        return projectTitle
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCheckboxCell") as! CustomCheckboxCell
        let sectionId = projects[indexPath.section].id
        let todo = todoForIndexInSection(index: indexPath.row, section: sectionId)
        let todoText = todo.text
        let todoCompleted = todo.isCompleted
        cell.todoTitle?.text = todoText
        cell.todoCheckbox.setCheckState(checkBoxStateFromBoolean(state: todoCompleted), animated: false)
        if todoCompleted == true {
            cell.todoTitle?.attributedText = String.makeSlashText((cell.todoTitle?.text)!)
        }
        
        return cell
    }
    
    func todoForIndexInSection (index: Int, section: Int) -> DataModel.Todo{
        var todoForSection: [DataModel.Todo] = []
        todos.forEach { (todo) in
            if todo.projectId == section {
                todoForSection.append(todo)
            }
        }
        return todoForSection[index]
    }
    
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        
        let cell: CustomCheckboxCell = tableView.cellForRow(at: indexPath) as! CustomCheckboxCell
        let sectionId = projects[indexPath.section].id
        let todo = todoForIndexInSection(index: indexPath.row, section: sectionId)

        
        if cell.todoCheckbox.checkState == .unchecked {
            cell.todoTitle?.attributedText = String.makeSlashText((cell.todoTitle?.text)!)
            cell.todoCheckbox.setCheckState(.checked, animated: true)
            todosNetworking.updateTodoState(todoId: todo.todoId)
        } else {
            cell.todoCheckbox.setCheckState(.unchecked, animated: true)
            cell.todoTitle?.attributedText = String.makePlainText((cell.todoTitle?.attributedText)!)
            todosNetworking.updateTodoState(todoId: todo.todoId)

        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func prepareTableviewData() {
        todosNetworking.getTodosData { (project, todo) in
            self.projects.removeAll()
            self.todos.removeAll()
            self.projects += project
            self.todos += todo
            self.tableView.reloadData()
            
        }
    }
    
    func checkBoxStateFromBoolean(state: Bool) -> M13Checkbox.CheckState {
       return (state == true) ? .checked : .unchecked
    }
}
extension String {
    static func makeSlashText(_ text:String) -> NSAttributedString {
        
        
        let attr: NSMutableAttributedString =  NSMutableAttributedString(string: text)
        attr.addAttribute(NSAttributedStringKey.strikethroughStyle, value: NSUnderlineStyle.styleSingle.rawValue , range: NSMakeRange(0, attr.length))
        
        return attr
        
    }
    static func makePlainText(_ text: NSAttributedString) -> NSAttributedString {
        let attr: NSMutableAttributedString =  NSMutableAttributedString(attributedString: text)
        attr.removeAttribute(NSAttributedStringKey.strikethroughStyle, range: NSMakeRange(0, attr.length))
        return attr
    }
}

