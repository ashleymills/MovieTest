//
//  Collection.swift
//  Movie Test
//
//  Created by Ashley Mills on 05/10/2018.
//  Copyright © 2018 Joylord Systems Ltd. All rights reserved.
//

import Foundation

struct CollectionSummary: Decodable {
    
    let id: Identifier<Collection>
    let name: String
    let backdropPath: Image
    
    func load(webService: WebServiceType = WebService(), completion: @escaping Completion<Collection>) {
        let resource = Resource<Collection>(url: WebService.url(withPath: "collection/\(id)"))
        webService.load(resource: resource, completion: completion)
    }
}
