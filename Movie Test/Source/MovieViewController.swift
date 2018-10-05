//
//  MovieViewController.swift
//  Movie Test
//
//  Created by Ashley Mills on 05/10/2018.
//  Copyright © 2018 Joylord Systems Ltd. All rights reserved.
//

import UIKit

class MovieViewController: UITableViewController, ViewControllerAlerting {

    @IBOutlet private weak var backdrop: UIImageView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var overview: UILabel!
    @IBOutlet weak var collectionNameContainer: UIView!
    @IBOutlet weak var collectionName: UILabel!
    @IBOutlet weak var collectionCell: UITableViewCell!
    
    private var movieSummary: MovieSummary!
    private var movieDetails: Movie?
    private var showCollection: Bool!

    func configure(movie: MovieSummary, showCollection: Bool) {
        self.movieSummary = movie
        self.showCollection = showCollection
        
        navigationItem.title = movie.title
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        update(summary: movieSummary)

        if showCollection {
            loadDetails()
        } else {
            collectionNameContainer.isHidden = true
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if let cell =  sender as? UITableViewCell, cell == collectionCell {
            if let collection = movieDetails?.belongsToCollection {
                performSegue(withIdentifier: identifier, sender: collection)
            }
            return false
        }
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch (segue.destination, sender) {
        case let (cvc as CollectionViewController, collection as CollectionSummary):
            cvc.configure(collection: collection)
        default:
            break
        }
    }
}

private extension MovieViewController {
    
    func loadDetails() {
        spinner.startAnimating()
        movieSummary.loadDetail { [weak self] result in
            self?.spinner.stopAnimating()
            switch result {
            case let .success(movie):
                self?.movieDetails = movie
                self?.update(details: movie)
            case let .failure(error):
                self?.presentAlert(for: error)
            }
        }
    }
    func update(summary: MovieSummary) {
        overview.text = summary.overview
        
        let image = summary.backdropPath.image(size: .original)
        backdrop.image = image
        if image == nil {
            summary.backdropPath.load(size: .original) { [weak self] result in
                if case let .success(image) = result {
                    self?.backdrop.image = image
                }
            }
        }
    }

    func update(details: Movie) {
        collectionNameContainer.backgroundColor = .clear
        if let collection = details.belongsToCollection {
            collectionName.isHidden = false
            collectionName.text = collection.name
            collectionCell.accessoryType = .disclosureIndicator
            collectionCell.selectionStyle = .default
        }
    }
}
