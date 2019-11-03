import UIKit


// O(log n)
func powersOf2(n: Int, r: inout [Int]) -> Int {
    if n < 1 {
        r.append(0)
        return 0
    }
    if n == 1 {
        r.append(1)
        return 1
    }
    let prev = powersOf2(n: n / 2, r:&r)
    let curr = prev * 2
    r.append(curr)
    return curr
}


var result = [Int]()
powersOf2(n: 4, r: &result)
print(result)

// a * b = O(b)
func product(a: Int, b: Int) -> Int {
    var sum: Int = 0
    for _ in 0..<b {
        sum += a
    }
    return sum
}
print(product(a: 30, b: 2))

// a ^ b = O(b)
func power(a: Int, b: Int) -> Int {
    if b < 0 {
        return 0
    }
    if b == 0 {
        return 1
    }
    return a * power(a: a, b: b - 1)
}
print(power(a: 30, b: 2))

// a % b = O(1)
func mod(a: Int, b: Int) -> Int {
    if b <= 0 {
        return -1
    }
    let div = a / b
    return a - div * b
}
print(mod(a: 3, b: 2))
print(mod(a: 321, b: 53))

// a / b = O(a)
func div(a: Int, b: Int) -> Int {
    var count = 0
    var sum = b
    while sum <= a {
        sum += b
        count += 1
    }
    return count
}
print(div(a: 10, b: 2))
print(div(a: 3210, b: 32))

func sqrt(n: Int, min: Int, max: Int) -> Int {
    if max < min {
        return -1
    }
    
    let guess = (min + max) / 2
    let power = guess * guess
    if power == n {
        // found it
        return guess
    }
    if power < n { // too low
        // try higher
        return sqrt(n: n, min: guess + 1, max: max)
    }
    // try lower
    return sqrt(n: n, min: min, max: guess - 1)
}
// square root
func sqrt(n: Int) -> Int {
    return sqrt(n: n, min: 1, max: n)
}

print(sqrt(435*435))
