//
//  Image.swift
//  Movie Test
//
//  Created by Ashley Mills on 05/10/2018.
//  Copyright © 2018 Joylord Systems Ltd. All rights reserved.
//

import UIKit

private let imageCache: NSCache<NSString, UIImage> = {
    let cache = NSCache<NSString, UIImage>()
    return cache
}()

struct Image: RawRepresentable {
    var rawValue: String
    
    init(rawValue: String) {
        self.rawValue = rawValue
    }
    
    func image(size: WebService.ImageSize) -> UIImage? {
        return imageCache.object(forKey: cacheKey(for: size))
    }
    
    func load(webService: WebServiceType = WebService(), size: WebService.ImageSize, completion: @escaping Completion<UIImage?>) {
        let resource = Resource<UIImage?>(url: WebService.imageUrl(withPath: rawValue, size: size)) {
            if let image = UIImage(data: $0) {
                imageCache.setObject(image, forKey: self.cacheKey(for: size))
                return image
            }
            return nil
        }
        webService.load(resource: resource, completion: completion)
    }
    
    private func cacheKey(for size: WebService.ImageSize) -> NSString {
        return rawValue.appending("\(size)") as NSString
    }
}

extension Image: Codable {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        rawValue = try container.decode(String.self)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(rawValue)
    }
}

