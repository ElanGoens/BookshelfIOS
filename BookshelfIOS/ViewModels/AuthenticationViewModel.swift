//
//  AuthenticationViewModel.swift
//  BookshelfIOS
//
//  Created by Elan Goens on 03/12/2021.
//

import Foundation

class AuthenticationViewModel : ObservableObject{
    
    @Published var isAuthenticated: Bool = (UserDefaults.standard.string(forKey: "token") != nil)
    @Published var authenticationFailed = false
    @Published var emptyFieldsValidation = false
    @Published var passwordsNotTheSame = false
    @Published var emailValidation = false
    @Published var passwordValidation = false
    
    private init() {
        
    }
    
    static let shared = AuthenticationViewModel()
    
    func login(email: String, password: String){

        LoginService().login(username: email, password: password) { (result) in
            switch result{
            case .success(let token):
                print(token)
                UserDefaults.standard.set(token, forKey: "token")
                
                DispatchQueue.main.async {
                    self.isAuthenticated = true
                    self.authenticationFailed = false
                }
            case .failure(let error):
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    self.isAuthenticated = false
                    self.authenticationFailed = true
                }
            }
            
            print(self.isAuthenticated)
        }
    }
    
    func register(firstName: String, lastName: String, email: String, password: String, confirmPassword: String){
        
        // Clientside validation
        if(firstName.isEmpty || lastName.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty){
            self.emptyFieldsValidation = true
            return
        }else{
            self.emptyFieldsValidation = false
        }
        if(password != confirmPassword){
            self.passwordsNotTheSame = true
            return
        }else{
            self.passwordsNotTheSame = false
        }
        if(!email.contains("@") && !email.contains(".")){
            self.emailValidation = true
            return
        }else{
            self.emailValidation = false
        }
        if(!password.isValidPassword()){
            passwordValidation = true
            return
        }else{
            passwordValidation =  false
            
        }
        
        
        
        LoginService().register(firstName: firstName, lastName: lastName, username: email, password: password, passwordConfirmation: confirmPassword){ (result) in
            switch result{
            case .success(let token):
                print(token)
                UserDefaults.standard.set(token, forKey: "token")
                
                DispatchQueue.main.async {
                    self.isAuthenticated = true
                    self.authenticationFailed = false
                }
            case .failure(let error):
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    self.isAuthenticated = false
                    self.authenticationFailed = true
                }
            }
            
            print(self.isAuthenticated)
        }
    }
    
    
}

extension String {
    func isValidPassword() -> Bool {
        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[ !\"\\\\#$%&'()*+,-./:;<=>?@\\[\\]^_`{|}~])[A-Za-z\\d !\"\\\\#$%&'()*+,-./:;<=>?@\\[\\]^_`{|}~]{8,}"
        //safe to escape all regex chars
        //let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[ !\"\\\\#$%&'\\(\\)\\*+,\\-\\./:;<=>?@\\[\\]^_`\\{|\\}~])[A-Za-z\\d !\"\\\\#$%&'\\(\\)\\*+,\\-\\./:;<=>?@\\[\\]^_`\\{|\\}~]{8,}"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: self)
    }
}
