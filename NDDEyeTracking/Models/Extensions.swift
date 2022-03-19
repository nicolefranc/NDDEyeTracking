//
//  Extensions.swift
//  NDDEyeTracking
//
//  Created by Jason Shang on 3/19/22.
//

import Foundation
import ARKit

// extensions to make built-in classes codable
extension SCNVector4: Codable {
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.init()
        x = Float(try values.decode(CGFloat.self, forKey: .x))
        y = Float(try values.decode(CGFloat.self, forKey: .y))
        z = Float(try values.decode(CGFloat.self, forKey: .z))
        w = Float(try values.decode(CGFloat.self, forKey: .w))
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(x, forKey: .x)
        try container.encode(y, forKey: .y)
        try container.encode(z, forKey: .z)
        try container.encode(w, forKey: .w)
    }
    
    enum CodingKeys: String, CodingKey {
        case x
        case y
        case z
        case w
    }
}

extension SCNVector3: Codable {
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.init()
        x = Float(try values.decode(CGFloat.self, forKey: .x))
        y = Float(try values.decode(CGFloat.self, forKey: .y))
        z = Float(try values.decode(CGFloat.self, forKey: .z))
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(x, forKey: .x)
        try container.encode(y, forKey: .y)
        try container.encode(z, forKey: .z)
    }
    
    enum CodingKeys: String, CodingKey {
        case x
        case y
        case z
    }
}
