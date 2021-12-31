//
//  BookViewModel.swift
//  BookshelfIOS
//
//  Created by Elan Goens on 04/12/2021.
//

import Foundation

class BookViewModel : ObservableObject{
    @Published var book : Book?
    @Published var books = [Book]()
    @Published var reviews = [Review]()
    @Published var errorMessage = ""
    @Published var filter = ""
    func getAllBooks(){
        print("Start fetch")
        
        if filter == "" {
            BookService().fetchAllBooks { (result) in
                switch result{
                case .success(let books):
                    print("Books: ")
                    print(books)
                    DispatchQueue.main.async {
                        self.books = books
                    }
                    
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.errorMessage = error.localizedDescription
                    }
                }
                
            }
            
            self.books = BookService().allBooks
            self.errorMessage = BookService().errorMessage
        }
        
        else {
            BookService().fetchBooksWithFilter(filter: self.filter){ (result) in
                switch result{
                case .success(let books):
                    print("Books: ")
                    print(books)
                    DispatchQueue.main.async {
                        self.books = books
                    }
                    
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.errorMessage = error.localizedDescription
                    }
                }
                
            }
            
            self.books = BookService().allBooks
            self.errorMessage = BookService().errorMessage
        }
    }
    
    func getOneBook(){
        BookService().fetchOneBook { (result) in
            switch result{
            case .success(let book):
                
                DispatchQueue.main.async {
                    self.book = book
                }
                
            case .failure(let error):
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                }
            }
            
        }
    }
        
 
    func getReviewsForBook(id: Int){
        BookService().fetchAllReviewsForBook(id: id){ (result) in
            switch result{
            case .success(let reviews): print(reviews)
                DispatchQueue.main.async {
                    self.reviews = reviews
                }
            case .failure(let error): DispatchQueue.main.async {
                self.errorMessage = error.localizedDescription
            }
            }
            
        }
    }

}
