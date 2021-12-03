//
//  AuthenticationViewModel.swift
//  BookshelfIOS
//
//  Created by Elan Goens on 03/12/2021.
//

import Foundation

class AuthenticationViewModel : ObservableObject{
    var username: String = ""
    var password: String = ""
    @Published var isAuthenticated: Bool = false
    
    func login(){
        
        let userDefaults = UserDefaults.standard
        
        LoginService().login(username: username, password: password) { (result) in
            switch result{
            case .success(let token):
                print(token)
                userDefaults.setValue(token, forKey: "token")
                DispatchQueue.main.async {
                    self.isAuthenticated = true
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
