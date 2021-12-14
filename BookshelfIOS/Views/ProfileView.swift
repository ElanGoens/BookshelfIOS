//
//  ProfileView.swift
//  BookshelfIOS
//
//  Created by Elan Goens on 04/12/2021.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject private var userViewModel = UserViewModel()
    
    let columns = [GridItem(.fixed(100)),
                   GridItem(.fixed(100))]
    
    var body: some View {
        NavigationView{
            if((userViewModel.user) != nil){
                VStack{
                    Image(systemName: "person.circle.fill")
                    Text(userViewModel.user!.firstName + " " + userViewModel.user!.lastName)
                    Text(userViewModel.user!.email)
                    
                    Spacer()
                    
                    LazyVGrid(columns: columns){
                        ForEach(userViewModel.user!.boeken) { book in
                            Text(book.titel)
                            
                        }
                    }
                    Spacer()
                    
                }
                .background(Color(red: 0.965, green: 0.961, blue: 0.939))
                .navigationTitle("Profile")
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
