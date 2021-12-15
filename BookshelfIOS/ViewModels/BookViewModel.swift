//
//  BookViewModel.swift
//  BookshelfIOS
//
//  Created by Elan Goens on 04/12/2021.
//

import Foundation

class BookViewModel : ObservableObject{
    @Published var books = [Book]()
    @Published var reviews = [Review]()
    @Published var errorMessage = ""
    func getAllBooks(){
        print("Start fetch")
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
        print("end fetch")
        self.books = BookService().allBooks
        print(books)
        
        self.errorMessage = BookService().errorMessage
        
        print("vm")
        print(errorMessage)
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
