import UIKit

/**
 You are given a 2D matrix of dimension  and a positive integer . You have to rotate the matrix  times and print the resultant matrix. Rotation should be in anti-clockwise direction.

 Rotation of a  matrix is represented by the following figure. Note that in one rotation, you have to shift elements by one step only.
 
 ```
 a11 ← a12 ← a13 ← a14 ← a15
  ↓                        ↑
 a21   a22 ← a23 ← a24   a25
  ↓     ↓            ↑     ↑
 a31   a32 → a33 → a34   a35
  ↓                        ↑
 a41 → a42 → a43 → a44 → a45

 ```

 It is guaranteed that the minimum of m and n will be even.

 As an example rotate the Start matrix by 2:

```
 Start         First           Second
  1 2 3 4       2  3  4  5      3  4  5  6
 12 1 2 5  ->   1  2  3  6 ->   2  3  4  7
 11 4 3 6      12  1  4  7      1  2  1  8
 10 9 8 7      11 10  9  8     12 11 10  9
```
 
* Function Description
 -

 Complete the matrixRotation function in the editor below. It should print the resultant 2D integer array and return nothing.

 matrixRotation has the following parameter(s):

 matrix: a 2D array of integers
 r: an integer that represents the rotation factor

* Input Format
-

 The first line contains three space separated integers, `m`, `n`, and `r`, the number of rows and columns in `matrix`, and the required rotation.
 The next `m` lines contain `n`space-separated integers representing the elements of a row of `matrix`.

* Constraints
-
 `2 <= m, n <= 300`
 `1 <= r <= 10^9`
 `min(m,n) % 2 = 0`
 `1 <= a(ij) <= 10^8 where i E [1 ...m] and j E [1...n] `

* Output Format
-
Print each row of the rotated matrix as space-separated integers on separate lines.
 
* Sample Input
-
 
** Sample Input #01
-
 ```
 4 4 2
  1  2  3  4
  5  6  7  8
  9 10 11 12
 13 14 15 16
 ```
 
** Sample Output #01
-
 ```
 3  4  8 12
 2 11 10 16
 1  7  6 15
 5  9 13 14
 ```
 
* Explanation #01
-
 The matrix is rotated through two rotations.

 ```
  1  2  3  4      2  3  4  8      3  4  8 12
  5  6  7  8      1  7 11 12      2 11 10 16
  9 10 11 12  ->  5  6 10 16  ->  1  7  6 15
 13 14 15 16      9 13 14 15      5  9 13 14

```
 
*  Sample Input #02
-
 ```
 5 4 7
  1  2  3  4
  7  8  9 10
 13 14 15 16
 19 20 21 22
 25 26 27 28
 ```
 
*  Sample Output #02
 -
```
 28 27 26 25
 22  9 15 19
 16  8 21 13
 10 14 20  7
  4  3  2  1
 ```
 
* Explanation 02
-
 
 The various states through 7 rotations:
```
  1  2  3  4     2  3  4 10     3  4 10 16     4 10 16 22
  7  8  9 10     1  9 15 16     2 15 21 22     3 21 20 28
 13 14 15 16 ->  7  8 21 22 ->  1  9 20 28 ->  2 15 14 27 ->
 19 20 21 22    13 14 20 28     7  8 14 27     1  9  8 26
 25 26 27 28    19 25 26 27    13 19 25 26     7 13 19 25

 10 16 22 28    16 22 28 27    22 28 27 26    28 27 26 25
  4 20 14 27    10 14  8 26    16  8  9 25    22  9 15 19
  3 21  8 26 ->  4 20  9 25 -> 10 14 15 19 -> 16  8 21 13
  2 15  9 25     3 21 15 19     4 20 21 13    10 14 20  7
  1  7 13 19     2  1  7 13     3  2  1  7     4  3  2  1
 ```
 
* Sample Input #03
-
 ```
 2 2 3
 1 1
 1 1
 ```
 
* Sample Output #03
-
 ```
 1 1
 1 1
 ```
 
* Explanation #03
-
 All of the elements are the same, so any rotation will repeat the same matrix.
 */

//
// Thinking in my solution
//

/**
 ** For sample Input #01
 -
 ```
 4 4 2
  1  2  3  4      ⤇⤇   a11 ← a12 ← a13 ← a14
                         ↓                 ↑
  5  6  7  8            a21   a22 ← a23   a24
                         ↓     ↓     ↑     ↑
  9 10 11 12            a31   a32 → a33   a34
                         ↓                 ↑
 13 14 15 16            a41 → a42 → a43 → a44
 ```
 Divide the work in 2 vectors: identifying 2 vectors here, and inner vector with 4 elements, and external vector with 12 elements = total 16 events.
 `v1 = a11, a12, a13, a14, a24, a34, a44, a43, a42, a41, a31, a21` and `v2 = a22, a23, a33, a32`
 `v1 = 1, 2, 3, 4, 8, 12, 16, 15, 14, 13, 9, 5` and `v2 = 6, 7, 11, 10`
 Rotating 2 times the vectors separatedly do the job.
 `v1'' = a13, a14, a24, a34, a44, a43, a42, a41, a31, a21, a11, a12` and `v2'' = a33, a32, a23, a22`
 `v1'' = 3, 4, 8, 12, 16, 15, 14, 13, 9, 5, 1, 2` and `v2'' = 11, 10, 6, 7`
 Final matrix:
 ```
 a13 ← a14 ← a24 ← a34       ⤇⤇    3  4  8 12
  ↓                 ↑
 a12   a22 ← a23   a44              2 11 10 16
  ↓     ↓     ↑     ↑
 a11   a32 → a33   a43              1  7  6 15
  ↓                 ↑
 a21 → a31 → a41 → a42              5  9 13 14
 ```
 
 Finally then, the steps are:
 1. separate matrix into vectors starting with `a11...amn` where m=n
 2. rotate the vectors, but taking in account that sometimes rotations is not needed, and sometimes r is too big, so do the necessary rotations
 3. use the rotated coordinates in a new matrix
  
 Performance is checked and it's really quick doing the rotation, the reason is once a vector is generated, the rotation is made. The use of Array(repeating:count), dropLast/removeFirst/append and checking if rotation is really necessary, and how many rotations simplyfies everything and the algorithm has a good performance.
*/

// Complete the matrixRotation function below.
func matrixRotationQuick(matrix: [[Int]], r: Int) -> Void {
        
    // number of rows
    let m = matrix.count
    // number of columns
    guard let n = matrix.first?.count else {
        return
    }
    // setup matrix for output
    var matrixOut = Array(repeating: Array(repeating: 0, count: n), count: m)

    guard m >= 2, m <= 300, n >= 2, n <= 300, r >= 1, r <= 1000000000 else { return }

    // determine the number of vectors
    var nv = min(m, n)
    if nv % 2 == 0 {
        nv = (nv / 2)
    } else {
        nv = (nv / 2) + 1
    }

    // i coordinate for rows
    var i = 0
    
    // number of vectors created
    var nc = 0
    
    // Separate matrix into vectors (nv) starting with `a11...amn` where m=n
    while (i < n && nc < nv) {
        // j coordinate for columns
        var j = i
        // contain the original vector address
        var address0 = [Dictionary<Int,Int>]()
        // will be the vector address to rotate
        var address = [Dictionary<Int,Int>]()

        // go to the right
        while (j < n - nc) {
            address0.append([i:j])
            address.append([i:j])
            j += 1
        }
        j -= 1
        i += 1
        // right -> go down
        while (i < m - nc) {
            address0.append([i:j])
            address.append([i:j])
            i += 1
        }
        i -= 1
        j -= 1
        // right,down -> go left
        while (j >= nc) {
            address0.append([i:j])
            address.append([i:j])
            j -= 1
        }
        j += 1
        i -= 1
        // left,down -> go up
        while (i > nc) {
            address0.append([i:j])
            address.append([i:j])
            i -= 1
        }
        i += 1
        
        // take a look the rotations
        var nr = r
        if address.count <= 1 {
            // no rotations necessary
            nr = 0
        }
        else {
            if nr > address.count {
                // mayor number of rotations, not necessary, just take the rest
                nr = r % address.count
            }
            else if nr == address.count {
                // no rotation is needed
                nr == 0
            }
        }
        if nr > 0 {
            // rotation using a quick way, thanks to swift
            let droped = address.dropLast(address.count - nr)
            address.removeFirst(nr)
            address.append(contentsOf: droped)
            
            // fill matrix of results
            for v in 0 ..< address.count {
                if let i0 = address0[v].first?.key,
                   let j0 = address0[v].first?.value,
                   let i1 = address[v].first?.key,
                   let j1 = address[v].first?.value {
                    matrixOut[i0][j0] = matrix[i1][j1]
                }
            }
        }

        nc += 1
    }

    // Print result
    matrixOut.forEach { (vector) in
        vector.forEach { (value) in
            print(value, terminator: " ")
        }
        print("")
    }


    /*
     ```
     2x2
     a11 ← a12
      ↓     ↑
     a21 → a22
    
     v = [a11, a12, a22, a21]
     
     2x3
     a11 ← a12
      ↓     ↑
     a21   a22
      ↓     ↑
     a31 → a32
     
     v = [a11, a12, a22, a32, a31, a21]

     3x2
     a11 ← a12 ← a13
      ↓           ↑
     a21 → a22 → a23

     v = [a11, a12, a13, a23, a22, a21]

     2x4
     a11 ← a12
      ↓     ↑
     a21   a22
      ↓     ↑
     a31   a32
      ↓     ↑
     a41 → a42
     
     v = [a11, a12, a22, a32, a42, a41, a31, a21]

     3x4
     a11 ← a12 ← a13
      ↓           ↑
     a21   a22   a23
      ↓     ↕︎     ↑
     a31   a32   a33
      ↓           ↑
     a41 → a42 → a43
     
     v1 = [a11, a12, a13, a23, a33, a43, a42, a41, a31, a21]
     v2 = [a22, a32]

     5x4
     a11 ← a12 ← a13 ← a14 ← a15
      ↓                        ↑
     a21   a22 ← a23 ← a24   a25
      ↓     ↓            ↑     ↑
     a31   a32 → a33 → a34   a35
      ↓                        ↑
     a41 → a42 → a43 → a44 → a45
     
     v1: [14 elements]
     v2: [6 elements]
     
     5x5
     a11 ← a12 ← a13 ← a14 ← a15
      ↓                       ↑
     a21   a22 ← a23 ← a24   a25
      ↓     ↓           ↑     ↑
     a31   a32   a33   a34   a35
      ↓     ↓           ↑     ↑
     a41   a42 → a43 → a44   a45
      ↓                       ↑
     a41 → a42 → a43 → a44 → a45

     v1: [16 elements]
     v2: [8 elements]
     v1: [1 element]
     
 */
}


let r = 7 // rotations

var matrix4x5: [[Int]] = [[ 1,  2,  3,  4,  5],
                          [ 6,  7,  8,  9, 10],
                          [11, 12, 13, 14, 15],
                          [16, 17, 18, 19, 20]]

// 5 4 7
var matrix5x4: [[Int]] = [[ 1,  2,  3,  4],
                          [ 7,  8,  9, 10],
                          [13, 14, 15, 16],
                          [19, 20, 21, 22],
                          [25, 26, 27, 28]]


var matrix2x2: [[Int]] = [[ 1,  2],
                          [ 3,  4]]

var matrix2x3: [[Int]] = [[ 1,  2],
                          [ 3,  4],
                          [ 5,  6]]

var matrix3x4: [[Int]] = [[ 1, 2, 3],
                          [ 4, 5, 6],
                          [ 7, 8, 9],
                          [10,11,12]]

var matrix6x7: [[Int]] = [[ 1,  2,  3,  4,  5, 6, 7],
                          [ 6,  7,  8,  9, 10, 6, 7],
                          [11, 12, 13, 14, 15, 6, 7],
                          [11, 12, 13, 14, 15, 6, 7],
                          [11, 12, 13, 14, 15, 6, 7],
                          [11, 12, 13, 14, 15, 6, 7],
                          [16, 17, 18, 19, 20, 6, 7]]

var matrix4x4: [[Int]] = [[ 1, 2, 3, 4],
                          [ 5, 6, 7, 8],
                          [ 9,10,11,12],
                          [13,14,15,16]]

/* ```
 5 4 7
  1  2  3  4
  7  8  9 10
 13 14 15 16
 19 20 21 22
 25 26 27 28
 ```
 */

matrixRotationQuick(matrix: matrix5x4, r: 7)

/*
```
 28 27 26 25
 22  9 15 19
 16  8 21 13
 10 14 20  7
  4  3  2  1
 ```
*/

