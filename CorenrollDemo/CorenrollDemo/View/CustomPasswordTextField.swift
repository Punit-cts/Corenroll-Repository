//
//  CustomPasswordTextField.swift
//  CorenrollDemo
//
//  Created by Punit Thakali on 22/12/2023.
//

import Foundation
import UIKit

class CustomPasswordTextField: UIView{
    
    @IBOutlet weak var passwordVisibilityButton: UIButton!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit(){
        
        let customview = Bundle.main.loadNibNamed("CustomPasswordTextField", owner: self, options: nil)![0] as! UIView
        customview.frame = self.bounds
        addSubview(customview)
        
        passwordVisibilityButton.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        
    }
    
    @objc func togglePasswordVisibility() {
        
        passwordTextField.isSecureTextEntry.toggle()   //hides the text inside the textfield
          
        let imageName = passwordTextField.isSecureTextEntry ? "eye.slash.fill" : "eye.fill"
        passwordVisibilityButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    func validatePassword() -> Bool {
            
        guard let password = passwordTextField.text else { return false }  //user enters password

        let validPassword = password.count >= 8
        passwordErrorLabel.text = validPassword ? "" : "Invalid Password"      //error label
        return validPassword        
    }
}
