import UIKit

//
// O(2^N)
//
//                 f(4)
//               /      \
//              /        \
//             /          \
//            /            \
//         f(3)              f(3)
//        /    \            /    \
//      /       \          /      \
//   f(2)      f(2)      f(2)      f(2)
//   /  \      /  \      /  \      /  \
// f(1) f(1) f(1) f(1) f(1) f(1) f(1) f(1)
//
// Level #Nodes Desc                                 Or...
// 0      1                                          2^0
// 1      2     2 * previous level = 2               2^1
// 2      4     2 * previous level = 2 * 2^1 = 2^2   2^2
// 3      8     2 * previous level = 2 * 2^2 = 2^3   2^3
// 4     16     2 * previous level = 2 * 2^3 = 2^4   2^4
//
// runtime: O(branches^depth)
// branches: number of times each recursive call branches
// O(2^N)
//
func fibonacciRecursive(n: Int) -> Int {
    if n <= 0 {
        return 0
    }
    if n == 1 {
        return 1
    }
    let f = fibonacciRecursive(n: n - 1) + fibonacciRecursive(n: n - 2)
    return f
}

// O(N)
func fibonacciMemoRecursive(n: Int, memo: inout [Int]) -> Int {
    if n <= 0 {
        return 0
    }
    if n == 1 {
        return 1
    }
    if memo[n] > 0 {
        return memo[n]
    }
    let f = fibonacciMemoRecursive(n: n - 1, memo: &memo) + fibonacciMemoRecursive(n: n - 2, memo: &memo)
    memo[n] = f
    return f
}

// O(N)
// fibonacci cicle
func fibonacciIterative(n: Int) -> Int {
    var t1 = 0
    var t2 = 1
    var i = 2
    var next = 0
    while i <= n {
        next = t1 + t2
        t1 = t2
        t2 = next
        i += 1
    }
    return next
}


fibonacciRecursive(n: 21)
fibonacciIterative(n: 21)
var M = [Int](repeating: 0, count: 20000)
fibonacciMemoRecursive(n: 21, memo: &M)


import XCTest
class MyTests: XCTestCase {
    // Test Case '-[__lldb_expr_23.MyTests testfibonacciRecursive]' passed (7.121 seconds).
    func testfibonacciRecursive() {
        measure {
            XCTAssertTrue(fibonacciRecursive(n: 21) == 10946)
        }
    }
    // Test Case '-[__lldb_expr_23.MyTests testfibonacciIterative]' passed (0.312 seconds).
    func testfibonacciIterative() {
        measure {
            XCTAssertTrue(fibonacciIterative(n: 21) == 10946)
        }
    }
    // Test Case '-[__lldb_expr_23.MyTests fibonacciMemoRecursive]' passed (0.273 seconds).
    func testfibonacciMemoRecursive() {
        measure {
            var memo = [Int](repeating: 0, count: 20000)
            XCTAssertTrue(fibonacciMemoRecursive(n: 21, memo: &memo) == 10946)
        }
    }
}

MyTests.defaultTestSuite.run()

