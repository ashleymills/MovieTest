//
//  Collection.swift
//  Movie Test
//
//  Created by Ashley Mills on 05/10/2018.
//  Copyright © 2018 Joylord Systems Ltd. All rights reserved.
//

import Foundation

struct Collection: Decodable {
    
    let id: Identifier<Collection>
    let name: String
    let backdropPath: Image
    let parts: [MovieSummary]    
}
