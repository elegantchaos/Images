// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 03/02/2021.
//  All code (c) 2021 - present day, Elegant Chaos Limited.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import Foundation

#if canImport(UIKit)

import UIKit

public typealias Image = UIImage
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, *) public typealias AsyncImage = GenericAsyncImage<UIImageFactory>
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, *) public typealias ImageCache = UIImageCache
@available(iOS 13.0, tvOS 13.0, watchOS 6.0, *) public typealias UIImageCache = GenericImageCache<UIImageFactory>

public class UIImageFactory: ImageFactory {
    public typealias ImageClass = UIImage
    public static func image(from data: Data) -> UIImage? {
        return UIImage(data: data)
    }
    public static func image(named name: String) -> UIImage? {
        return UIImage(named: name)
    }
    @available(iOS 13.0, tvOS 13.0, watchOS 6.0, *) public static func image(systemName name: String) -> UIImage? {
        return UIImage(systemName: name)
    }
    public static func emptyImage() -> UIImage {
        return UIImage()
    }
}

#endif
