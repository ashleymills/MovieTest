//
//  NowPlaying.swift
//  Movie Test
//
//  Created by Ashley Mills on 05/10/2018.
//  Copyright © 2018 Joylord Systems Ltd. All rights reserved.
//

import Foundation

struct NowPlaying: Decodable {
    
    let results: [MovieSummary]
    
    static func load(webService: WebServiceType = WebService(), completion: @escaping Completion<NowPlaying>) {
        let resource = Resource<NowPlaying>(url: WebService.url(withPath: "movie/now_playing"))
        webService.load(resource: resource, completion: completion)
    }
}
