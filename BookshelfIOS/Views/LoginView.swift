//
//  ContentView.swift
//  BookshelfIOS
//
//  Created by Elan Goens on 03/12/2021.
//

import SwiftUI

let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0)



struct LoginView: View {

    var body: some View {
        NavigationView{
            VStack{
                InputFieldsView()
                    .navigationTitle("Login")
                    .offset(y: -60)
                
                
                NavigationLink(destination: HomeView(), label: {
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
    @State var username: String = ""
    @State var password: String = ""
    
    var body: some View{
        VStack() {
            TextField("Username", text: $username).padding().background(lightGreyColor).cornerRadius(5.0)
            SecureField("Password", text: $password).padding().background(lightGreyColor).cornerRadius(5.0)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
