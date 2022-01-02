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
    
    func placeReview(rating: Int, reviewTekst: String, boekId: Int, completion: @escaping(Result<String, NetworkError>) -> ()){
        var authToken = "Bearer "
        authToken += UserDefaults.standard.string(forKey: "token")!
        
        guard let url = URL(string: "https://bookshelfapiwebiv.azurewebsites.net/api/Recensie")
        else{
            return
        }
        
        let body = ReviewRequestBody(boekId: boekId, rating: rating, recensieTekst: reviewTekst, customerId: 0)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(authToken, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(.generalError))
                return
            }
            
            guard let reviewResponse = try? JSONDecoder().decode(ReviewResponse.self, from: data) else{
                completion(.failure(.generalError))
                return
            }
            
            guard let userId = reviewResponse.userId else{
                completion(.failure(.generalError))
                return
            }
            
            completion(.success("\(userId)"))
        }.resume()
        
        
    }
    
    func addBookToFavorites(boekId: Int, completion: @escaping (Result<String, NetworkError>) -> ()){
        var authToken = "Bearer "
        authToken += UserDefaults.standard.string(forKey: "token")!
        
        guard let url = URL(string: "https://bookshelfapiwebiv.azurewebsites.net/api/Customer/\(boekId)")
        else{
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue(authToken, forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request){ (data, response, error) in
            
            if let httpResponse = response as? HTTPURLResponse{
                if httpResponse.statusCode != 204{
                    
                    completion(.failure(.generalError))
                } else{
                    
                    
                    
                    DispatchQueue.main.async {
                        
                        
                        completion(.success("Success"))
                    }
            }
            }
            
        }.resume()
    }
    
    func deleteFavoriteBook(boekId: Int, completion: @escaping (Result<String, NetworkError>) -> ()){
        var authToken = "Bearer "
        authToken += UserDefaults.standard.string(forKey: "token")!
        guard let url = URL(string: "https://bookshelfapiwebiv.azurewebsites.net/api/Customer/\(boekId)")
        else{
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue(authToken, forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request){ (data, response, error) in
            
            if let httpResponse = response as? HTTPURLResponse{
                if httpResponse.statusCode != 204{
                    
                    completion(.failure(.generalError))
                } else{
                    
                    
                    
                    DispatchQueue.main.async {
                        
                        
                        completion(.success("Success"))
                    }
            }
            }
            
        }.resume()
    }
    
    
}


struct ReviewRequestBody : Codable{
    let boekId: Int
    let rating: Int
    let recensieTekst: String
    let customerId: Int
}


struct ReviewResponse : Decodable{
    let userId: Int?
   
    
}

