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

public class GenericAsyncImage<Factory>: ObservableObject where Factory: ImageFactory {
    @Published public var image: Factory.ImageClass

    public init(withURL url: URL?, default defaultImage: Factory.ImageClass = Factory.emptyImage(), inCache cache: GenericImageFactory<Factory>) {
        self.image = defaultImage
        if let url = url {
            cache.image(for: url) { [weak self] image in
                onMainQueue {
                    self?.image = image
                }
            }
        }
    }

    public init(withURL url: URL?, default defaultName: String, inCache cache: GenericImageFactory<Factory>) {
        self.image = Factory.image(systemName: defaultName) ?? Factory.emptyImage()
        if let url = url {
            cache.image(for: url) { [weak self] image in
                onMainQueue {
                    self?.image = image
                }
            }
        }
    }

}
