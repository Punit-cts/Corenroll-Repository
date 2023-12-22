//
//  LoginViewModel.swift
//  CorenrollDemo
//
//  Created by Punit Thakali on 11/12/2023.
//

import Foundation


protocol LoginViewModelDelegate: AnyObject {
    
    func didLoginSuccessfully()
    func loginFailed()
  
}

class LoginViewModel {
    
    public init(delegate: LoginViewModelDelegate? = nil) {
        self.delegate = delegate
    }
    
    weak var delegate: LoginViewModelDelegate?
        
    func login( model: LoginModel) {
        
        
        LoginNetworkManager.shared.login(model: model) { [weak self] result in
            switch result {
                
            case .success:
                DispatchQueue.main.async{
                    
                    self?.delegate?.didLoginSuccessfully()
                    
                }
                
            case .failure:
                DispatchQueue.main.async {
                    
                    self?.delegate?.loginFailed()
                }
            }
        }
    }
}



    

