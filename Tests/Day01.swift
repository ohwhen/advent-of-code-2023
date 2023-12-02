@testable import AdventOfCode
import XCTest

final class Day01Tests: XCTestCase {
    let testData1 = """
    1abc2
    pqr3stu8vwx
    a1b2c3d4e5f
    treb7uchet
    """
    
    let testData2 = """
    twonetwone
    """
    
    func testPart1() throws {
        let challenge = Day01(data: testData1)
        XCTAssertEqual(challenge.part1(), 142)
    }
    
    func testPart2() throws {
        let challenge = Day01(data: testData2)
        XCTAssertEqual(challenge.part2(), 21)
    }
}
