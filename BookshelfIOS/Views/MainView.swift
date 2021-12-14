//
//  MainView.swift
//  BookshelfIOS
//
//  Created by Elan Goens on 04/12/2021.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var authenticationViewModel: AuthenticationViewModel = .shared
    @StateObject private var bookViewModel = BookViewModel()
    
    var body: some View {
        VStack{
            Button("Logout"){
                
                UserDefaults.standard.removeObject(forKey: "token")
                authenticationViewModel.isAuthenticated = false
            }
            TabView{

                HomeView().tabItem(){
                    Image(systemName: "house")
                    Text("Home")
                }
                
                BookListView().tabItem(){
                    Image(systemName: "book")
                    Text("Catalogus")
                }.task {
                    bookViewModel.getAllBooks()
                }
                ProfileView().tabItem(){
                    Image(systemName: "person.circle")
                    Text("Profile")
                }
            }.background(Color.white)
           
           
       }
        }
        
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
