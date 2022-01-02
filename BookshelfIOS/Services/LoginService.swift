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
        
        
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(.custom(errorMessage: "No Data")))
                return
            }
            
            
            
            guard let loginResponse = try? JSONDecoder().decode(LoginResponse.self, from: data) else {
                completion(.failure(.invalidCredentials))
                return
            }
            
            
            
            guard let token = loginResponse.token else{
                completion(.failure(.invalidCredentials))
                return
            }
            
            
            completion(.success(token))
        }.resume()
        
    }
    
    func register(firstName: String, lastName: String, username: String, password: String, passwordConfirmation: String, completion: @escaping (Result<String, AuthenticationError>) -> Void){
        
        guard let url = URL(string: "https://bookshelfapiwebiv.azurewebsites.net/api/Account/register") else{
            completion(.failure(.custom(errorMessage: "URL is not correct")))
            return
        }
        
        let body = RegisterRequestBody(email: username, password: password, firstName: firstName, lastName: lastName, passwordConfirmation: passwordConfirmation)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        
        
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(.custom(errorMessage: "No Data")))
                return
            }
            
            
            
            guard let loginResponse = try? JSONDecoder().decode(LoginResponse.self, from: data) else {
                completion(.failure(.invalidCredentials))
                return
            }
            
            
            
            guard let token = loginResponse.token else{
                completion(.failure(.invalidCredentials))
                return
            }
            
            
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

struct RegisterRequestBody : Codable{
    let email: String
    let password: String
    let firstName: String
    let lastName: String
    let passwordConfirmation: String
}

struct LoginResponse : Decodable{
    let token: String?

}
