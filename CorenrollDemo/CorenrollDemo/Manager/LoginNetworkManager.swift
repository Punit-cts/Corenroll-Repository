//
//  LoginNeworkManager.swift
//  CorenrollDemo
//
//  Created by Punit Thakali on 11/12/2023.
//

import Foundation

class LoginNetworkManager {
    
    static let shared = LoginNetworkManager()
    
    private init() {}

    func login(model: LoginModel, completion: @escaping (Result<Void, Error>) -> Void) {
        
        let url = URL(string: "https://qa-api.purenroll.com/api/v1/auth/login")!
    
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        

        let apiModel = model
        
        do {
            let jsonData = try JSONEncoder().encode(apiModel)
            request.httpBody = jsonData
        }
        catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                if error == nil{
                    print(error?.localizedDescription ?? "Unknown Error")
                }
                return
            }
            if let response = response as? HTTPURLResponse{ guard (200 ... 299) ~= response.statusCode else {
                print("Status code :- \(response.statusCode)")
                print(response)
                return
            }
            }
            do{
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            }
            catch let error{
                print(error.localizedDescription)
            }
        }.resume()
    }
}


