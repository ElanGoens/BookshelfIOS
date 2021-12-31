//
//  ProfileView.swift
//  BookshelfIOS
//
//  Created by Elan Goens on 04/12/2021.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject private var userViewModel = UserViewModel()
    @ObservedObject var authenticationViewModel: AuthenticationViewModel = .shared
    
    let columns = [GridItem(.fixed(100)),
                   GridItem(.fixed(100)),
                   GridItem(.fixed(100))]
    
    var body: some View {
        NavigationView{
            if((userViewModel.user) != nil){
                VStack{
                    
                    Image(systemName: "person.circle.fill").resizable()
                        .frame(width: 50.0, height: 50.0).padding()
                    Spacer()
                    Text(userViewModel.user!.firstName + " " + userViewModel.user!.lastName).bold()
                    Text(userViewModel.user!.email)
                    
                    Spacer()
                    Text("Favoriete boeken: ").padding()
                    ScrollView{
                        LazyVGrid(columns: columns){
                            ForEach(userViewModel.user!.boeken) { book in
                                VStack{
                                    AsyncImage(url: URL(string: book.image)) { phase in
                                        if let image = phase.image{
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 75)
                                            
                                        } else if phase.error != nil{
                                            Image(systemName: "book").resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 75)
                                        } else{
                                            Image(systemName: "book").resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 75)
                                        }
                                    }
                                    Text(book.titel).font(.system(size: 12))
                                    Button{
                                        userViewModel.deleteBookFromFavorites(boekId: book.id)
                                        
                                    } label: {
                                        Image(systemName: "trash").foregroundColor(Color.red).padding()
                                    }
                                }
                                
                                
                            }
                        }
                    }
                    
                    
                    Button("Logout"){
                        
                        UserDefaults.standard.removeObject(forKey: "token")
                        authenticationViewModel.isAuthenticated = false
                    }.padding(.bottom).foregroundColor(Color.red)
                    
                    Divider()
                    
                }
                .background(Color(red: 0.965, green: 0.961, blue: 0.939))
                .navigationTitle("Profiel")
            }
            
            
        }.onAppear{
            userViewModel.getCurrentUser()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
