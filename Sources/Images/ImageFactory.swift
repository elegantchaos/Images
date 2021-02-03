// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 03/02/2021.
//  All code (c) 2021 - present day, Elegant Chaos Limited.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import Foundation

/// A platform-neutral abstraction for creating/loading images.

public protocol ImageFactory {
    associatedtype ImageClass
    static func image(from data: Data) -> ImageClass?
    static func image(named: String) -> ImageClass?
    static func image(systemName: String) -> ImageClass?
    static func emptyImage() -> ImageClass
}
