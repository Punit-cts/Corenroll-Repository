//
//  CustomTextField.swift
//  CorenrollDemo
//
//  Created by Punit Thakali on 15/12/2023.
//

import UIKit

class CustomEmailTextField: UIView {
    
    let custompasswordtxtfield = CustomPasswordTextField()

    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit(){
        
        let customview = Bundle.main.loadNibNamed("CustomEmailTextField", owner: self, options: nil)![0] as! UIView
        customview.frame = self.bounds
        addSubview(customview)
        
    }
    
    func validateEmail() -> Bool {
        
        guard let email = emailTextField.text else { return false }   //user enters email

        let validEmail = email.contains("@")
        emailErrorLabel.text = validEmail ? "" : "Invalid Email"         //error label
        return validEmail
        
    }
}


