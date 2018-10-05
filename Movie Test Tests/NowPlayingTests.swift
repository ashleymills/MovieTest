//
//  NowPlayingTests.swift
//  Movie Test Tests
//
//  Created by Ashley Mills on 05/10/2018.
//  Copyright © 2018 Joylord Systems Ltd. All rights reserved.
//

import XCTest
@testable import Movie_Test

class NowPlayingTests: XCTestCase {
    
    func testLoad() {
        let data = """
        {
        "results": [{
        "vote_count": 114,
        "id": 335983,
        "video": false,
        "vote_average": 6.3,
        "title": "Venom",
        "popularity": 324.891,
        "poster_path": "/2uNW4WbgBXL25BAbXGLnLqX71Sw.jpg",
        "original_language": "en",
        "original_title": "Venom",
        "genre_ids": [27, 878, 28, 53],
        "backdrop_path": "/VuukZLgaCrho2Ar8Scl9HtV3yD.jpg",
        "adult": false,
        "overview": "When Eddie Brock acquires the powers of a symbiote, he will have to release his alter-ego “Venom” to save his life.",
        "release_date": "2018-10-03"}]}
    """.data(using: .utf8)!
        
        let webSevice = DummyWebService(jsonData: data)
        NowPlaying.load(webService: webSevice) { result in
            switch result {
            case let .success(nowPlaying):
                XCTAssertEqual(nowPlaying.results.count, 1)
                let firstMovie = nowPlaying.results.first!
                XCTAssertEqual(firstMovie.id.rawValue, 335983)
                XCTAssertEqual(firstMovie.title, "Venom")
            case let .failure(error):
                XCTAssertNil(error)
            }
        }
    }

}
