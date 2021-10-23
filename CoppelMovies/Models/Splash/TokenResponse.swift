//
//  TokenResponse.swift
//  CoppelMovies
//
//  Created by Jonathan Rivera on 21/10/21.
//

import Foundation

struct TokenResponse: Codable {
    let success: Bool?
    let expiresAt: String?
    let requestToken: String?

    enum CodingKeys: String, CodingKey {
        case success
        case expiresAt = "expires_at"
        case requestToken = "request_token"
    }
}
