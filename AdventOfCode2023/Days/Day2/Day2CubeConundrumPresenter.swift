import Foundation

struct Day2CubeConundrumPresenter: Day2CubeConundrumViewDelegate {
    private let puzzleInputInteractor = PuzzleInputInteractor()
    private let DAY_NUM = "2"
    
    private enum MarbleColor: String {
        case red
        case green
        case blue
    }
    
    // Part 1
    func calculateGameIdSum(completion: @escaping (Result<Int, FileRetrievingError>) -> Void) {
        puzzleInputInteractor.getPuzzleInput(day: DAY_NUM, completion: { result in
            switch result {
            case .success(let file):
                let VALID_RED = 12
                let VALID_GREEN = 13
                let VALID_BLUE = 14
                
                var idSum = 0

                file.enumerateLines { (line, _) -> () in
                    let gameIdAndGamesList = line.split(separator: ": ")
                    let gameId = Int(gameIdAndGamesList[0].split(separator: " ")[1]) ?? 0
                    let sanitizedRoundsLine = gameIdAndGamesList[1]
                    let roundsList = sanitizedRoundsLine.split(separator: "; ")

                    let invalidRounds = roundsList.map { round in
                        let colorDraws = round.split(separator: ", ")
                        return colorDraws.map { draw in
                            let resultComponents = draw.split(separator: " ")
                            guard let number = Int(resultComponents[0]),
                                    let color = MarbleColor(rawValue: String(resultComponents[1])) else {
                                print("Failure to parse draw components")
                                return false
                            }
                            
                            switch color {
                            case .red:
                                return number <= VALID_RED
                            case .green:
                                return number <= VALID_GREEN
                            case .blue:
                                return number <= VALID_BLUE
                            }
                        }.filter { value in
                            return value == false
                        }
                    }.reduce([]) { x, y in
                        return x + y
                    }
                    if invalidRounds.count == 0 {
                        idSum = idSum + gameId
                    }
                }
                completion(.success(idSum))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    // Part 2
    func calculatePowerSum(completion: @escaping (Result<Int, FileRetrievingError>) -> Void) {
        puzzleInputInteractor.getPuzzleInput(day: DAY_NUM, completion: { result in
            switch result {
            case .success(let file):
                var powerSum = 0

                file.enumerateLines { (line, _) -> () in
                    let gameIdAndGamesList = line.split(separator: ": ")
                    let sanitizedRoundsLine = gameIdAndGamesList[1].trimmingCharacters(in: .whitespaces)

                    let roundsList = sanitizedRoundsLine.split(separator: "; ")
                    
                    let allDraws = roundsList.map { round in
                        return round.split(separator: ", ")
                    }.reduce([]) { x, y in
                        return x + y
                    }
                    
                    var MAX_BLUE = 0
                    var MAX_GREEN = 0
                    var MAX_RED = 0

                    allDraws.forEach { draw in
                        let drawComponents = draw.split(separator: " ")
           
                        for i in 0..<drawComponents.count where Int(drawComponents[i]) != nil {
                            guard let number = Int(drawComponents[i]),
                                  let color = MarbleColor(rawValue: String(drawComponents[i + 1])) else {
                                print("Failure to match marble color")
                                return
                            }
                            
                            switch color {
                            case .red:
                                if (number > MAX_RED) {
                                    MAX_RED = number
                                }
                            case .green:
                                if (number > MAX_GREEN) {
                                    MAX_GREEN = number
                                }
                            case .blue:
                                if (number > MAX_BLUE) {
                                    MAX_BLUE = number
                                }
                            }
                            
                        }
                    }
                    let leastPowerSum = [MAX_RED, MAX_GREEN, MAX_BLUE].filter { number in
                        return number != 0
                    }.reduce(1) { x, y in
                        return x * y
                    }
                    powerSum = powerSum + leastPowerSum
                    
                    MAX_BLUE = 0
                    MAX_GREEN = 0
                    MAX_RED = 0
                }
                completion(.success(powerSum))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
}
