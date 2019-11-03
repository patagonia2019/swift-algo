import UIKit

func generator(n: Int) -> [Int] {
    var array = [Int]()
    for x in 1...n {
        array.append(x)
    }
    return array
}

func generator2(n: Int) -> [[Int]] {
    var matrix = [[Int]]()
    for _ in 1...n {
        var array = [Int]()
        for y in 1...n {
            array.append(y)
        }
        matrix.append(array)
    }
    return matrix
}

// runtime: Big O, O(N) time
func foo(A: [Int]) -> (Int, Int) {
    var sum = 0
    var product = 1
    for i in 0..<A.count {
        sum += A[i]
    }
    for i in 0..<A.count {
        product *= A[i]
    }
    return (sum, product)
}

foo(A: generator(n: 10))

func sumVectorPairs(V: [Int]) -> Int {
    var sum = 0
    // O(N^2)
    for i in V {
        // O(N)
        for j in V {
            sum += (i + j)
        }
    }
    return sum
}
sumVectorPairs(V: generator(n: 10))

func sumPairs(V: [Int]) -> Int {
    var sum = 0
    // O(N^2)
    for i in 0..<V.count {
        // O(N)
        for j in i..<V.count {
            sum += (V[i] + V[j])
        }
    }
    return sum
}
sumPairs(V: generator(n: 10))

// O(N^2)
func sumUnorderPairs(V: [Int]) -> Int {
    var sum = 0
    // O(N^2)
    for i in 0..<V.count {
        // O(N)
        for j in i..<V.count {
            // (N-1) + (N-2) + (N-3) + ... + 2 + 1
            // sum of 1 + 2 + 3 +... + N-1
            // N(N-1)/2 -> O(N^2)
            if j + 1 < V.count {
                sum += (V[i] + V[j + 1])
            }
        }
    }
    return sum
}
print(sumUnorderPairs(V: generator(n: 10)))

func sumUnorderPairs(V: [Int], W: [Int]) -> Int {
    var sum = 0
    // O(ij)
    for i in 0..<V.count {
        for j in i..<W.count {
            // O(1) work
            if (V[i] < W[j]) {
                sum += V[i] + V[j]
            }
        }
    }
    return sum
}

print(sumUnorderPairs(V: generator(n: 10), W: generator(n: 10)))

func sumUnorderPairsMore(V: [Int], W: [Int]) -> Int {
    var sum = 0
    // O(ij)
    for i in 0..<V.count {
        for j in i..<W.count {
            // O(1) work anyway
            for _ in 0..<10000 {
                sum += V[i] + V[j]
            }
        }
    }
    return sum
}

print(sumUnorderPairsMore(V: generator(n: 10), W: generator(n: 10)))


func findMax(A: [[Int]]) {
    var max = INT_MAX
    // O(N^2)
    for v in A {
        // O(N)
        for x in v {
            if x > max {
                max = Int32(x)
            }
        }
    }
}
