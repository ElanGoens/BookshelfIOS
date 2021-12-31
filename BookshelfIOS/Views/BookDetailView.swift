//
//  BookDetailView.swift
//  BookshelfIOS
//
//  Created by Elan Goens on 15/12/2021.
//

import SwiftUI

struct BookDetailView: View {
    
    @StateObject private var bookViewModel = BookViewModel()
    @ObservedObject private var userViewModel = UserViewModel()
    
    
    var book: Book?
    
    var body: some View {
        if book != nil{
            VStack{
                Text(book!.titel).bold().font(.system(size: 18)).padding()
                AsyncImage(url: URL(string: book!.image)) { phase in
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
                
                HStack{
                    Text("Auteur: ").bold()
                    Text(book!.auteurNaam)
                }
                HStack{
                    Text("Genre: ").bold()
                    Text(book!.genre)
                }
                NavigationLink(destination: ProfileView()){
                    Button("Voeg toe aan favorieten"){
                        Task{
                            userViewModel.addBookToFavorites(boekId: book!.id)
                        }
                    }
                }
                
                Divider()
                
                
                
                
                ScrollView{
                    Text(book!.omschrijving).padding()
                    
                    Section{
                        TextEditor(text: $userViewModel.reviewTekst)
                        StarRatingView(rating: $userViewModel.rating)
                    } header: {
                        Text("Schrijf een review")
                    }
                    
                    if(!bookViewModel.reviews.isEmpty){
                        
                        Text("Reviews").bold()
                        Divider()
                        VStack{
                            
                            ForEach(bookViewModel.reviews){ review in
                                StarRatingView(rating: .constant(review.rating), label: review.recensieTekst)
                            }
                        }
                    }

                    
                }.onAppear{
                    bookViewModel.getReviewsForBook(id: book!.id)
                }
                
                
                
                
                
            }.navigationTitle("").navigationBarTitleDisplayMode(.inline)
                .background(Color(red: 0.965, green: 0.961, blue: 0.939))
            
        }
    }
}

struct StarRatingView: View{
    @Binding var rating: Int
    var label = ""
    var max = 5
    
    var offImage: Image?
    var onImage = Image(systemName: "star.fill")
    
    var offColor = Color.gray
    var onColor = Color.yellow
    
    var body: some View{
        VStack{
            
            HStack{
                ForEach(1..<max + 1, id: \.self) { number in
                    
                    image(for: number)
                        .foregroundColor(number > rating ? offColor : onColor)
                        .onTapGesture{
                            rating = number
                            print(rating)
                            
                        }
                    
                }
            }
            Text(label).padding()
            
        }

    }
    
    func image(for number: Int) -> Image{
        if number > rating {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
}

struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BookDetailView()
    }
}
