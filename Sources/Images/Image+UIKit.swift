// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 03/02/2021.
//  All code (c) 2021 - present day, Elegant Chaos Limited.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import Foundation

#if canImport(UIKit)

import UIKit

public typealias Image = UIImage
public typealias AsyncImage = GenericAsyncImage<UIImageFactory>
public typealias ImageCache = UIImageCache
public typealias UIImageCache = GenericImageFactory<UIImageFactory>

public class UIImageFactory: ImageFactory {
    public typealias ImageClass = UIImage
    public static func image(from data: Data) -> UIImage? {
        return UIImage(data: data)
    }
    public static func image(named name: String) -> UIImage? {
        return UIImage(named: name)
    }
    public static func image(systemName name: String) -> UIImage? {
        return UIImage(systemName: name)
    }
    public static func emptyImage() -> UIImage {
        return UIImage()
    }
}

#endif
