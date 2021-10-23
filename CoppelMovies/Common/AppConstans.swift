//
//  AppConstans.swift
//  CoppelMovies
//
//  Created by Jonathan Rivera on 21/10/21.
//

import Foundation
import UIKit

struct AppConstans {
    
    static var keyWindow: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        } else {
            return UIApplication.shared.keyWindow
        }
    }
    
    static let API_KEY = "634b49e294bd1ff87914e7b9d014daed"
    static let URL = "https://api.themoviedb.org/3/"
    static let NEW_TOKEN = "authentication/token/new?api_key="
    static let LOGIN = "authentication/token/validate_with_login?api_key="
    static let IMAGE_URL = "https://image.tmdb.org/t/p/w500/"
    static let URL_DETAIL = "https://api.themoviedb.org/3/movie/"
    
    static let TOKEN = "token"
    static let LOGGED = "loggedIn"
    
    struct AlertController {
        static let TITLE = "Entendido"
    }
    
    struct Errors {
        static let GENERIC_ERROR_TITLE = "No eres tu somos nosotros."
    }
}
