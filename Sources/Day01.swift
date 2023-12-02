import Algorithms
import Foundation

struct Day01: AdventDay {
    var data: String
    
    var values: [String] {
        data.split(separator: "\n").map { String($0) }
    }
    
    func part1() -> Int {
        let regex = try? NSRegularExpression(pattern: "\\d", options: [])

        var sum = 0
        for value in values {
            guard let matches = regex?.matches(in: value, options: [], range: NSRange(value.startIndex..., in: value)) else { break }
            if matches.count < 2 {
                let onlyIndex = value.index(value.startIndex, offsetBy: matches[0].range.location)
                if let num = Int("\(value[onlyIndex])\(value[onlyIndex])") {
                    sum += num
                }
            } else {
                let firstIndex = value.index(value.startIndex, offsetBy: matches[0].range.location)
                let lastIndex = value.index(value.startIndex, offsetBy: matches[matches.endIndex - 1].range.location)
                if let num = Int("\(value[firstIndex])\(value[lastIndex])") {
                    sum += num
                }
            }
        }
        return sum
    }
    
    func part2() -> Int {
        let regex = try? NSRegularExpression(pattern: "\\d|one|two|three|four|five|six|seven|eight|nine", options: [])
        let regexReversed = try? NSRegularExpression(pattern: "\\d|eno|owt|eerht|ruof|evif|xis|neves|thgie|enin", options: [])

        var numbers = [String: String]()
        numbers["one"] = "1"
        numbers["two"] = "2"
        numbers["three"] = "3"
        numbers["four"] = "4"
        numbers["five"] = "5"
        numbers["six"] = "6"
        numbers["seven"] = "7"
        numbers["eight"] = "8"
        numbers["nine"] = "9"
        numbers["eno"] = "1"
        numbers["owt"] = "2"
        numbers["eerht"] = "3"
        numbers["ruof"] = "4"
        numbers["evif"] = "5"
        numbers["xis"] = "6"
        numbers["neves"] = "7"
        numbers["thgie"] = "8"
        numbers["enin"] = "9"

        var sum = 0
        for value in values {
            guard let matches = regex?.matches(in: value, options: [], range: NSRange(value.startIndex..., in: value)) else { break }
            
            let reversed = String(value.reversed())
            guard let lastMatches = regexReversed?.matches(in: reversed, options: [], range: NSRange(reversed.startIndex..., in: reversed)) else { break }
            
            if matches.count == 1 {
                guard let range = Range(matches[0].range, in: value) else { break }
                let substring = String(value[range])
                if let num = substring.count > 1 ? numbers[substring] : substring, let total = Int("\(num)\(num)") {
                    sum += total
                }
            } else {
                guard let first = Range(matches[0].range, in: value) else { break }
                guard let last = Range(lastMatches[0].range, in: reversed) else { break }
                let sub1 = String(value[first])
                let sub2 = String(reversed[last])
                if let num1 = sub1.count > 1 ? numbers[sub1] : sub1, let num2 = sub2.count > 1 ? numbers[sub2] : sub2, let total = Int("\(num1)\(num2)") {
                    sum += total
                }
            }
        }
        return sum
    }
}
