//
//  LoginModel.swift
//  CoppelMovies
//
//  Created by Jonathan Rivera on 22/10/21.
//

import Foundation

struct LoginModel: Codable {
    let username: String
    let password: String
    let request_token: String
}
