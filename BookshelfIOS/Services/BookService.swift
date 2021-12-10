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
    
    
}

enum NetworkError: Error{
    case generalError
}
