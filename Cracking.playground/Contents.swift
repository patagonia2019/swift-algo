/**
 Algorithm: O(N)
 Which one is faster? minmaxFor1 or minmaxFor2?
 */

import UIKit

func minmaxFor1(array: [Int]) -> (Int, Int) {
    var min : Int = Int(INT32_MAX)
    var max = 0
    for x in array {
        if x < min {
            min = x
        }
        if x > max {
            max = x
        }
    }
    return (min, max)
}

func minmaxFor2(array: [Int]) -> (Int, Int) {
    var min : Int = Int(INT32_MAX)
    var max = 0
    for x in array {
        if x < min {
            min = x
        }
    }
    for x in array {
        if x > max {
            max = x
        }
    }
    return (min, max)
}



import XCTest
class MyTests: XCTestCase {
    func testGenerateFor1() {
        measure {
            // Test Case '-[__lldb_expr_3.MyTests testGenerateFor1]' passed (0.306 seconds).
            XCTAssertTrue(minmaxFor1(array: [3,5,325,2356,232,3,5,8,9523]) == (3, 9523))
        }
    }
    
    func testGenerateFor2() {
        measure {
            // Test Case '-[__lldb_expr_3.MyTests testGenerateFor2]' passed (0.255 seconds).
            XCTAssertTrue(minmaxFor2(array: [3,5,325,2356,232,3,5,8,9523]) == (3, 9523))
        }
    }
}

MyTests.defaultTestSuite.run()

