// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 03/02/2021.
//  All code (c) 2021 - present day, Elegant Chaos Limited.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

#if canImport(AppKit) && !targetEnvironment(macCatalyst)

import AppKit

public typealias Image = NSImage
@available(macOS 10.15, *) public typealias ImageCache = NSImageCache
@available(macOS 10.15, *) public typealias NSImageCache = GenericImageCache<NSImageFactory>
@available(macOS 10.15, *) public typealias AsyncImage = GenericAsyncImage<NSImageFactory>

public class NSImageFactory: ImageFactory {
    public typealias ImageClass = NSImage
    public static func image(from data: Data) -> NSImage? {
        return NSImage(data: data)
    }
    public static func image(named name: String) -> NSImage? {
        return NSImage(named: name)
    }
    public static func image(systemName name: String) -> NSImage? {
        return NSImage(named: name)
    }
    public static func emptyImage() -> NSImage {
        return NSImage()
    }
}

#endif
