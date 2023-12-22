//
//  OTPVerificationModel.swift
//  CorenrollDemo
//
//  Created by Punit Thakali on 21/12/2023.
//

import Foundation


struct OTPVerificationModel: Encodable{
    
    let email: String
    let user_type: String
    let verification_code: String
    let device_id: String
    
    
}
