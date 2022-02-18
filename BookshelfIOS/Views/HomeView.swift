//
//  HomeView.swift
//  BookshelfIOS
//
//  Created by Elan Goens on 03/12/2021.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView{
            VStack{
                
                AboutView()
                NewItemView()

                Spacer()
                
                Divider()
            }
            .background(Color(red: 0.965, green: 0.961, blue: 0.939))
            .navigationTitle("Bookshelf")
        }.phoneOnlyStackNavigationView()
        
    }
}

struct AboutView: View{
    var body: some View{
        VStack{
            Text("Over Bookshelf").fontWeight(.bold).font(.system(size: 20)).padding(.top)
            Text("Bookshelf is een website gemaakt in samenwerking met bibliotheek De Krook. Op onze website kunt u onze catalogus raadplegen en boeken toevoegen aan uw favorieten. Daarnaast kunt u ook een plaats reserveren in bibliotheek De Krook om te studeren.")
                .padding(20.0)
        }
        .background(Color.white)
        .frame(width: nil)
        .cornerRadius(5)
        .padding(20.0)
    }
}

struct NewItemView: View{
    
    @StateObject private var bookViewModel = BookViewModel()
    
    var body: some View{
        
        VStack{
            Text("Nieuw in de bib").fontWeight(.bold).font(.system(size: 20)).padding(.top)
            if(bookViewModel.book != nil){
                HStack{
                    AsyncImage(url: URL(string: bookViewModel.book!.image)) { phase in
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
                        
                        
                    }.padding(20.0)
                    VStack{
                        Text(bookViewModel.book!.titel).bold().padding(10)
                        Text(bookViewModel.book!.auteurNaam)
                    }
                }
                
            }
        }
        .background(Color.white)
        .frame(width: nil)
        .cornerRadius(5)
        .padding(20.0)
        .onAppear{
            bookViewModel.getOneBook()
        }
    }
}

extension View {
    @ViewBuilder func phoneOnlyStackNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.navigationViewStyle(.stack)
        } else {
            self
        }
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
