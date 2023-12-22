//
//  LoggedInViewController.swift
//  CorenrollDemo
//
//  Created by Punit Thakali on 18/12/2023.
//

import UIKit

class LoggedInViewController: UIViewController, OTPVerificationViewModelDelegate {
    
    var otpModel: OTPVerificationViewModel!
    let loginviewcontroller = LoginScreenViewController()
    
    @IBOutlet weak var otpTextField: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.otpModel = OTPVerificationViewModel()
        self.otpModel.delegate = self
    }
    
    @IBAction func verifyOTPButton(_ sender: UIButton) {
        
        self.present(loadingOTPAlert, animated: true)
        
        let otpVerifiedModel = OTPVerificationModel(email: self.loginviewcontroller.customTextView.emailTextField.text!, user_type: "A", verification_code: self.otpTextField.text!, device_id: loginviewcontroller.generateDeviceID())
        
    }
    
    let loadingOTPAlert = UIAlertController(title: nil, message: "Verifying OTP", preferredStyle: .alert)
    
    func didVerifyOTP(){
        
        DispatchQueue.main.async { [weak self] in
            
            self?.loadingOTPAlert.dismiss(animated: true)
            
        }
    }
    
    func OTPVerifyFailed(){
        
        DispatchQueue.main.async {
            
            self.loadingOTPAlert.dismiss(animated: true)
        }
        
        let failureOTPAlert = UIAlertController(title: "Verifying OTP Failed", message: nil, preferredStyle: .alert)
        failureOTPAlert.addAction(UIAlertAction(title: "Back", style: .default, handler: nil))
        present(failureOTPAlert, animated: true, completion: nil)
    }
}

