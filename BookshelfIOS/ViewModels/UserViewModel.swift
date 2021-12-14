//
//  UserViewModel.swift
//  BookshelfIOS
//
//  Created by Elan Goens on 10/12/2021.
//

import Foundation

class UserViewModel : ObservableObject{
    @Published var user: User?
    
    @Published var errorMessage = ""
    func getCurrentUser(){
        print("Start fetch")
        UserService().fetchCurrentUser { (result) in
            switch result{
            case .success(let user):
                print("User: ")
                print(user)
                DispatchQueue.main.async {
                    self.user = user
                }
                
            case .failure(let error):
                DispatchQueue.main.async {
                    self.errorMessage = error.localizedDescription
                }
            }
            
        }
        print("end fetch")
    }
}