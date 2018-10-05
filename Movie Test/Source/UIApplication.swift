//
//  UIApplication.swift
//  Movie Test
//
//  Created by Ashley Mills on 05/10/2018.
//  Copyright © 2018 Joylord Systems Ltd. All rights reserved.
//

import UIKit

extension UIApplication {    
    public static var cachesFolderURL = url(for: .cachesDirectory)
}

private extension UIApplication {
    static func url(for directory: FileManager.SearchPathDirectory) -> URL {
        return FileManager.default.urls(for: directory, in: .userDomainMask).last!
    }
}
