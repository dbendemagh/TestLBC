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
    static let questionMark = UIImage(systemName: "questionmark.app")
}

enum LBCURL {
    static let basePath = "https://raw.githubusercontent.com/leboncoin/paperclip/master/"
    static let categories = "categories.json"
    static let classifiedADS = "listing.json"
}

enum JsonFile {
    static let categories = "Categories"
    static let classifiedADs = "ClassifiedADS"
}

enum LBCError: String, Error {
    case invalidURL = "URL invalide."
    case httpError = "Les données n'ont pas pu être chargées. Veuillez réessayer."
    case networkError = "Une erreur est survenue. Veuillez vérifier votre connexion Internet."
    case noData = "Pas de données. Veuillez réessayer."
    case invalidData = "Les données reçues ne sont pas valides. Veuillez réessayer."
}

enum Section {
    case categories
    case classifiedADS
}
