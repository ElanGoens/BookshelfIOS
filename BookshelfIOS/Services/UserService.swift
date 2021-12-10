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
        guard let url = URL(string: "https://bookshelfapiwebiv.azurewebsites.net/api/Customer")
        else{
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { (data, response, error)  in
            
            if let httpResponse = response as? HTTPURLResponse{
                if httpResponse.statusCode != 200{
                    
                    completion(.failure(.generalError))
                } else{
                    let user = try! JSONDecoder().self.decode(
                        User.self, from: data!
                    )
                    DispatchQueue.main.async {
                        
                        
                        completion(.success(user))
                    }
            }
            }
            
        
            //completion(.failure(.generalError))
            
        }.resume()
        
    }
    
    
}

