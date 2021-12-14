//
//  User.swift
//  BookshelfIOS
//
//  Created by Elan Goens on 10/12/2021.
//

import Foundation

struct User : Codable{
    var firstName: String
    var lastName: String
    var email: String
    var boeken: [Book]
}
