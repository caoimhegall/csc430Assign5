//
//  assignment5Tests.swift
//  assignment5Tests
//
//  Created by caoimhe on 6/3/20.
//  Copyright © 2020 caoimhe. All rights reserved.
//

import XCTest
import assignment5
@testable import assignment5

class Tests: XCTestCase {
    override func setUp() {
        super.setUp()
    // Put setup code here. This method is called before the invocation of each test method in the class.
        
    }
    override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        
    }
    func testNumC(){
        let one = NumC(v: 1)
        XCTAssertEqual(one.v, 1, "test failed")
        
    }
    func testStrC(){
        let str1 = StrC(str: "hello")
        XCTAssertEqual(str1.str, "hello", "test failed")
     }
    func testIdC(){
       let idC1 = IdC(str: "hello")
       XCTAssertEqual(str1.str, "hello", "test failed")
    }
}

