//
//  CollectionViewController.swift
//  Movie Test
//
//  Created by Ashley Mills on 05/10/2018.
//  Copyright © 2018 Joylord Systems Ltd. All rights reserved.
//

import UIKit

class CollectionViewController: UICollectionViewController, ViewControllerAlerting {
    
    @IBOutlet private weak var flowLayout: UICollectionViewFlowLayout!
    
    private var collection: CollectionSummary!
    private var movies: [MovieSummary] = []

    func configure(collection: CollectionSummary) {
        self.collection = collection
        
        navigationItem.title = collection.name
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection.load { result in
            switch result {
            case let .success(collection):
                self.movies = collection.parts
                self.collectionView.reloadData()
            case let .failure(error):
                self.presentAlert(for: error)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch (segue.destination, sender) {
        case let (mvc as MovieViewController, cell as MovieCell):
            mvc.configure(movie: cell.movie, showCollection: false)
        default:
            break
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as MovieCell
        let movie = movies[indexPath.item]
        cell.configure(movie: movie)
        
        if movie.backdropPath.image(size: .fixed(.w300)) == nil {
            movie.backdropPath.load(size: .fixed(.w300)) { [weak cell] result in
                if case let .success(image) = result, let backdrop = image {
                    cell?.configure(backdrop: backdrop)
                }
            }
        }
        
        return cell
    }
}

extension CollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let numberOfColumns = 2
        let sideInsets = flowLayout.sectionInset.left + flowLayout.sectionInset.right
        let width = collectionView.bounds.width
        let spacing = flowLayout.minimumInteritemSpacing
        
        let cellWidth = trunc(width - sideInsets - (CGFloat(numberOfColumns - 1) * spacing)) / CGFloat(numberOfColumns)
        return CGSize(width: cellWidth, height: cellWidth * 1.25)
    }
}
