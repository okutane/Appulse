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
    let formatter : DateFormatter = DateFormatter()
    
    override func setUp() {
        super.setUp()
        formatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testRepeatingNumbersPrev() {
        let provider = RepeatingNumbers()
        
        let earlyMorning = formatter.date(from: "2017-04-01 10:10:10")!
        
        print(earlyMorning)
        
        let _0000 = provider.prev(current: earlyMorning)
        XCTAssertEqual(formatter.string(from: _0000), "2017-04-01 00:00:00")
        
        let _2222 = provider.prev(current: _0000)
        XCTAssertEqual(formatter.string(from: _2222), "2017-03-31 22:22:00")
        
        let _1111 = provider.prev(current: _2222)
        XCTAssertEqual(formatter.string(from: _1111), "2017-03-31 11:11:00")
        
        let _0000_2 = provider.prev(current: _1111)
        XCTAssertEqual(formatter.string(from: _0000_2), "2017-03-31 00:00:00")
    }
    
    func testRepeatingNumbersNext() {
        let provider = RepeatingNumbers()
        
        let earlyMorning = formatter.date(from: "2017-04-01 10:10:10")!
        
        print(earlyMorning)
        
        let _1111 = provider.next(current: earlyMorning)
        XCTAssertEqual(formatter.string(from: _1111), "2017-04-01 11:11:00")
        
        let _2222 = provider.next(current: _1111)
        XCTAssertEqual(formatter.string(from: _2222), "2017-04-01 22:22:00")
        
        let _0000 = provider.next(current: _2222)
        XCTAssertEqual(formatter.string(from: _0000), "2017-04-02 00:00:00")
        
        let _1111_2 = provider.next(current: _0000)
        XCTAssertEqual(formatter.string(from: _1111_2), "2017-04-02 11:11:00")
    }
}
