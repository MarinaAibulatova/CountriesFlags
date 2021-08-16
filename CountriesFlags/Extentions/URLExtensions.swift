//
//  URLExtensions.swift
//  CountriesFlags
//
//  Created by Марина Айбулатова on 16.08.2021.
//

import UIKit

extension URL {
    static func urlForImage(name: String) -> URL? {
        let fileManager = FileManager.default
        guard let cacheDirectory = fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first else {return nil}
        
        let url = cacheDirectory.appendingPathComponent("\(name).png")
        let path = url.path
        
        if !fileManager.fileExists(atPath: path) {
            guard
                let image = UIImage(named: name),
                let data = image.pngData()
            else {
                return nil
            }
            fileManager.createFile(atPath: path, contents: data, attributes: nil)
            return url
        }
        return url
    }
}
