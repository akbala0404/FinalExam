//
//  TextFieldWithPadding.swift
//  FinalExam
//
//  Created by Акбала Тлеугалиева on 5/23/22.
//  Copyright © 2022 Akbala Tleugaliyeva. All rights reserved.
//

import UIKit

class TextFieldWithPadding: UITextField {

    var padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 16);
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

}
