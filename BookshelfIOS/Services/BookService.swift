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
    func fetchAllBooks(completion: @escaping ([Book]) -> ()){
        let url = URL(string: "https://bookshelfapiwebiv.azurewebsites.net/api/Boeken")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            do{
                let books = try JSONDecoder().self.decode([Book].self, from: data!)
                DispatchQueue.main.async {
                    self.allBooks = books
                    completion(books)
                }
            } catch{
                print(error.localizedDescription)
            }
        }.resume()
        
    }
    
    
}
