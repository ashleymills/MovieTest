//
//  Resource.swift
//  Movie Test
//
//  Created by Ashley Mills on 05/10/2018.
//  Copyright © 2018 Joylord Systems Ltd. All rights reserved.
//

import UIKit

struct Resource<A> {
    
    let url: URL
    let parse: (Data) throws -> A
    
    init(url: URL, parse: @escaping (Data) -> A) {
        self.url = url
        self.parse = parse
    }
}

extension Resource where A: Decodable {
    init(url: URL) {
        self.url = url
        
        parse = { data in
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = .iso8601
            return try decoder.decode(A.self, from: data)
        }
    }
}

extension URLRequest {
    init<A>(resource: Resource<A>) {
        self.init(url: resource.url)
        setValue("application/json", forHTTPHeaderField: "Content-Type")
    }
}
