import Foundation

class Day3GearRatiosPresenter: Day3GearRatiosViewDelegate {

    private let puzzleInputInteractor = PuzzleInputInteractor()
    private let DAY_NUM = "3"
    private let SYMBOLS = ["#", "$", "%", "&", "*", "@", "=", "+", "/", "-"]
    private var grid: [[Character]] = []
    
    func loadGridData(completion: @escaping(Result<Void, FileRetrievingError>) -> Void) {
        puzzleInputInteractor.getPuzzleInput(day: DAY_NUM, completion: { result in
            switch result {
            case .success(let file):
                self.grid = self.createGrid(file: file)
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    private struct Coordinate {
        var x = 0
        var y = 0
        
        init(x: Int = 0, y: Int = 0) {
            self.x = x
            self.y = y
        }
    }

    // Part 1
    func calculateGearIdSum(completion: @escaping (Result<Int, Error>) -> Void) {
        let rootCoordinate = Coordinate(x: 0, y: 0)
        var nextNumber = self.findNextNumber(searchStart: rootCoordinate)
        var gearIdSum = 0
        while (nextNumber != nil) {
            if let number = nextNumber {
                var currentLineHasSymbol = false
                var previousLineHasSymbol = false
                var nextLineHasSymbol = false
                
                currentLineHasSymbol = self.searchCurrentRow(numberCoordinates: number)
                
                if (number.0.y > 0) {
                    previousLineHasSymbol = self.searchPreviousRow(numberCoordinates: number)
                }
                if (number.0.y < self.grid.count - 1) {
                    nextLineHasSymbol = self.searchNextRow(numberCoordinates: number)
                }
                
                if (currentLineHasSymbol || previousLineHasSymbol || nextLineHasSymbol) {
                    let numberValue = self.getNumericValue(numberCoordinates: number)
                    gearIdSum = gearIdSum + numberValue
                }
                
                nextNumber = self.findNextNumber(searchStart: Coordinate(x: number.1.x + 1, y: number.1.y))

            }
        }
        completion(.success(gearIdSum))
    }
    
    private func getNumericValue(numberCoordinates: (Coordinate, Coordinate)) -> Int {
        let row = numberCoordinates.0.y
        let start = numberCoordinates.0.x
        let end = numberCoordinates.1.x + 1
        var numberString = ""
        
        for column in start ..< end {
            let currentValue = self.grid[row][column]
            numberString = numberString + String(currentValue)
        }

        return Int(numberString)!
    }

    private func searchNextRow(numberCoordinates: (Coordinate,  Coordinate)) -> Bool  {
        let nextRow = numberCoordinates.0.y + 1 < self.grid.count - 1 ? numberCoordinates.0.y + 1 : -1
        if (nextRow == -1) { return false }
        let searchColumnStart = numberCoordinates.0.x > 0 ? numberCoordinates.0.x - 1 : 0
        let searchColumnEnd = numberCoordinates.1.x + 2 < self.grid[nextRow].count ? numberCoordinates.1.x + 2 : numberCoordinates.1.x + 1
        for column in searchColumnStart ..< searchColumnEnd {
            let currentValue = self.grid[nextRow][column]
            if (SYMBOLS.contains(String(currentValue))) {
                return true
            }
        }
        
        return false
    }
    
    private func searchPreviousRow(numberCoordinates: (Coordinate,  Coordinate)) -> Bool  {
        let previousRow = numberCoordinates.0.y > 0 ? numberCoordinates.0.y - 1 : 0

        let searchColumnStart = numberCoordinates.0.x > 0 ? numberCoordinates.0.x - 1 : 0
        let searchColumnEnd = numberCoordinates.1.x + 2 < self.grid[previousRow].count ? numberCoordinates.1.x + 2 : numberCoordinates.1.x + 1

        for column in searchColumnStart ..< searchColumnEnd {
            let currentValue = self.grid[previousRow][column]
            if (SYMBOLS.contains(String(currentValue))) {
                return true
            }
        }
        
        return false
    }
    
    private func searchCurrentRow(numberCoordinates: (Coordinate,  Coordinate)) -> Bool {
        if (numberCoordinates.0.x > 0) {
            let characterLeftOfNumber = self.grid[numberCoordinates.0.y][numberCoordinates.0.x - 1]
            if (SYMBOLS.contains(String(characterLeftOfNumber))) {
                return true
            }
        }
        if (numberCoordinates.1.x + 1 < self.grid[numberCoordinates.1.y].count) {
            let characterRightOfNumber = self.grid[numberCoordinates.1.y][numberCoordinates.1.x + 1]
            if (SYMBOLS.contains(String(characterRightOfNumber))) {
                return true
            }
        }
        return false
    }
    
    // Given a starting location on the grid returns the tuple starting location and end location of the next number
    private func findNextNumber(searchStart: Coordinate) -> (Coordinate, Coordinate)? {
        var foundNumberStart: Coordinate?
        var foundNumberEnd: Coordinate?
        
        var rowStart = searchStart.y
        
        if (rowStart == self.grid.count) {
            return nil
        }
        
        var columnStart = searchStart.x
        while(rowStart < self.grid.count) {
            for column in columnStart ..< self.grid[rowStart].count {
                let currentValue = self.grid[rowStart][column]
                
                if (currentValue.isNumber) {
                    if (foundNumberStart == nil) {
                        foundNumberStart = Coordinate(x: column, y: rowStart)
                    } 
                    // Reached the end of a row
                    else if (foundNumberEnd == nil && column == self.grid[rowStart].count - 1) {
                        foundNumberEnd = Coordinate(x: column, y: rowStart)
                        return (foundNumberStart!, foundNumberEnd!)
                    }
                }
                // The next character is not a number so end of number found
                else if (foundNumberStart != nil && foundNumberEnd == nil) {
                    foundNumberEnd = Coordinate(x: column - 1, y: rowStart)
                    return (foundNumberStart!, foundNumberEnd!)
                }
            }
            columnStart = 0
            rowStart += 1
        }
        return nil

    }
    
    // Creates the two dimensional array
    private func createGrid(file: String) -> [[Character]] {
        var grid = [[Character]]()
        file.enumerateLines { line, stop in
            let characters = Array(line)
            grid.append(characters)
        }
        return grid
    }
}
