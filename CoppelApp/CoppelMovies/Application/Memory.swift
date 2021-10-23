//
//  Memory.swift
//  CoppelMovies
//
//  Created by Jonathan Rivera on 22/10/21.
//

import Foundation

struct Memory {
    
    static let memory = Memory()
    private let defaults = UserDefaults.standard
    
    func getToken() -> String {
        return defaults.string(forKey: AppConstans.TOKEN) ?? ""
    }
    
    func setToken(token: String?) {
        defaults.set(token, forKey: AppConstans.TOKEN)
    }
    
    func userIsLogged(isLogged: Bool) {
        defaults.set(isLogged, forKey: AppConstans.LOGGED)
    }
    
    func getUserIsLogged() -> Bool {
        return defaults.bool(forKey: AppConstans.LOGGED)
    }
}
