//
//  ErrorResponse.swift
//  CoppelMovies
//
//  Created by Jonathan Rivera on 22/10/21.
//

import Foundation

struct ErrorResponse: Codable {
    let statusMessage: String?
    let statusCode: Int?

    enum CodingKeys: String, CodingKey {
        case statusMessage = "status_message"
        case statusCode = "status_code"
    }
}
