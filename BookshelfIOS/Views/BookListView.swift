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
            
            VStack{
                if(bookViewModel.errorMessage != ""){
                    Text("Error")
                }
                
                
                
                
                List(bookViewModel.books){ book in
                    NavigationLink(destination: BookDetailView(book: book)){
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
                    }
                    
                    
                }
                .background(Color.black)
                    .navigationTitle("Catalogus")
                Spacer()
            }.background(Color(red: 0.965, green: 0.961, blue: 0.939))
            
            
            
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
