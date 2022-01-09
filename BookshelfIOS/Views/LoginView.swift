//
//  ContentView.swift
//  BookshelfIOS
//
//  Created by Elan Goens on 03/12/2021.
//

import SwiftUI

let lightGrey = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0)


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
                
                }
            }

    }
}

struct InputFieldsView: View{
    //soort van observer pattern, als username verandert gebeurt er een rerender
    
    
    @ObservedObject var authenticationViewModel: AuthenticationViewModel = .shared
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View{
        NavigationView{
            VStack() {
                HStack{
                    Spacer()
                    Spacer()
                    TextField("Email", text: $email).padding().background(lightGrey).cornerRadius(5.0)
                        .navigationTitle("Login")
                    Spacer()
                    Spacer()
                }
                HStack{
                    Spacer()
                    Spacer()
                    SecureField("Password", text: $password).padding().background(lightGrey).cornerRadius(5.0)
                    Spacer()
                    Spacer()
                }
                
                Button("Login"){
                    print(email)
                    print(password)
                    authenticationViewModel.login(email: email, password: password)
                    
                
                    
                }
                NavigationLink(destination: RegisterView(), label: {
                    Text("Nog geen account? Registreer hier.").bold().frame(width: 350, height: 50)
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                })
                if(authenticationViewModel.authenticationFailed){
                    Text("Uw gebruikersnaam of wachtwoord is incorrect").foregroundColor(Color.red)
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
