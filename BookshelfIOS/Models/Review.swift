//
//  Review.swift
//  BookshelfIOS
//
//  Created by Elan Goens on 15/12/2021.
//

import Foundation

struct Review: Identifiable, Codable{
    var id: Int
    var boekId: Int
    var rating: Int
    var recensieTekst: String
    var customerId: Int
}
