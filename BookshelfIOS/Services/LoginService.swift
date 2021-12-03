//
//  LoginService.swift
//  BookshelfIOS
//
//  Created by Elan Goens on 03/12/2021.
//

import Foundation

class LoginService{
    func login(username: String, password: String){
        
        guard let url = URL(string: "https://bookshelfapiwebiv.azurewebsites.net/api/Account/Login") else{
            
            return
        }
        
        let body = LoginRequestBody(username: username, password: password)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
    }
}

struct LoginRequestBody : Codable{
    let username: String
    let password: String
}
