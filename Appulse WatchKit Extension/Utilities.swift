//
//  Utilities.swift
//  Appulse
//
//  Created by Dmitry Matveev on 03/04/2017.
//  Copyright © 2017 Dmitry Matveev. All rights reserved.
//

import Foundation

protocol MagicDateProvider {
    func prev(current: Date) -> Date
    func next(current: Date) -> Date
}

let minute = TimeInterval(60)
let hour = TimeInterval(minute * 60)
let day = TimeInterval(hour * 24)

struct MagicMinute {
    var from: Date
    var to: Date {
        return from.addingTimeInterval(minute)
    }
    var bestSecond: Date?
}

// 00:00, 11:11, 22:22
struct RepeatingNumbers: MagicDateProvider {
    internal func prev(current: Date) -> Date {
        let x: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]
        let cal = Calendar.current
        var components = cal.dateComponents(x, from: current)
        
        let hours = Calendar.current.component(.hour, from: current)
        let minutes = Calendar.current.component(.minute, from: current)
        let combined = hours * 100 + minutes;
        
        components.second = 0
        
        if (combined > 2222) {
            components.hour = 22
            components.minute = 22
            return cal.date(from: components)!
        }
        
        if (combined > 1111) {
            components.hour = 11
            components.minute = 11
            return cal.date(from: components)!
        }
        
        if (combined > 0000) {
            components.hour = 0
            components.minute = 0
            return cal.date(from: components)!
        }
        
        components.day = components.day! - 1
        components.hour = 22
        components.minute = 22
        return cal.date(from: components)!
    }
    
    internal func next(current: Date) -> Date {
        let x: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]
        let cal = Calendar.current
        var components = cal.dateComponents(x, from: current)
        
        let hours = Calendar.current.component(.hour, from: current)
        let minutes = Calendar.current.component(.minute, from: current)
        let combined = hours * 100 + minutes;
        
        components.second = 0
        
        if (combined < 1111) {
            components.hour = 11
            components.minute = 11
            return cal.date(from: components)!
        }
        
        if (combined < 2222) {
            components.hour = 22
            components.minute = 22
            return cal.date(from: components)!
        }
        
        components.hour = 0
        components.minute = 0
        components.day = components.day! + 1
        return cal.date(from: components)!
    }
}

// 01:23, 12:34
struct SequentialNumbers: MagicDateProvider {
    internal func prev(current: Date) -> Date {
        let x: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]
        let cal = Calendar.current
        var components = cal.dateComponents(x, from: current)

        let hours = Calendar.current.component(.hour, from: current)
        let minutes = Calendar.current.component(.minute, from: current)
        let combined = hours * 100 + minutes;

        components.second = 0

        if (combined > 1234) {
            components.hour = 12
            components.minute = 34
            return cal.date(from: components)!
        }

        if (combined > 0123) {
            components.hour = 01
            components.minute = 23
            return cal.date(from: components)!
        }

        components.day = components.day! - 1
        components.hour = 12
        components.minute = 34
        return cal.date(from: components)!
    }

    internal func next(current: Date) -> Date {
        let x: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]
        let cal = Calendar.current
        var components = cal.dateComponents(x, from: current)

        let hours = Calendar.current.component(.hour, from: current)
        let minutes = Calendar.current.component(.minute, from: current)
        let combined = hours * 100 + minutes;

        components.second = 0

        if (combined < 0123) {
            components.hour = 01
            components.minute = 23
            return cal.date(from: components)!
        }

        if (combined < 1234) {
            components.hour = 12
            components.minute = 34
            return cal.date(from: components)!
        }

        components.hour = 01
        components.minute = 23
        components.day = components.day! + 1
        return cal.date(from: components)!
    }
}

// 13:37 only
struct LeetNumbers: MagicDateProvider {
    internal func prev(current: Date) -> Date {
        let x: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]
        let cal = Calendar.current
        var components = cal.dateComponents(x, from: current)

        let hours = Calendar.current.component(.hour, from: current)
        let minutes = Calendar.current.component(.minute, from: current)
        let combined = hours * 100 + minutes;

        components.second = 0

        if (combined > 1337) {
            components.hour = 13
            components.minute = 37
            return cal.date(from: components)!
        }

        components.day = components.day! - 1
        components.hour = 13
        components.minute = 37
        return cal.date(from: components)!
    }

    internal func next(current: Date) -> Date {
        let x: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]
        let cal = Calendar.current
        var components = cal.dateComponents(x, from: current)

        let hours = Calendar.current.component(.hour, from: current)
        let minutes = Calendar.current.component(.minute, from: current)
        let combined = hours * 100 + minutes;

        components.second = 0

        if (combined < 1337) {
            components.hour = 13
            components.minute = 37
            return cal.date(from: components)!
        }

        components.hour = 13
        components.minute = 37
        components.day = components.day! + 1
        return cal.date(from: components)!
    }
}

struct AllMagicNumbers: MagicDateProvider {
    let providers: [MagicDateProvider] = [SequentialNumbers(), RepeatingNumbers(), LeetNumbers()]

    internal func prev(current: Date) -> Date {
        return providers.map {
            $0.prev(current: current)
        }.max()!
    }

    internal func next(current: Date) -> Date {
        return providers.map {
            $0.next(current: current)
        }.min()!
    }
}
