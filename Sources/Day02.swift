import Algorithms
import Foundation

struct Day02: AdventDay {
    var data: String
    
    struct Game {
        struct Set {
            var red: Int = 0
            var green: Int = 0
            var blue: Int = 0
        }

        let id: Int
        let sets: [Set]
        
        init(id: Int, sets: [Set]) {
            self.id = id
            self.sets = sets
        }
        
        func validate() -> Int? {
            let isInvalid = sets.contains { $0.red > 12 || $0.green > 13 || $0.blue > 14 }
            return isInvalid ? nil : id
        }
        
        func powerSet() -> Int {
            let maxValues = sets.reduce(into: (red: 0, green: 0, blue: 0)) { maxValues, set in
                maxValues.red = max(set.red, maxValues.red)
                maxValues.green = max(set.green, maxValues.green)
                maxValues.blue = max(set.blue, maxValues.blue)
            }
            return maxValues.red * maxValues.green * maxValues.blue
        }
    }
    
    var values: [Game] {
        var games = [Game]()

        let regexGameId = try? NSRegularExpression(pattern: "([0-9]+)")
        let regexRed = try? NSRegularExpression(pattern: "(\\d+)\\s*red")
        let regexGreen = try? NSRegularExpression(pattern: "(\\d+)\\s*green")
        let regexBlue = try? NSRegularExpression(pattern: "(\\d+)\\s*blue")
        
        for line in data.split(separator: "\n") {
            let value = String(line)
            
            // match game id
            guard let gameIds = regexGameId?.matches(in: value, options: [], range: NSRange(value.startIndex..., in: value)) else { break }
            guard let range = Range(gameIds[0].range, in: value) else { break }
            guard let gameId = Int("\(value[range])") else { break }
            
            // match sets
            var gameSets = [Game.Set]()
            let sets = value.split(separator: ";")
            for set in sets {
                guard let reds = regexRed?.matches(in: String(set), options: [], range: NSRange(set.startIndex..., in: set)) else { break }
                guard let greens = regexGreen?.matches(in: String(set), options: [], range: NSRange(set.startIndex..., in: set)) else { break }
                guard let blues = regexBlue?.matches(in: String(set), options: [], range: NSRange(set.startIndex..., in: set)) else { break }
                
                var gameSet = Game.Set()
                
                if let redMatch = reds.first, let red = Range(redMatch.range(at: 1), in: set), let redTotal = Int(set[red]) {
                    gameSet.red = redTotal
                }
                if let greenMatch = greens.first, let green = Range(greenMatch.range(at: 1), in: set), let greenTotal = Int(set[green]) {
                    gameSet.green = greenTotal
                }
                if let blueMatch = blues.first, let blue = Range(blueMatch.range(at: 1), in: set), let blueTotal = Int(set[blue]) {
                    gameSet.blue = blueTotal
                }
                gameSets.append(gameSet)
            }
            games.append(Game(id: gameId, sets: gameSets))
        }
        return games
    }
    
    func part1() -> Int {
        return values.compactMap { $0.validate() }.reduce(0, +)
    }
    
    func part2() -> Int {
        return values.map { $0.powerSet() }.reduce(0, +)
    }
}
