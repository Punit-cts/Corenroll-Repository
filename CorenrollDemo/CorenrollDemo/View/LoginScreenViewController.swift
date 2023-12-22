//
//  ViewController.swift
//  CorenrollDemo
//
//  Created by Punit Thakali on 11/12/2023.
//

import UIKit



class LoginScreenViewController: UIViewController, UITextFieldDelegate, LoginViewModelDelegate, LoginVerificationViewModelDelegate{
    
    var loginviewModel: LoginViewModel!
    var loginverificationmodel: LoginVerificationViewModel!
    
    @IBOutlet weak var customTextView: CustomEmailTextField!
    @IBOutlet weak var customPasswordTextView: CustomPasswordTextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let corAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.systemBlue,                              //adds the color blue to "COR"
            .font: UIFont.systemFont(ofSize: 34, weight: .bold)]
        
        let enrollAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,                                   //adds the color black to "ENROLL"
            .font: UIFont.boldSystemFont(ofSize: 34)]
        
        let corString = NSAttributedString(string: "COR", attributes: corAttributes)
        
        let enrollString = NSAttributedString(string: "ENROLL", attributes: enrollAttributes)
        
        let combinedString = NSMutableAttributedString()
        combinedString.append(corString)
        combinedString.append(enrollString)
        
        let titleLabel = UILabel()
        titleLabel.attributedText = combinedString
        titleLabel.sizeToFit()
        
        let leftOffSet: CGFloat = 16
        titleLabel.frame.origin.x = leftOffSet
        titleLabel.frame.origin.y = view.safeAreaInsets.bottom + 20
        titleLabel.frame.size.width = view.bounds.width - leftOffSet        //adjusts the navigation title fo the left side of the screen such that the
        titleLabel.textAlignment = .left
        
        navigationItem.titleView = titleLabel
        
        customTextView.emailTextField.delegate = self
        customPasswordTextView.passwordTextField.delegate = self
        customTextView.emailTextField.becomeFirstResponder()
        
        let deviceidgenerated = generateDeviceID()                   //generates deviceID
        print(deviceidgenerated)
        
        self.makeSpinner()
        
        self.loginviewModel = LoginViewModel()
        self.loginviewModel.delegate = self
        
        self.loginverificationmodel = LoginVerificationViewModel()
        self.loginverificationmodel.delegate = self
        
    }
    
    
    @IBAction func loginButton(_ sender: Any) {
        
        let isEmailValid = customTextView.validateEmail()
        let isPasswordValid = customPasswordTextView.validatePassword()

        if isEmailValid && isPasswordValid{
            
            self.present(loadingAlert, animated: true)
            
            let loginmodel  = LoginModel(email: self.customTextView.emailTextField.text!, user_type: "A", password: self.customPasswordTextView.passwordTextField.text!, device_id: self.generateDeviceID())
            self.loginviewModel.login(model: loginmodel)
            
            let verificationmodel = LoginVerificationModel(email: self.customTextView.emailTextField.text!, data: "email", device_id: self.generateDeviceID())
            self.loginverificationmodel.loginverification(model: verificationmodel)
            
        }
        
        else{
            
            loginFailed()
            
        }
    }
    
    @IBAction func forgotPasswordButton(_ sender: Any) {
        
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        
    }
    
    let loadingAlert = UIAlertController(title: nil, message: "\n\nLogging In", preferredStyle: .alert)
    
    private func makeSpinner() {
        
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        
        loadingAlert.view.addSubview(spinner)
        
        NSLayoutConstraint.activate([
            
            spinner.centerXAnchor.constraint(equalTo: loadingAlert.view.centerXAnchor),
            spinner.topAnchor.constraint(equalTo: loadingAlert.view.topAnchor, constant: 30),
        ])
        
    }
    
    func didLoginSuccessfully() {
        
        DispatchQueue.main.async { [weak self] in
            
            self?.loadingAlert.dismiss(animated: true) {
                
                self?.performSegue(withIdentifier: "instantiate", sender: nil)
            }
        }
    }
    
    func loginFailed() {
        
        DispatchQueue.main.async { [weak self] in
            
            self?.loadingAlert.dismiss(animated: true)
        }
        
        let failureAlert = UIAlertController(title: "Login Failed", message: nil, preferredStyle: .alert)
        failureAlert.addAction(UIAlertAction(title: "Back", style: .default, handler: nil))
        present(failureAlert, animated: true, completion: nil)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {   //clears the alert label that appears
        
        customTextView.emailErrorLabel.text = ""
        customPasswordTextView.passwordErrorLabel.text = ""
        return true
    }
    
    func generateDeviceID() -> String {                                             //generates the deviceID
        
        if let vendorID = UIDevice.current.identifierForVendor?.uuidString {
            
            return vendorID
        }
        else {
            
            return UUID().uuidString
        }
    }
}



