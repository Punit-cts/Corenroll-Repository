//
//  OTPVerificationViewModel.swift
//  CorenrollDemo
//
//  Created by Punit Thakali on 21/12/2023.
//

import Foundation

protocol OTPVerificationViewModelDelegate: AnyObject {
    
    func didVerifyOTP()
    func OTPVerifyFailed()
    
    
}

class OTPVerificationViewModel{
    
    public init(delegate: OTPVerificationViewModelDelegate? = nil){
        self.delegate = delegate
    }
    
    weak var delegate: OTPVerificationViewModelDelegate?
    
    func otpGeneration( model: OTPVerificationModel){
        
        OTPVerificationNetworkManager.shared.otpGeneration(model: model) { [weak self] result in
            
            switch result {
                
            case.success:
                DispatchQueue.main.async{
                    
                    self?.delegate?.didVerifyOTP()
                    
                }
            case .failure:
                DispatchQueue.main.async{
                    
                    self?.delegate?.OTPVerifyFailed()
                }
            }
        }
    }
}
    
    
    
    
    
    
    
