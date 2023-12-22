//
//  LoginVerificationViewModel.swift
//  CorenrollDemo
//
//  Created by Punit Thakali on 21/12/2023.
//

import Foundation

protocol LoginVerificationViewModelDelegate: AnyObject{
    
    func didLoginSuccessfully()
    func loginFailed()
    
}

class LoginVerificationViewModel{
    
    weak var delegate: LoginViewModelDelegate?
    
    func loginverification( model: LoginVerificationModel){
        
        LoginVerificationNetworkManager.shared.loginverification(model: model) { [weak self] result in
            switch result{
                
            case .success:
                DispatchQueue.main.async{
                    
                    self?.delegate?.didLoginSuccessfully()
                }
                
            case .failure:
                DispatchQueue.main.async{
                    
                    self?.delegate?.loginFailed()
                    
                }
            }
        }
    }
}

