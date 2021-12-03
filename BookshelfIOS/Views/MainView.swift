//
//  MainView.swift
//  BookshelfIOS
//
//  Created by Elan Goens on 04/12/2021.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView{
            HomeView().tabItem(){
                Text("Home")
            }
            
            BookListView().tabItem(){
                Text("Book list")
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
