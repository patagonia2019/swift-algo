// Log N Runtimes

import UIKit

// O(log N)
func searchLogN(A: [Int], s: Int) -> Bool {
    if A.count == 0 {
        return false
    }
    if A.count == 1 {
        if let x = A.first {
            return x == s
        }
        return false
    }
    let A1 = A.dropLast(A.count / 2)
    if let x = A1.last {
        if x < s {
            let A2 = A.dropFirst(A.count / 2 + 1)
            if searchLogN(A: Array(A2), s: s) == true {
                return true
            }
        }
        if x > s {
            if searchLogN(A: Array(A1), s: s) == true {
                return true
            }
        }
        if x == s {
            return true
        }
    }
    return false
}

// O(N)
func searchON(A: [Int], s: Int) -> Bool {
    for x in A {
        if x == s {
            return true
        }
    }
    return false
}

func search2KN(A: [Int], s: Int) -> Bool {
    if A.count == 0 {
        return false
    }
    if A.count == 1 {
        if let x = A.first {
            return x == s
        }
        return false
    }
    if let x = A.first {
        if x == s {
            return true
        }
        let A2 = A.dropFirst()
        if search2KN(A: Array(A2), s: s) == true {
            return true
        }
    }
    return false

}

func generator(n: Int) -> [Int] {
    var array = [Int]()
    for x in 1...n {
        array.append(x)
    }
    return array
}

searchLogN(A: generator(n: 10), s: 5)
searchON(A: generator(n: 10), s: 5)
search2KN(A: generator(n: 10), s: 5)

import XCTest
class MyTests: XCTestCase {
    static var X = generator(n: 1000)
    
    // Test Case '-[__lldb_expr_11.MyTests testSearchLogN]' passed (0.287 seconds).
    func testSearchLogN() {
        measure {
            XCTAssertTrue(searchLogN(A: MyTests.X, s: 154))
        }
    }
    // Test Case '-[__lldb_expr_11.MyTests testSearchON]' passed (0.253 seconds).
    func testSearchON() {
        measure {
            XCTAssertTrue(searchON(A: MyTests.X, s: 154))
        }
    }

    // Test Case '-[__lldb_expr_5.MyTests testSearch2KN]' passed (2.178 seconds).
    func testSearch2KN() {
        measure {
            XCTAssertTrue(search2KN(A: MyTests.X, s: 154))
        }
    }
}

MyTests.defaultTestSuite.run()

