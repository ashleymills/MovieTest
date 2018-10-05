//
//  WebService.swift
//  Movie Test
//
//  Created by Ashley Mills on 05/10/2018.
//  Copyright © 2018 Joylord Systems Ltd. All rights reserved.
//

import UIKit

enum WebServiceError: Error {
    case invalidResponse, invalidStatusCode(Int)
}

protocol WebServiceType {
    func load<A>(resource: Resource<A>, completion: @escaping Completion<A>)
}

final class WebService: WebServiceType {
    
    enum ImageSize: CustomStringConvertible {
        enum Sizes: Int {
            case w300 = 300
            case w500 = 500
        }
        
        case original
        case fixed(Sizes)
        
        var description: String {
            switch self {
            case .original:
                return "original"
            case let .fixed(size):
                return "w\(size.rawValue)"
            }
        }
    }
    
    private static let apiKey = ""
    private static let baseURL = URL(string: "https://api.themoviedb.org/3")!
    private static let imageBaseURL = URL(string: "https://image.tmdb.org/t/p/")!

    static func url(withPath path: String) -> URL {
        let url = baseURL.appendingPathComponent(path)
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        components.queryItems = [URLQueryItem(name: "api_key", value: "cfbb35aedd373b07c82e1be68a0da9bf")]
        return components.url!
    }
    
    static func imageUrl(withPath path: String, size: ImageSize) -> URL {
        return imageBaseURL.appendingPathComponent("\(size)").appendingPathComponent(path)
    }
    
    func load<A>(resource: Resource<A>, completion: @escaping Completion<A>) {

        func failure(_ error: Error) {
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                completion(.failure(error))
            }
        }
        func success(_ result: A) {
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                completion(.success(result))
            }
        }

        let request = URLRequest(resource: resource)
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                failure(error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                failure(WebServiceError.invalidResponse)
                return
            }
            
            guard (200..<400).contains(httpResponse.statusCode) else {
                failure(WebServiceError.invalidStatusCode(httpResponse.statusCode))
                return
            }
            
            if let data = data {
                do {
                    let result = try resource.parse(data)
                    success(result)
                } catch {
                    failure(error)
                }
            }
            }.resume()
    }
}
