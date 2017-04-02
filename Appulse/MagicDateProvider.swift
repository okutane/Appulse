//
//  MagicDateProvider.swift
//  Appulse
//
//  Created by Dmitry Matveev on 02/04/2017.
//  Copyright © 2017 Dmitry Matveev. All rights reserved.
//

import Foundation

protocol MagicDateProvider {
    func prev(current: Date) -> Date
    func next(current: Date) -> Date
}

class SameDigits: MagicDateProvider {
    internal func next(current: Date) -> Date {
        let hours = Calendar.current.component(.hour, from: current)
        let minutes = Calendar.current.component(.minute, from: current)
        let combined = hours * 100 + minutes
        if (combined < 2223) {
            
        }
        
        return current
    }

    internal func prev(current: Date) -> Date {
        let hours = Calendar.current.component(.hour, from: current)
        let minutes = Calendar.current.component(.minute, from: current)
        let combined = hours * 100 + minutes
        if (combined < 2223) {
            
        }
        
        return current
    }
}
