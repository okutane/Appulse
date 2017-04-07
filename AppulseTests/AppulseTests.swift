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
        
        let _1111 = provider.next(current: earlyMorning)
        XCTAssertEqual(formatter.string(from: _1111), "2017-04-01 11:11:00")
        
        let _2222 = provider.next(current: _1111)
        XCTAssertEqual(formatter.string(from: _2222), "2017-04-01 22:22:00")
        
        let _0000 = provider.next(current: _2222)
        XCTAssertEqual(formatter.string(from: _0000), "2017-04-02 00:00:00")
        
        let _1111_2 = provider.next(current: _0000)
        XCTAssertEqual(formatter.string(from: _1111_2), "2017-04-02 11:11:00")
    }

    func testSequentialNumbersPrev() {
        let provider = SequentialNumbers()

        let earlyMorning = formatter.date(from: "2017-04-01 10:10:10")!

        let _0123 = provider.prev(current: earlyMorning)
        XCTAssertEqual(formatter.string(from: _0123), "2017-04-01 01:23:00")

        let _1234 = provider.prev(current: _0123)
        XCTAssertEqual(formatter.string(from: _1234), "2017-03-31 12:34:00")

        let _0123_2 = provider.prev(current: _1234)
        XCTAssertEqual(formatter.string(from: _0123_2), "2017-03-31 01:23:00")
    }

    func testSequentialNumbersNext() {
        let provider = SequentialNumbers()

        let earlyMorning = formatter.date(from: "2017-04-01 10:10:10")!

        let _1234 = provider.next(current: earlyMorning)
        XCTAssertEqual(formatter.string(from: _1234), "2017-04-01 12:34:00")

        let _0123 = provider.next(current: _1234)
        XCTAssertEqual(formatter.string(from: _0123), "2017-04-02 01:23:00")

        let _1234_2 = provider.next(current: _0123)
        XCTAssertEqual(formatter.string(from: _1234_2), "2017-04-02 12:34:00")
    }

    func testLeetNumbersPrev() {
        let provider = LeetNumbers()

        let earlyMorning = formatter.date(from: "2017-04-01 10:10:10")!

        let _1337 = provider.prev(current: earlyMorning)
        XCTAssertEqual(formatter.string(from: _1337), "2017-03-31 13:37:00")

        let _1337_2 = provider.prev(current: _1337)
        XCTAssertEqual(formatter.string(from: _1337_2), "2017-03-30 13:37:00")
    }

    func testLeetNumbersNext() {
        let provider = LeetNumbers()

        let earlyMorning = formatter.date(from: "2017-04-01 10:10:10")!

        let _1337 = provider.next(current: earlyMorning)
        XCTAssertEqual(formatter.string(from: _1337), "2017-04-01 13:37:00")

        let _1337_2 = provider.next(current: _1337)
        XCTAssertEqual(formatter.string(from: _1337_2), "2017-04-02 13:37:00")
    }

    func testCompositeNumbersPrev() {
        let provider = AllMagicNumbers()

        let earlyMorning = formatter.date(from: "2017-04-01 10:10:10")!

        let _0123 = provider.prev(current: earlyMorning)
        XCTAssertEqual(formatter.string(from: _0123), "2017-04-01 01:23:00")

        let _0000 = provider.prev(current: _0123)
        XCTAssertEqual(formatter.string(from: _0000), "2017-04-01 00:00:00")
    }

    func testCompositeNumbersNext() {
        let provider = AllMagicNumbers()

        let earlyMorning = formatter.date(from: "2017-04-01 10:10:10")!

        let _1111 = provider.next(current: earlyMorning)
        XCTAssertEqual(formatter.string(from: _1111), "2017-04-01 11:11:00")

        let _1234 = provider.next(current: _1111)
        XCTAssertEqual(formatter.string(from: _1234), "2017-04-01 12:34:00")
    }
}
