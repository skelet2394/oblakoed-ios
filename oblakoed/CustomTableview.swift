//
//  CustomTableview.swift
//  oblakoed
//
//  Created by Valery Silin on 24/03/2018.
//  Copyright © 2018 Valery Silin. All rights reserved.
//

import UIKit
class CustomTableview: UITableViewController {
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "OpenSans-Bold", size: 12)!
        header.textLabel?.text = header.textLabel?.text?.uppercased()
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell") {
            cell.textLabel?.font = UIFont(name: "OpenSans-Regular", size: 30)
            return cell
        }
        return UITableViewCell()
    }
    override func viewWillAppear(_ animated: Bool) {
//        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "OpenSans-Light", size: 20), NSAttributedStringKey.foregroundColor: UIColor.white]
    }
}

