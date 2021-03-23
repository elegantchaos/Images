// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 19/12/2018.
//  All code (c) 2018 - present day, Elegant Chaos Limited.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

#if canImport(CryptoKit)

import Foundation
import Logger
import CryptoKit
import CommonCrypto
import ThreadExtensions

let imageCacheChannel = Channel("com.elegantchaos.imageCache")

@available(macOS 10.15, iOS 13.0, tvOS 13.0, *) public class GenericImageCache<Factory: ImageFactory> {
    let workQueue: DispatchQueue
    let callbackQueue: DispatchQueue
    let cacheURL: URL

    public typealias ImageCallback = (Factory.ImageClass) -> Void
    
    public init(deliveryQueue: DispatchQueue = DispatchQueue.main) {
        self.callbackQueue = deliveryQueue
        self.workQueue = DispatchQueue(label: "image-cache")
        self.cacheURL = try! FileManager.default.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    }

    public func image(for url: URL?, default defaultImage: Factory.ImageClass = Factory.emptyImage()) -> GenericAsyncImage<Factory> {
        GenericAsyncImage<Factory>(withURL: url, default: defaultImage, inCache: self)
    }

    public func image(for url: URL?, default defaultName: String) -> GenericAsyncImage<Factory> {
        GenericAsyncImage<Factory>(withURL: url, default: defaultName, inCache: self)
    }

    public func cachedImage(for url: URL) -> Factory.ImageClass? {
        let localURL = self.localURL(for: url)
        return load(cachedURL: localURL)
    }
    
    public func image(for url: URL, callback: @escaping ImageCallback) {
        let localURL = self.localURL(for: url)
        if let image = load(cachedURL: localURL) {
            callback(image)
        } else {
            workQueue.async {
                do {
                    if let image = self.load(remoteURL: url, toLocalURL: localURL) {
                        self.callbackQueue.async {
                            callback(image)
                        }
                    } else {
                        print("failed to load image \(url)")
                    }
                }
            }
        }
    }
    
    private func load(cachedURL url: URL) -> Factory.ImageClass? {
        guard let data = try? Data(contentsOf: url) else {
            return nil
        }
        
        guard let image = Factory.image(from: data) else {
            try? FileManager.default.removeItem(at: url)
            return nil
        }
        
        imageCacheChannel.log("loaded \(url.lastPathComponent) from cache")
        return image
    }
    
    private func load(remoteURL url: URL, toLocalURL: URL) -> Factory.ImageClass? {
        guard let data = try? Data(contentsOf: url), let image = Factory.image(from: data) else {
            return nil
        }

        do {
            try data.write(to: toLocalURL)
            imageCacheChannel.log("cached \(url.lastPathComponent) from cache")
        } catch {
            imageCacheChannel.log("couldn't cache \(url.lastPathComponent)\n\(error)")
        }
        
        return image
    }
    
    private func localURL(for imageURL: URL) -> URL {
        let imageCachedName = imageURL.absoluteString
        let imageCachedData = imageCachedName.data(using: .utf8)!
        let hashedName = CryptoKit.SHA256.hash(data: imageCachedData)
        let digest = hashedName.description
        let cachedImageURL = cacheURL.appendingPathComponent(digest)
        return cachedImageURL
    }
}

#endif
