import UIKit

// Problem: given an array of unordered elements, find the target sum and return the index of the elements that conforms the sum
// IN: vector:[Int]
// IN: target: Int
// OUT: tuple(index0, index1)
//
// i.e. [1,3,56,2,345,94,38,8,4,5,6]
// target = 9
// Index result is [7, 0]
//

// First approch: could be 2 cycles (1 main, another inner) O(N^2)
func doubleIteration(vector: [Int], target: Int) -> (Int?, Int?) {
    // O(N)
    for i in 0..<vector.count {
        for j in 0..<vector.count {
            if i != j {
                if vector[i] + vector[j] == target {
                    return (i < j ? i : j, i < j ? j : i)
                }
            }
        }
    }
    return (nil, nil)
}

// 4th approach: using memorization
// Four: iteration + memo -> O(N+1)
func iterationMemo(vector: [Int], target: Int) -> (Int?, Int?) {
    // memo
    var memo = Dictionary<Int,Int>()
    // O(N)
    for i in 0..<vector.count {
        let key = target - vector[i]
        // O(1)
        if let index = memo[key] {
            return (i < index ? i : index, i < index ? index : i)
        }
        if i+1 < vector.count {
            if vector[i] + vector[i+1] == target {
                return (i, i+1)
            }
            memo[vector[i]] = i
        }
    }
    return (nil, nil)
}

// 4th approach: using the same vector (less memory print)
func iterationContains(vector: [Int], target: Int) -> (Int?, Int?) {
    // O(N)
    for i in 0..<vector.count {
        let value = target - vector[i]
        // O(1)
        if vector.contains(value),
            let index = vector.firstIndex(of: value) {
            return (i < index ? i : index, i < index ? index : i)
        }
        if i+1 < vector.count {
            if vector[i] + vector[i+1] == target {
                return (i, i+1)
            }
        }
    }
    return (nil, nil)
}

// TODO: Another approach: using array.substract in the same array the first and last part taking account of the index: O(2*N)
// TODO: (not efficient in code) recursion + memo, divide by 2 O(log(N+1)/2) for sorted


// O(N)
func generator(n: Int) -> [Int] {
    var array = [Int]()
    for x in 1...n {
        array.append(x)
    }
    return array
}

doubleIteration(vector: generator(n: 100), target: 133) == (32, 99)
iterationContains(vector: generator(n: 100), target: 133) == (32, 99)
iterationMemo(vector: generator(n: 100), target: 133) == (65, 66)

doubleIteration(vector: generator(n: 1000), target: 1234) == (233, 999)
iterationContains(vector: generator(n: 1000), target: 1234) == (233, 999)
iterationMemo(vector: generator(n: 1000), target: 1234) == (615, 617)

import XCTest
class MyTests: XCTestCase {
    static var X = generator(n: 1000)

    // Test Case '-[__lldb_expr_1.MyTests testiterationMemo]' passed (2.140 seconds).
    func testdoubleIteration() {
        measure {
            XCTAssertTrue(doubleIteration(vector: MyTests.X, target: 1234) == (233, 999))
        }
    }

    // Test Case '-[__lldb_expr_1.MyTests testiterationMemo]' passed (0.550 seconds).
    func testiterationMemo() {
        measure {
            XCTAssertTrue(iterationMemo(vector: MyTests.X, target: 1234) == (615, 617))
        }
    }

    // Test Case '-[__lldb_expr_1.MyTests testiterationContains]' passed (0.930 seconds).
    func testiterationContains() {
        measure {
            XCTAssertTrue(iterationContains(vector: MyTests.X, target: 1234) == (233, 999))
        }
    }
}

MyTests.defaultTestSuite.run()

