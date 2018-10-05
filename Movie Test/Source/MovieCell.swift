//
//  MovieCell.swift
//  Movie Test
//
//  Created by Ashley Mills on 05/10/2018.
//  Copyright © 2018 Joylord Systems Ltd. All rights reserved.
//

import UIKit

final class MovieCell: UICollectionViewCell {
    
    @IBOutlet private weak var title: UILabel!
    @IBOutlet private weak var backdrop: UIImageView!

    private (set) var movie: MovieSummary!
    
    func configure(movie: MovieSummary) {
        self.movie = movie
        
        title.text = movie.title
        
        if let image = movie.backdropPath.image(size: .fixed(.w300)) {
            self.configure(backdrop: image)
        }
    }

    func configure(backdrop: UIImage) {
        self.backdrop.image = backdrop
    }
    
    override func prepareForReuse() {
        backdrop.image = nil
    }
}
