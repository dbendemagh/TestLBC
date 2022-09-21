//
//  Constants.swift
//  TestLeboncoin
//
//  Created by Daniel BENDEMAGH on 21/09/2022.
//

import UIKit

enum Constants {
    static let fontName = "HelveticaNeue"
    static let boldFontName = "HelveticaNeue-Bold"
    static let appTintColor = UIColor.orange
}

enum SFSymbols {
    static let magnifyingGlass = UIImage(systemName: "magnifyingglass")
}

enum LBCURL {
    static let basePath = "https://raw.githubusercontent.com/leboncoin/paperclip/master/"
    static let categories = "categories.json"
    static let classifiedADS = "listing.json"
}

enum JsonFile {
    static let categories = "Categories"
    static let classifiedADs = "Listing"
}

enum LBCError: String, Error {
    case invalidURL = "URL invalide"
    case httpError = "Une erreur est survenue. Veuillez vérifier votre connexion Internet."
    case networkError = "Invalid response from the server. Please try again."
    case noData = "Pas de données"
    case invalidData = "Les données reçues ne sont pas valides. Veuillez réessayer."
}
