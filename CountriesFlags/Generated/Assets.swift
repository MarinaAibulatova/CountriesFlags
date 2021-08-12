//
//  Assets.swift
//  CountriesFlags
//
//  Created by Марина Айбулатова on 12.08.2021.
//

import UIKit.UIImage

internal enum Assets {
    internal enum Flag {
        internal static var allFlags: [UIImage] {
            var images: [UIImage] = []
            images.append(image(named: "ad"))
            images.append(image(named: "ae"))
            images.append(image(named: "af"))
            images.append(image(named: "ag"))
            images.append(image(named: "ai"))
            images.append(image(named: "am"))
            images.append(image(named: "ao"))
            images.append(image(named: "aq"))
            
            return images
        }
    }
    
    private static func image(named name: String) -> UIImage {
        guard let image = UIImage(named: name) else {
            fatalError("Unable to load image named \(name).")
        }
        return image
    }
}
