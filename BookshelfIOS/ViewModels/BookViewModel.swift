//
//  BookViewModel.swift
//  BookshelfIOS
//
//  Created by Elan Goens on 04/12/2021.
//

import Foundation
import SwiftUI

class BookViewModel : ObservableObject{
    @Published var book : Book?
    @Published var books = [Book]()
    @Published var reviews = [Review]()
    @Published var errorMessage = ""
    @Published var filter = ""
    var reviewTekst: String = ""
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
        
    func placeReview(rating: Int, boekId: Int){
        print(rating)
        print(boekId)
        print(reviewTekst)
        
        UserService().placeReview(rating: rating, reviewTekst: reviewTekst, boekId: boekId){
            (result) in
                switch result{
                case .success(let userId):
                    print(userId)
                    let lastId = self.reviews.last!.id
                    self.reviews.append(Review(id: lastId+1, boekId: boekId, rating: rating, recensieTekst: self.reviewTekst, customerId: Int(userId)!))
                    self.getReviewsForBook(id: boekId)
                case .failure(let error): print(error.localizedDescription)
                    self.getReviewsForBook(id: boekId)
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
