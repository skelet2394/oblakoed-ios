//
//  AddTodoControllerCell.swift
//  oblakoed
//
//  Created by Valery Silin on 27/03/2018.
//  Copyright © 2018 Valery Silin. All rights reserved.
//

import UIKit

class AddTodoControllerCell: UITableViewCell {

    @IBOutlet weak var todoTitleTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension UITextField {
    open override func draw(_ rect: CGRect) {
        
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.masksToBounds = true
    }
}

class TextField: UITextField {
    
    let padding = UIEdgeInsets(top: 10 , left: 10, bottom: 10, right: 10);
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
}
