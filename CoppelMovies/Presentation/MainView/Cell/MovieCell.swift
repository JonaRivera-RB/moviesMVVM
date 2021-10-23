//
//  MovieCell.swift
//  CoppelMovies
//
//  Created by Jonathan Rivera on 22/10/21.
//

import Foundation
import UIKit
import SDWebImage

class MovieCell: UICollectionViewCell {
    static let IDENTIFIER = "MovieCell"
    
    @IBOutlet weak private(set) var imageMoview: UIImageView!
    @IBOutlet weak private(set) var titleLabel: UILabel!
    @IBOutlet weak private(set) var dateLabel: UILabel!
    @IBOutlet weak private(set) var raitingLabel: UILabel!
    @IBOutlet weak private(set) var descriptionLabel: UILabel!
    
    public var movie: MovieResult? {
        didSet {
            setupMovie()
        }
    }
    
    private func setupMovie() {
        guard let movie = movie else { return }
        
        imageMoview.sd_setImage(with: URL(string: AppConstans.IMAGE_URL + (movie.posterPath ?? "")))
        titleLabel.text = movie.originalTitle == nil ? movie.original_name : movie.originalTitle
        dateLabel.text = movie.releaseDate == nil ? movie.first_air_date : movie.releaseDate
        raitingLabel.text = String(movie.voteAverage ?? 0.0)
        descriptionLabel.text = movie.overview
    }
    
}
