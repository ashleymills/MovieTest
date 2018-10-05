//
//  Movie.swift
//  Movie Test
//
//  Created by Ashley Mills on 05/10/2018.
//  Copyright © 2018 Joylord Systems Ltd. All rights reserved.
//

import Foundation

struct Movie: Decodable {
    let id: Identifier<Movie>
    let title: String
    let backdropPath: Image
    let belongsToCollection: CollectionSummary?
    
}
