//
//  AppulseTests.swift
//  AppulseTests
//
//  Created by Dmitry Matveev on 01/04/2017.
//  Copyright © 2017 Dmitry Matveev. All rights reserved.
//

import XCTest
@testable import Appulse

class AppulseTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRepeatingNumbers() {
        let provider = RepeatingNumbers()
        
        var components = DateComponents()
        components.year = 2017
        components.month = 4
        components.day = 1
        components.hour = 10
        components.minute = 10
        components.second = 10
        
        let earlyMorning = Calendar.current.date(from: components)!
        
        print(earlyMorning)
        
        let elevenEleven = provider.next(current: earlyMorning)
        
        print(elevenEleven)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
