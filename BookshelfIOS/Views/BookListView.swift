//
//  BookListView.swift
//  BookshelfIOS
//
//  Created by Elan Goens on 03/12/2021.
//

import SwiftUI

struct BookListView: View {
    
    @StateObject private var bookViewModel = BookViewModel()
    
    var body: some View {
        NavigationView{
            List(bookViewModel.books){ book in
                HStack{
                    AsyncImage(url: URL(string: book.image)) { phase in
                        if let image = phase.image{
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 150)
                                
                        } else if phase.error != nil{
                            Image(systemName: "book").resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 150)
                        } else{
                            Image(systemName: "book").resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 150)
                        }
                    }
                    VStack{
                        Text(book.titel)
                            .fontWeight(.bold)
                        Text(book.auteurNaam)
                        

                    }
                    
                }
        }.navigationTitle("Catalogus")
        
            
        }.onAppear{
            bookViewModel.getAllBooks()
            
        }
    }
}

struct BookListView_Previews: PreviewProvider {
    static var previews: some View {
        BookListView()
    }
}
