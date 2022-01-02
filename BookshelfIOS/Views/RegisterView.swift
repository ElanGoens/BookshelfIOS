//
//  RegisterView.swift
//  BookshelfIOS
//
//  Created by Elan Goens on 01/01/2022.
//

import SwiftUI



struct RegisterView: View {
    @ObservedObject private var authenticationViewModel: AuthenticationViewModel = .shared
    var body: some View {
        VStack{
            if(authenticationViewModel.isAuthenticated){
                MainView()
            }else {
            InputFieldsRegisterView()
                .navigationTitle("Registreer")
                .offset(y: -60)
            }
        }
    }
}

struct InputFieldsRegisterView: View{
    //soort van observer pattern, als username verandert gebeurt er een rerender
    
    
    @ObservedObject var authenticationViewModel: AuthenticationViewModel = .shared
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    
    var body: some View{
        
            VStack() {
                HStack{
                    Spacer()
                    Spacer()
                    TextField("Voornaam", text: $firstName).padding().background(lightGreyColor).cornerRadius(5.0)
                        .navigationTitle("Registreer")
                    Spacer()
                    Spacer()
                }
                HStack{
                    Spacer()
                    Spacer()
                    TextField("Familienaam", text: $lastName).padding().background(lightGreyColor).cornerRadius(5.0)
                    Spacer()
                    Spacer()
                }
                HStack{
                    Spacer()
                    Spacer()
                    TextField("Email", text: $email).padding().background(lightGreyColor).cornerRadius(5.0)
                    Spacer()
                    Spacer()
                }
                HStack{
                    Spacer()
                    Spacer()
                    SecureField("Wachtwoord", text: $password).padding().background(lightGreyColor).cornerRadius(5.0)
                    Spacer()
                    Spacer()
                }
                HStack{
                    Spacer()
                    Spacer()
                    SecureField("Herhaal Wachtwoord", text: $confirmPassword).padding().background(lightGreyColor).cornerRadius(5.0)
                    Spacer()
                    Spacer()
                }
                    
                Button("Registreer"){
                    print(email)
                    print(password)
                    
                    authenticationViewModel.register(firstName: firstName, lastName: lastName, email: email, password: password, confirmPassword: confirmPassword)
                    
                }
                
                if(authenticationViewModel.emptyFieldsValidation){
                    Text("Alle velden moeten ingevuld zijn").foregroundColor(Color.red)
                }
                if(authenticationViewModel.emailValidation){
                    Text("U moet een geldig email-adres opgeven").foregroundColor(Color.red)
                }
                
                if(authenticationViewModel.passwordsNotTheSame){
                    Text("Wachtwoorden komen niet overeen").foregroundColor(Color.red)
                }
                if(authenticationViewModel.passwordValidation){
                    Text("Uw wachtwoord moet ten minste een hoofdletter, kleine letter, cijfer en een speciaal teken bevatten").foregroundColor(Color.red)
                }
            }
        
        
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
