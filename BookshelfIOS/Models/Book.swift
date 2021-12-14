//
//  File.swift
//  BookshelfIOS
//
//  Created by Elan Goens on 04/12/2021.
//

import Foundation

struct Book : Identifiable, Codable{
    var id: Int
    var titel: String
    var auteurNaam: String
    var omschrijving: String
    var image: String
    var genre: String
}
