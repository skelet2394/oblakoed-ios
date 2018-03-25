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
    
    let proj1 = ["Заплатить за квартиру", "Купить продукты" ,"Забрать обувь из ремонта"]
    let proj2 = ["Заполнить отчёт", "Отправить документы" ,"Позвонить заказчику"]
    
    let todo = ["Семья", "Работа", "Прочее"]
    @IBOutlet weak var addTodoButton: UINavigationItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "CustomCheckboxCell", bundle: nil), forCellReuseIdentifier: "customCheckboxCell")
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // FIXME: CONFIG SECTIONS
        return todo.count
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // FIXME: CONFIG PROJECTS
        let header = todo[section]
        return header
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // FIXME: CONFIG TODOS
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCheckboxCell") as! CustomCheckboxCell
        if indexPath.section == 1 {
            cell.todoTitle?.text = proj2[indexPath.row]
            //            cell.todoTitle?.attributedText = String.makeSlashText(proj2[indexPath.row])
            
        } else {
            cell.todoTitle?.text = proj1[indexPath.row]
            
            
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell: CustomCheckboxCell = tableView.cellForRow(at: indexPath) as! CustomCheckboxCell
        if cell.todoCheckbox.checkState == .unchecked {
            cell.todoTitle?.attributedText = String.makeSlashText((cell.todoTitle?.text)!)
            cell.todoCheckbox.setCheckState(.checked, animated: true)
        } else {
            cell.todoCheckbox.setCheckState(.unchecked, animated: true)
            cell.todoTitle?.attributedText = String.makePlainText((cell.todoTitle?.attributedText)!)
        }
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
}
extension String {
    static func makeSlashText(_ text:String) -> NSAttributedString {
        
        
        let attr: NSMutableAttributedString =  NSMutableAttributedString(string: text)
        attr.addAttribute(NSAttributedStringKey.strikethroughStyle, value: NSUnderlineStyle.styleSingle.rawValue, range: NSMakeRange(0, attr.length))
        
        return attr
        
    }
    static func makePlainText(_ text: NSAttributedString) -> NSAttributedString {
        let attr: NSMutableAttributedString =  NSMutableAttributedString(attributedString: text)
        attr.removeAttribute(NSAttributedStringKey.strikethroughStyle, range: NSMakeRange(0, attr.length))
        return attr
    }
}
