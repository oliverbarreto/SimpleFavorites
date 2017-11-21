//
//  RandomNumbersIntsUInts3264.swift
//  PersonalFavs
//
//  Created by on 25/6/17 on. Full credit to https://gist.github.com/jstn/f9d5437316879c9c448a
//

/*
 `arc4random_uniform` is very useful but limited to `UInt32`.
 
 This defines a generic version of `arc4random` for any type
 expressible by an integer literal, and extends some numeric
 types with a `random` method that mitigates for modulo bias
 in the same manner as `arc4random`.
 
 `lower` is inclusive and `upper` is exclusive, thus:
 
 let diceRoll = UInt64.random(lower: 1, upper: 7)
 */


import Darwin

private let _wordSize = __WORDSIZE

public func arc4random<T: ExpressibleByIntegerLiteral>(_ type: T.Type) -> T {
    var r: T = 0
    arc4random_buf(&r, MemoryLayout<T>.size)
    return r
}

public extension UInt {
    public static func random(lower: UInt = min, upper: UInt = max) -> UInt {
        switch (_wordSize) {
        case 32: return UInt(UInt32.random(lower: UInt32(lower), upper: UInt32(upper)))
        case 64: return UInt(UInt64.random(lower: UInt64(lower), upper: UInt64(upper)))
        default: return lower
        }
    }
}

public extension Int {
    public static func random(lower: Int = min, upper: Int = max) -> Int {
        switch (_wordSize) {
        case 32: return Int(Int32.random(lower: Int32(lower), upper: Int32(upper)))
        case 64: return Int(Int64.random(lower: Int64(lower), upper: Int64(upper)))
        default: return lower
        }
    }
}

public extension UInt32 {
    public static func random(lower: UInt32 = min, upper: UInt32 = max) -> UInt32 {
        return arc4random_uniform(upper - lower) + lower
    }
}

public extension Int32 {
    public static func random(lower: Int32 = min, upper: Int32 = max) -> Int32 {
        let r = arc4random_uniform(UInt32(Int64(upper) - Int64(lower)))
        return Int32(Int64(r) + Int64(lower))
    }
}

public extension UInt64 {
    public static func random(lower: UInt64 = min, upper: UInt64 = max) -> UInt64 {
        var m: UInt64
        let u = upper - lower
        var r = arc4random(UInt64.self)
        
        if u > UInt64(Int64.max) {
            m = 1 + ~u
        } else {
            m = ((max - (u * 2)) + 1) % u
        }
        
        while r < m {
            r = arc4random(UInt64.self)
        }
        
        return (r % u) + lower
    }
}


 public extension Int64 {
    public static func random(lower: Int64 = min, upper: Int64 = max) -> Int64 {
        //let (s, overflow) = Int64.subtractWithOverflow(upper, lower)
        let (s, overflow) = Int64(upper).subtractingReportingOverflow(lower)
        let u = overflow ? UInt64.max - UInt64(~s) : UInt64(s)
        let r = UInt64.random(upper: u)
        
        if r > UInt64(Int64.max)  {
            return Int64(r - (UInt64(~lower) + 1))
        } else {
            return Int64(r) + lower
        }
    }
}

