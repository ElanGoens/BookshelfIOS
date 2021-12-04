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
    @Published var isAuthenticated: Bool = UserDefaults.standard.bool(forKey: "token")
    @Published var authenticationFailed = false
    
    private init() {
        
    }
    
    static let shared = AuthenticationViewModel()
    
    func login(){
        
        let userDefaults = UserDefaults.standard
        
        LoginService().login(username: username, password: password) { (result) in
            switch result{
            case .success(let token):
                print(token)
                userDefaults.setValue(token, forKey: "token")
                
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
