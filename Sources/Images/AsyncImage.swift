// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 03/02/2021.
//  All code (c) 2021 - present day, Elegant Chaos Limited.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import Combine
import Foundation
import ThreadExtensions

/// Image that can be delivered asynchronously after retrieval from a cache.
/// The `image` property will always be a valid image, but it may be a zero-size
/// empty image until the cache has retrieved the real one.
/// The value of the image property is always updated on the main queue, so it's
/// safe to use from UI code.

@available(macOS 10.15, *) public class GenericAsyncImage<Factory>: ObservableObject where Factory: ImageFactory {
    @Published public var image: Factory.ImageClass

    public init(withURL url: URL?, default defaultImage: Factory.ImageClass = Factory.emptyImage(), inCache cache: GenericImageCache<Factory>) {
        guard let url = url else {
            self.image = defaultImage
            return
        }
        
        if let image = cache.cachedImage(for: url) {
            self.image = image
        } else {
            self.image = defaultImage
            cache.image(for: url) { [weak self] image in
                onMainQueue {
                    self?.image = image
                }
            }
        }
    }

    public convenience init(withURL url: URL?, default defaultName: String, inCache cache: GenericImageCache<Factory>) {
        self.init(withURL: url, default: Factory.image(systemName: defaultName) ?? Factory.emptyImage(), inCache: cache)
    }

}
