import UIKit

/**
 Problem statement: Assign passengers seats in an airplane. Assume an airplane with seat numbering as follows:
 ```
    ABC - DEFG - HIJ
 1
 2
 3
 4
 5
 6
 7
 8
 ```

 Some of the seats are already reserved. The list of reserved seats is given as a string S (of length M) containing seat numbers separated by single spaces: for example, "1A 3C 2B 40G 5A". The reserved seats can be listed in S in any order.
 ```
    ABC DEFG HIJ
 1  X
 2   X
 3    X
 4
 5  X
 6
 ...
 40        X
 ```
    
    Your task is to allocate seats for as many four-person families as possible. A four-person family occupies four seats that are next to each other in the same row. Seats across the aisle, from B to E, or from F to I are considered to be next to each other, but not from A to D, C to F, G to J, E to H are not considered to be next to each other. Obviously, each available seat cannot be taken by more than one family.

Write a function:
class Solution { public int solution(int N, String S); }

that, given the number of rows N and a list of reserved seats as string S, returns the maximum number of three-person families that can be seated in the remaining unreserved seats.

For instance, given N = 2 and S = "1A 2F 1C", your function should return 2. The following figure shows one possible way of seating two families in the remaining seats:

 S1: solution = 2, take row 1, columns DEFG, and row 2, columns BCDE

 ```
    ABC DEFG HIJ
 1  x x YYYY
 2   YY YYx
 ```

 S2: Another posible solution, but again solution = 2

 ```
    ABC DEFG HIJ
 1  x x   YY YY
 2   YY YYx
 ```

Given N = 1 and S = "" (empty string), your function should return 1, because we can seat only 1 family of four in a single row of seats, as shown in the figure below:
 ```
   ABC - DEFG - HIJ
 1       YYYY
    ```


Assume that:
    N is an integer within the range [1..50];
    M is an integer within the range [0..1,909];
    string S consists of valid seat names separated with spaces;
    every seat number appears in string S at most once.

**/

class PlaneSeat {
    var seatLetters = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J"]

    public func solution(N: Int, S: String) -> Int {
        var families4 = 0
        
        // check parameter N
        if N < 1 {
            return 0
        }
        var n = N
        if N > 50 {
            n = 50
        }
        var seats = [String](repeating: "0000000000", count: n)

        // Check an process parameter M
        var m = 0
        if S.count > 0 {
            for seat in Array(S.components(separatedBy: " ")) {
                m += seat.count + 1
                if m > 1909 {
                    break
                }
                _ = reserve(seat: seat, seats: &seats, isMutable: true)
            }
        }
        // Process every row ABCDEFGHIJ
        // Seats in columns A and J are useless here
        // Check first BC DE (1st aisle across)
        // Then DEFG (no aisle in the middle)
        // Then FGHI (2nd aisle across)
        for row in 0..<seats.count {
            var bcdeReserved = false
            var offset = 1 // omit column A and check BC DE
            if reserve4Seats(offset: offset, row: row, seats: &seats) {
                bcdeReserved = reserve4Seats(offset: offset, row: row, seats: &seats, isMutable: true)
                families4 += 1
            }
            
            var defgReserved = false
            offset = 3 // check DEFG, only if there is no bcde
            if bcdeReserved == false && reserve4Seats(offset: offset, row: row, seats: &seats) {
                defgReserved = reserve4Seats(offset: offset, row: row, seats: &seats, isMutable: true)
                families4 += 1
            }

            offset = 5 // check FGHI, only if there is no defg
            if defgReserved == false && reserve4Seats(offset: offset, row: row, seats: &seats) {
                _ = reserve4Seats(offset: offset, row: row, seats: &seats, isMutable: true)
                families4 += 1
            }
        }
        return families4
    }
    
    // reserve family-4 seats at once
    private func reserve4Seats(offset: Int, row: Int, seats: inout [String], isMutable: Bool = false) -> Bool {
        for seat in ["\(row+1)\(seatLetters[offset+0])",
                     "\(row+1)\(seatLetters[offset+1])",
                     "\(row+1)\(seatLetters[offset+2])",
                     "\(row+1)\(seatLetters[offset+3])"]
        {
            if reserve(seat: seat, seats: &seats, isMutable: isMutable) == false {
                // some seat is already reserved
                return false
            }
        }
        // here all 4 seats were checked/(reserved if mutable)
        return true
    }
    
    private func reserve(seat: String, seats: inout [String], isMutable: Bool = true) -> Bool {
        var row = ""
        var column = ""
        
        if seat.count == 2 { // Seats of the form 1A
            let seatArray = Array(seat)
            row = String(seatArray[0])
            column = String(seatArray[1])
        } else if seat.count == 3 { // Seats of the form 11A
            let seatArray = Array(seat)
            row = String(seatArray[0])+String(seatArray[1])
            column = String(seatArray[2])
        } else {
            return false
        }
        if let icolumn = column.unicodeScalars.first?.value,
            let irow = Int(row) {
            let r = irow - 1 // Row 0 is more appropiate
            let c = Int(icolumn - 65) // A=64 in ascii
            
            // check row index array out of bounds
            if r < 0 || r > 50 || r > seats.count {
                return false
            }
            var line = Array(seats[r])
            
            // check column index array out of bounds
            if c < 0 || c > line.count {
                return false
            }
            if line[c] == "0" {
                if isMutable {
                    line[c] = "1"
                } else {
                    return true
                }
            } else {
                // already reserved
                return false
            }
            // here change the seats reservation
            var output = ""
            for c in line {
                output.append(c)
            }
            seats[r] = output
        }
        return true
    }
    
    // given N = 2 and S = "1A 2F 1C", function should return 2
    static func problem1() {
        let N = 2
        let S = "1A 2F 1C"
        _ = PlaneSeat().solution(N: N, S: S)
    }

    static func problem2() {
        let N = 1
        let S = ""
        _ = PlaneSeat().solution(N: N, S: S)
    }

    static func problem3() {
        let N = 3
        let S = "1B 1E 1G 1I 2D"
        _ = PlaneSeat().solution(N: N, S: S)
    }

    static func problem4() {
        let N = 4
        let S = "1B 1E 1G 1I 2D 3F 4A"
        _ = PlaneSeat().solution(N: N, S: S)
    }

    static func problem5() {
        let N = 52 // outside range
        let S = "1B 1E 1G 1I 2D 3F 4A"
        _ = PlaneSeat().solution(N: N, S: S)
    }

    static func problem6() {
        let N = 5
        let S = "1B 1E 1G 1I 2D 3F 8X" // 8X should be ignored
        _ = PlaneSeat().solution(N: N, S: S)
    }
}


PlaneSeat.problem1()
PlaneSeat.problem2()
PlaneSeat.problem3()
PlaneSeat.problem4()
PlaneSeat.problem5()
PlaneSeat.problem6()

