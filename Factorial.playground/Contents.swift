// Factorial n!

import UIKit

// O(N)
func factorialRecursive(n: Int) -> Int {
    if n < 0 {
        return -1
    }
    if n == 0 {
        return 1
    }
    return n * factorialRecursive(n: n - 1)
}

func factorialIterative(n: Int) -> Int {
    var c = 1
    var fact = 1
    while c <= n {
        fact *= c
        c += 1
    }
    return fact
}

factorialRecursive(n: 15)
factorialIterative(n: 15)

import XCTest
class MyTests: XCTestCase {

    // Test Case '-[__lldb_expr_1.MyTests testfactorialRecursive]' passed (0.255 seconds).
    func testfactorialRecursive() {
        measure {
            XCTAssertTrue(factorialRecursive(n: 15) == 1307674368000)
        }
    }
    // Test Case '-[__lldb_expr_1.MyTests testfactorialIterative]' passed (0.285 seconds).
    func testfactorialIterative() {
        measure {
            XCTAssertTrue(factorialIterative(n: 15) == 1307674368000)
        }
    }
}

MyTests.defaultTestSuite.run()

