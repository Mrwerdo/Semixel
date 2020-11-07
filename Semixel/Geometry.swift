//
//  Geometry.swift
//  Gravity Evaders
//
//  Created by Andrew Thompson on 22/11/19.
//  Copyright © 2020 Andrew Thompson. All rights reserved.
//

// -----------------------------------------------------------------------------
// MARK: - Coordinate Concrete Types
// -----------------------------------------------------------------------------

public struct Point2D : CoordinateIn2Dimensions {
    public var x: Int
    public var y: Int
    
    public init() {
        x = 0
        y = 0
    }
    
    public init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
    
    static var zero: Point2D {
        return Point2D()
    }
}

public struct Point3D : CoordinateIn3Dimensions, CustomStringConvertible {
    public var x: Int
    public var y: Int
    public var z: Int
    
    public init() {
        x = 0
        y = 0
        z = 0
    }
    
    public init(x: Int = 0, y: Int = 0, z: Int = 0) {
        self.x = x
        self.y = y
        self.z = z
    }
    public init(tuple: (x: Int, y: Int, z: Int)) {
        self.x = tuple.x
        self.y = tuple.y
        self.z = tuple.z
    }
    
    public var description: String {
        return "(x: \(x), y: \(y), z: \(z))"
    }
    
    public static func +(lhs: Point3D, rhs: Point3D) -> Point3D {
        return Point3D(x: lhs.x + rhs.x,
                       y: lhs.y + rhs.y,
                       z: lhs.z + rhs.z
        )
    }
    
    public static func -(lhs: Point3D, rhs: Point3D) -> Point3D {
        return Point3D(x: lhs.x - rhs.x,
                       y: lhs.y - rhs.y,
                       z: lhs.z - rhs.z
        )
    }
    
    public static func *(lhs: Point3D, rhs: Point3D) -> Point3D {
        return Point3D(x: lhs.x * rhs.x,
                       y: lhs.y * rhs.y,
                       z: lhs.z * rhs.z
        )
    }
    
    public static func /(lhs: Point3D, rhs: Point3D) -> Point3D {
        return Point3D(x: lhs.x / rhs.x,
                       y: lhs.y / rhs.y,
                       z: lhs.z / rhs.z
        )
    }
    
    public static func +=(lhs: inout Point3D, rhs: Point3D) {
        lhs.x += rhs.x
        lhs.y += rhs.y
        lhs.z += rhs.z
    }
    
    public static func -=(lhs: inout Point3D, rhs: Point3D) {
        lhs.x -= rhs.x
        lhs.y -= rhs.y
        lhs.z -= rhs.z
    }
    
    public static func *=(lhs: inout Point3D, rhs: Point3D) {
        lhs.x *= rhs.x
        lhs.y *= rhs.y
        lhs.z *= rhs.z
    }
    
    public static func /=(lhs: inout Point3D, rhs: Point3D) {
        lhs.x /= rhs.x
        lhs.y /= rhs.y
        lhs.z /= rhs.z
    }
    
    public static prefix func -(n: Point3D) -> Point3D {
        return Point3D(x: -n.x, y: -n.y, z: -n.z)
    }
}

public struct Size2D : CountableArea {
    public var width: Int
    public var height: Int
    
    public init(width: Int, height: Int) {
        self.width = width
        self.height = height
    }
}


public struct Size3D : CountableVolume {
    public var width: Int
    public var height: Int
    public var breadth: Int
    
    public init(width: Int = 0, height: Int = 0, breadth: Int = 0) {
        self.width = width
        self.height = height
        self.breadth = breadth
    }
    
    public var verticies: [Point3D] {
        typealias P = Point3D
        return [ P(x: 0,y: 0,z: 0),
                 P(x: 0,y: 0,z: breadth),
                 P(x: 0,y: height, z: 0),
                 P(x: 0, y: height, z: breadth),
                 P(x: width, y: 0, z: 0),
                 P(x: width, y: 0, z: breadth),
                 P(x: width, y: height, z: 0),
                 P(x: width, y: height, z: breadth)
        ]
    }
}

extension Point3D : Hashable {
    public var hashValue: Int {
        return x.hashValue ^ y.hashValue << 16 ^ z.hashValue << 32
    }
}

extension Size3D : Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(width)
        hasher.combine(height)
        hasher.combine(breadth)
    }
    
    var coordinates: [Point3D] {
        var cs = [Point3D]()
        cs.reserveCapacity(volume)
        for x in 0..<width {
            for y in 0..<height {
                for z in 0..<breadth {
                    cs.append(Point3D(x: x, y: y, z: z))
                }
            }
        }
        return cs
    }
}