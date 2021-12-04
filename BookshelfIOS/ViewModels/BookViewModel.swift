//
//  BookViewModel.swift
//  BookshelfIOS
//
//  Created by Elan Goens on 04/12/2021.
//

import Foundation

class BookViewModel : ObservableObject{
    @Published var books = [Book]()
    
    func getAllBooks(){
        print("Start fetch")
        BookService().fetchAllBooks { (books) in
            self.books = books
        }
        print("end fetch")
        self.books = BookService().allBooks
        print(books)
    }
}
