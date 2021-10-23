//
//  MovieModel.swift
//  CoppelMovies
//
//  Created by Jonathan Rivera on 22/10/21.
//

import Foundation

struct MovieModel: Codable {
    let page: Int?
    let results: [MovieResult]?
    let totalResults, totalPages: Int?
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
}

struct MovieResult: Codable {
    let posterPath: String?
    let overview: String?
    let releaseDate: String?
    let first_air_date: String?
    let original_name: String?
    let originalTitle: String?
    let backdropPath: String?
    let voteAverage: Double?
    
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case overview
        case first_air_date
        case original_name
        case releaseDate = "release_date"
        case originalTitle = "original_title"
        case backdropPath = "backdrop_path"
        case voteAverage = "vote_average"
    }
}
