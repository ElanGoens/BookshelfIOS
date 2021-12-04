//
//  MainView.swift
//  BookshelfIOS
//
//  Created by Elan Goens on 04/12/2021.
//

import SwiftUI

struct MainView: View {
    @StateObject private var bookViewModel = BookViewModel()
    var body: some View {
        TabView{
            HomeView().tabItem(){
                Text("Home")
            }
            
            BookListView().tabItem(){
                Text("Catalogus")
            }.task {
                bookViewModel.getAllBooks()
            }
        }
       
       
   }
    
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
