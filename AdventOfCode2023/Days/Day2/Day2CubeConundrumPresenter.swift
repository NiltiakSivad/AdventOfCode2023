import Foundation

class Day2CubeConundrumPresenter: Day2CubeConundrumViewDelegate {
    private let puzzleInputInteractor = PuzzleInputInteractor()
    private let day = "2"

    private enum MarbleColor: String {
        case red
        case green
        case blue
    }

    // Part 1
    func calculateGameIdSum(completion: @escaping (Result<Int, FileRetrievingError>) -> Void) {
        puzzleInputInteractor.getPuzzleInput(day: day, completion: { result in
            switch result {
            case .success(let file):
                let validRed = 12
                let validGreen = 13
                let validBlue = 14

                var idSum = 0

                file.enumerateLines { (line, _) -> Void in
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
                                return number <= validRed
                            case .green:
                                return number <= validGreen
                            case .blue:
                                return number <= validBlue
                            }
                        }.filter { value in
                            return value == false
                        }
                    }.reduce([]) { result, next in
                        return result + next
                    }
                    if invalidRounds.count == 0 {
                        idSum += gameId
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
        puzzleInputInteractor.getPuzzleInput(day: day, completion: { result in
            switch result {
            case .success(let file):
                var powerSum = 0

                file.enumerateLines { (line, _) -> Void in
                    let gameIdAndGamesList = line.split(separator: ": ")
                    let sanitizedRoundsLine = gameIdAndGamesList[1].trimmingCharacters(in: .whitespaces)

                    let roundsList = sanitizedRoundsLine.split(separator: "; ")

                    let allDraws = roundsList.map { round in
                        return round.split(separator: ", ")
                    }.reduce([]) { result, next in
                        return result + next
                    }

                    var maxBlue = 0
                    var maxGreen = 0
                    var maxRed = 0

                    allDraws.forEach { draw in
                        let drawComponents = draw.split(separator: " ")

                        for index in 0..<drawComponents.count where Int(drawComponents[index]) != nil {
                            guard let number = Int(drawComponents[index]),
                                  let color = MarbleColor(rawValue: String(drawComponents[index + 1])) else {
                                print("Failure to match marble color")
                                return
                            }

                            switch color {
                            case .red:
                                if number > maxRed {
                                    maxRed = number
                                }
                            case .green:
                                if number > maxGreen {
                                    maxGreen = number
                                }
                            case .blue:
                                if number > maxBlue {
                                    maxBlue = number
                                }
                            }

                        }
                    }
                    let leastPowerSum = [maxRed, maxGreen, maxBlue].filter { number in
                        return number != 0
                    }.reduce(1) { result, next in
                        return result * next
                    }
                    powerSum += leastPowerSum

                    maxBlue = 0
                    maxGreen = 0
                    maxRed = 0
                }
                completion(.success(powerSum))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
}
