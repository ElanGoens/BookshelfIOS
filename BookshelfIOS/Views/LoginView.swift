//
//  ContentView.swift
//  BookshelfIOS
//
//  Created by Elan Goens on 03/12/2021.
//

import SwiftUI

let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0)


struct LoginView: View {
    
    @ObservedObject private var authenticationViewModel: AuthenticationViewModel = .shared
    var body: some View {
        
            if(authenticationViewModel.isAuthenticated){
                MainView()
            }else {
                VStack{
                    
                    InputFieldsView()
                        .navigationTitle("Login")
                        .offset(y: -60)
                    if(authenticationViewModel.authenticationFailed){
                        Text("Your credentials are incorrect")
                    }
               
                    NavigationLink(destination: MainView(), label: {
                        Text("Next screen").bold().frame(width: 280, height: 50)
                            .background(Color.blue)
                            .foregroundColor(Color.white)
                            .cornerRadius(10)
                    })
                    
                    
                }
            }
            

        

    }
}

struct InputFieldsView: View{
    //soort van observer pattern, als username verandert gebeurt er een rerender
    
    
    @ObservedObject var authenticationViewModel: AuthenticationViewModel = .shared
    
    var body: some View{
        NavigationView{
            VStack() {
                TextField("Username", text: $authenticationViewModel.username).padding().background(lightGreyColor).cornerRadius(5.0)
                    .navigationTitle("Login")
                SecureField("Password", text: $authenticationViewModel.password).padding().background(lightGreyColor).cornerRadius(5.0)
                Button("Login"){
                    print(authenticationViewModel.username)
                    print(authenticationViewModel.password)
                    authenticationViewModel.login()
                    
                }
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
