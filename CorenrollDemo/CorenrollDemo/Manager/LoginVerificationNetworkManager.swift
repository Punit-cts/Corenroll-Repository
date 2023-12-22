//
//  LoginVerificationNeworkManager.swift
//  CorenrollDemo
//
//  Created by Punit Thakali on 11/12/2023.
//

import Foundation

class LoginVerificationNetworkManager {
    
    static let shared = LoginVerificationNetworkManager()
    
    private init() {}

    func loginverification(model: LoginVerificationModel, completion: @escaping (Result<Void, Error>) -> Void) {
        
        let url = URL(string: "https://qa-api.purenroll.com/api/v1/auth/authenticate")!
    
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let loginverificationmodel = model
        
        do {
            let jsonData = try JSONEncoder().encode(loginverificationmodel)
            request.httpBody = jsonData
        }
        catch {
            completion(.failure(error))
            return
        }
        
        print("REQUEST: ==============================")
        request.debug()
        print("================= ==============================")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                if error == nil{
                    print(error?.localizedDescription ?? "Unknown Error")
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NSError(domain: "NetworkError", code: 0, userInfo: nil)))
                return
            }
            print("RESPONSE: ==============================")
            print("Status code :- \(httpResponse.statusCode)")
            let jsonString = try? JSONSerialization.jsonObject(with: data)
            print(jsonString)
            print("================= ==============================")
            
            if (200...299).contains(httpResponse.statusCode) {
                
                completion(.success(()))
            } else {
              
                completion(.failure(NSError(domain: "ServerError", code: httpResponse.statusCode, userInfo: nil)))
            }
            
        }.resume()
    }
}


