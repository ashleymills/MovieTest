//
//  Movie_Test_Tests.swift
//  Movie Test Tests
//
//  Created by Ashley Mills on 05/10/2018.
//  Copyright © 2018 Joylord Systems Ltd. All rights reserved.
//

import XCTest
@testable import Movie_Test

class WebServiceTests: XCTestCase {

    func testURL() {
        do {
            let url = WebService.url(withPath: "movie")
            XCTAssertEqual(url, URL(string: "https://api.themoviedb.org/3/movie?api_key=cfbb35aedd373b07c82e1be68a0da9bf"))
        }
        do {
            let url = WebService.url(withPath: "movie/now_playing")
            XCTAssertEqual(url, URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=cfbb35aedd373b07c82e1be68a0da9bf"))
        }
    }
    
    func testImageURL() {
        do {
            let url = WebService.imageUrl(withPath: "image123.jpg", size: .original)
            XCTAssertEqual(url, URL(string: "https://image.tmdb.org/t/p/original/image123.jpg"))
        }
        do {
            let url = WebService.imageUrl(withPath: "image123.jpg", size: .fixed(.w300))
            XCTAssertEqual(url, URL(string: "https://image.tmdb.org/t/p/w300/image123.jpg"))
        }
        do {
            let url = WebService.imageUrl(withPath: "image123.jpg", size: .fixed(.w500))
            XCTAssertEqual(url, URL(string: "https://image.tmdb.org/t/p/w500/image123.jpg"))
        }
    }
}
