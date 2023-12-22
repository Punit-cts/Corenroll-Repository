//
//  OTPGenerationNeworkManager.swift
//  CorenrollDemo
//
//  Created by Punit Thakali on 11/12/2023.
//

import Foundation

class OTPVerificationNetworkManager {
    
    static let shared = OTPVerificationNetworkManager()
    
    let loggedinviewcontroller = LoggedInViewController()
    
    private init() {}

    func otpGeneration(model: OTPVerificationModel, completion: @escaping (Result<Void, Error>) -> Void) {
        
        let url = URL(string: "https://qa-api.purenroll.com/api/v2/auth/authenticate-code")!
    
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let otpverificationmodel = model
        
        do {
            let jsonData = try JSONEncoder().encode(otpverificationmodel)
            request.httpBody = jsonData
        }
        catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NSError(domain: "NetworkError", code: 0, userInfo: nil)))
                return
            }
            
            if (200...299).contains(httpResponse.statusCode) {
                
                completion(.success(()))
            } else {
              
                completion(.failure(NSError(domain: "ServerError", code: httpResponse.statusCode, userInfo: nil)))
            }
            
        }.resume()
    }
}



