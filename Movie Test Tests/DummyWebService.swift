//
//  DummyWebService.swift
//  Movie Test Tests
//
//  Created by Ashley Mills on 05/10/2018.
//  Copyright © 2018 Joylord Systems Ltd. All rights reserved.
//

import Foundation
@testable import Movie_Test

class DummyWebService: WebServiceType {
    let data: Data
    
    init(jsonData: Data) {
        self.data = jsonData
    }
    
    func load<A>(resource: Resource<A>, completion: @escaping (Result<A>) -> ()) {
        do {
            let result = try resource.parse(data)
            completion(.success(result))
        } catch {
            completion(.failure(error))
        }
    }
}
