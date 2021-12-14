//
//  UserService.swift
//  BookshelfIOS
//
//  Created by Elan Goens on 10/12/2021.
//

import Foundation
import SwiftUI

class UserService {
    var allUsers = [User]()
    
    var errorMessage : String = ""
    
    func fetchCurrentUser(completion: @escaping (Result<User, NetworkError>) -> ()){
        var authToken = "Bearer "
        authToken += UserDefaults.standard.string(forKey: "token")!
        
        
        guard let url = URL(string: "https://bookshelfapiwebiv.azurewebsites.net/api/Customer")
        else{
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(authToken, forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request) { (data, response, error)  in
            
            if let httpResponse = response as? HTTPURLResponse{
                if httpResponse.statusCode != 200{
                    
                    completion(.failure(.generalError))
                } else{
                    
                    let user = try! JSONDecoder().self.decode(
                        User.self, from: data!
                    )
                    let books = user.boeken
                    
                    DispatchQueue.main.async {
                        
                        
                        completion(.success(user))
                    }
            }
            }
            
        
            //completion(.failure(.generalError))
            
        }.resume()
        
    }
    
    
}

