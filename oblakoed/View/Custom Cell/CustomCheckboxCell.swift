//
//  CustomCheckboxCell.swift
//  oblakoed
//
//  Created by Valery Silin on 24/03/2018.
//  Copyright © 2018 Valery Silin. All rights reserved.
//
import M13Checkbox
import UIKit

class CustomCheckboxCell: UITableViewCell {
    
    @IBOutlet weak var todoCheckbox: M13Checkbox!
    @IBOutlet weak var todoTitle: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        todoCheckbox.boxType = .square
//        todoCheckbox.animationDuration = 0
        todoCheckbox.stateChangeAnimation = .fill
        todoCheckbox.checkmarkLineWidth = 3
        todoCheckbox.cornerRadius = 0
        
        
    }
    
}
