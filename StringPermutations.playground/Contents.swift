import UIKit


func permutation(str: String, prefix: String) {
    if str.isEmpty {
        print(prefix, terminator: "")
    }
    for i in 0..<str.count {
        let rem = str.prefix(i) + str.suffix(i + 1).prefix(1)
        permutation(str: String(rem), prefix: prefix + String(str.suffix(i)))
    }
}

func permutation(str: String) {
    permutation(str: str, prefix: "")
}

permutation(str: "hola")
