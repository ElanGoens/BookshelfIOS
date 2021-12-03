//
//  LoginService.swift
//  BookshelfIOS
//
//  Created by Elan Goens on 03/12/2021.
//

import Foundation

class LoginService{
    func login(username: String, password: String, completion: @escaping (Result<String, AuthenticationError>) -> Void){
        
        guard let url = URL(string: "https://bookshelfapiwebiv.azurewebsites.net/api/Account") else{
            completion(.failure(.custom(errorMessage: "URL is not correct")))
            return
        }
        
        let body = LoginRequestBody(email: username, password: password)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        
        let printsel = try? JSONDecoder().decode(LoginRequestBody.self, from: request.httpBody!)
        print(printsel)
        
        print("body")
        print(request.httpBody)
        print("body")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(.custom(errorMessage: "No Data")))
                return
            }
            
            print(data)
            
            guard let loginResponse = try? JSONDecoder().decode(LoginResponse.self, from: data) else {
                completion(.failure(.invalidCredentials))
                return
            }
            
            print(loginResponse.token)
            
            guard let token = loginResponse.token else{
                completion(.failure(.invalidCredentials))
                return
            }
            print(token)
            
            completion(.success(token))
        }.resume()
        
    }
}

enum AuthenticationError: Error{
    case invalidCredentials
    case custom(errorMessage: String)
}

struct LoginRequestBody : Codable{
    let email: String
    let password: String
}

struct LoginResponse : Decodable{
    let token: String?
   
    
}
