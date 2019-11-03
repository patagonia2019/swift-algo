import UIKit

// O(A+B)
func addRuntimes(A: [Int], B: [Int]) -> Bool {
    for a in A {
        print(a)
    }
    for b in B {
        print(b)
    }
    return true
}

// O(A*B)
func multiplyRuntimes(A: [Int], B: [Int]) -> Bool {
    for a in A {
        for b in B {
            print(a, b)
        }
    }
    return true
}

import XCTest
class MyTests: XCTestCase {
    // Test Case '-[__lldb_expr_1.MyTests testGenerateAddRuntimes]' passed (0.785 seconds).
    func testGenerateAddRuntimes() {
        measure {
            XCTAssertTrue(addRuntimes(A: [3,5,325,2356,232,3,5,8,9523], B: [3,5,325,2356,232,3,5,8,9523]))
        }
    }
    // Test Case '-[__lldb_expr_1.MyTests testGenerateMultiplyRuntimes]' passed (0.307 seconds).
    func testGenerateMultiplyRuntimes() {
        measure {
            XCTAssertTrue(multiplyRuntimes(A: [3,5,325,2356,232,3,5,8,9523], B: [3,5,325,2356,232,3,5,8,9523]))
        }
    }
}

MyTests.defaultTestSuite.run()

