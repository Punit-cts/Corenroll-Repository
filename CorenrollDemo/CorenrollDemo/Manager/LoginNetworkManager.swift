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
        
        // Added printing of url request message using extention function at end of this file.
        print("REQUEST: ==============================")
        request.debug()
        print("================= ==============================")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                if error == nil{
                    print(error?.localizedDescription ?? "Unknown Error")
                }
                return
            }
            
            if let response = response as? HTTPURLResponse{ guard (200 ... 299) ~= response.statusCode else {
                print("RESPONSE: ==============================")
                print("Status code :- \(response.statusCode)")
                let jsonString = try? JSONSerialization.jsonObject(with: data)
                print(jsonString)
                print("================= ==============================")
                return
            }
                
//            handle 422, 401 and 200 as per jsonString
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

public extension URLRequest {
    func debug() {
        print("\(self.httpMethod!) \(self.url!)")
        print("Headers:")
        print(self.allHTTPHeaderFields!)
        print("Body:")
        print(String(data: self.httpBody ?? Data(), encoding: .utf8)!)
    }
}


