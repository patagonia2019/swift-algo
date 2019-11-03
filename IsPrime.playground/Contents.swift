// Is Prime methods

import UIKit

// O(N*2)
func isPrime1(n: Int) -> Bool {
    var x = 2
    while (x * x) <= n {
        if (n % x) == 0 {
            return false
        }
        x += 1
    }
    return true
}

// O√n
func isPrime2(n: Int) -> Bool {
    var x = 2
    while x <= Int(sqrt(Float(n))) {
        if (n % x) == 0 {
            return false
        }
        x += 1
    }
    return true
}

// O(N)
func isPrime3(n: Int) -> Bool {
    for i in 1..<n {
        if i == 1 || i == n {
            continue
        }
        if (n % i) == 0 {
            return false
        }
    }
    return true
}

isPrime1(n: 11)
isPrime1(n: 1)
isPrime1(n: 8)
isPrime2(n: 11)
isPrime2(n: 1)
isPrime2(n: 8)
isPrime3(n: 11)
isPrime3(n: 1)
isPrime3(n: 8)

// O(N)
func generator(n: Int) -> [Int] {
    var array = [Int]()
    for x in 1...n {
        array.append(x)
    }
    return array
}

import XCTest
class MyTests: XCTestCase {
    static var X = generator(n: 1000)

    func prime1() -> Bool {
        var ret = false
        for i in MyTests.X {
            ret = ret && isPrime1(n: i)
        }
        return ret
    }
    
    func prime2() -> Bool {
        var ret = false
        for i in MyTests.X {
            ret = ret && isPrime2(n: i)
        }
        return ret
    }
    
    func prime3() -> Bool {
        var ret = false
        for i in MyTests.X {
            ret = ret && isPrime3(n: i)
        }
        return ret
    }
    
    // Test Case '-[__lldb_expr_27.MyTests testprime1]' failed (0.886 seconds).
    func testprime1() {
        measure {
            XCTAssertTrue(prime1())
        }
    }
    // Test Case '-[__lldb_expr_27.MyTests testprime2]' failed (0.267 seconds).
    func testprime2() {
        measure {
            XCTAssertTrue(prime2())
        }
    }

    // Test Case '-[__lldb_expr_27.MyTests testprime3]' failed (0.267 seconds).
    func testprime3() {
        measure {
            XCTAssertTrue(prime3())
        }
    }
}

MyTests.defaultTestSuite.run()

