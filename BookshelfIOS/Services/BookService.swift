//
//  BookService.swift
//  BookshelfIOS
//
//  Created by Elan Goens on 04/12/2021.
//

import Foundation
import SwiftUI

class BookService {
    var allBooks = [Book]()
    var allReviews = [Review]()
    var errorMessage : String = ""
    
    func fetchAllBooks(completion: @escaping (Result<[Book], NetworkError>) -> ()){
        guard let url = URL(string: "https://bookshelfapiwebiv.azurewebsites.net/api/Boeken")
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
                    let books = try! JSONDecoder().self.decode(
                        [Book].self, from: data!
                    )
                    DispatchQueue.main.async {
                        self.allBooks = books
                        
                        completion(.success(books))
                    }
            }
            }
            
        
            //completion(.failure(.generalError))
            
        }.resume()
        
    }
    
    func fetchOneBook(completion: @escaping (Result<Book, NetworkError>) -> ()){
        guard let url = URL(string: "https://bookshelfapiwebiv.azurewebsites.net/api/Boeken/1")
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
                    let book = try! JSONDecoder().self.decode(
                        Book.self, from: data!
                    )
                    DispatchQueue.main.async {
                        
                        
                        completion(.success(book))
                    }
            }
            }
            
        
            //completion(.failure(.generalError))
            
        }.resume()
        
    }
    
    func fetchBooksWithFilter(filter: String, completion: @escaping (Result<[Book], NetworkError>) -> ()){
        guard let url = URL(string: "https://bookshelfapiwebiv.azurewebsites.net/api/Boeken?titel=\(filter)")
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
                    let books = try! JSONDecoder().self.decode(
                        [Book].self, from: data!
                    )
                    DispatchQueue.main.async {
                        self.allBooks = books
                        
                        completion(.success(books))
                    }
            }
            }
            
        
            //completion(.failure(.generalError))
            
        }.resume()
    }
    
    func fetchAllReviewsForBook(id: Int, completion: @escaping (Result<[Review], NetworkError>) -> ()){
        guard let url = URL(string: "https://bookshelfapiwebiv.azurewebsites.net/api/Recensie/\(id)")
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
                    let reviews = try! JSONDecoder().self.decode(
                        [Review].self, from: data!
                    )
                    DispatchQueue.main.async {
                        self.allReviews = reviews
                        
                        completion(.success(reviews))
                    }
            }
            }
            
        
            //completion(.failure(.generalError))
            
        }.resume()
        
    }
    
    
}

enum NetworkError: Error{
    case generalError
}
