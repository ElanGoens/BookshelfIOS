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
    
    func login(){
        LoginService().login(username: username, password: password) { (result) in
            switch result{
            case .success(let token):
                print(token)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
