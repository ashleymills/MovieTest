//
//  MovieSummary.swift
//  Movie Test
//
//  Created by Ashley Mills on 05/10/2018.
//  Copyright © 2018 Joylord Systems Ltd. All rights reserved.
//

import UIKit

struct MovieSummary: Decodable {
    let id: Identifier<Movie>
    let title: String
    let backdropPath: Image
    let overview: String
    
    func loadDetail(webService: WebServiceType = WebService(), completion: @escaping Completion<Movie>) {
        let resource = Resource<Movie>(url: WebService.url(withPath: "movie/\(id)"))
        webService.load(resource: resource, completion: completion)
    }
}


