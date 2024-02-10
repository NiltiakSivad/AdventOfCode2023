import Foundation

class Day1TrebuchetPresenter: Day1TrebuchetViewDelegate {
    private let day = "1"
    private let puzzleInputInteractor = PuzzleInputInteractor()

    // Calculates the calibration value only looking at the NUMERIC digits (0,1,2,3,4,5,6,7,8,9)
    func calculateDigitCalibration(completion: @escaping (Result<Int, FileRetrievingError>) -> Void) {

        puzzleInputInteractor.getPuzzleInput(day: day) { result in
            switch result {
            case .success(let file):
                var finalSum = 0

                file.enumerateLines { (line, _) -> Void in
                    let chars = Array(line)

                    var front = 0
                    var digit1 = ""
                    while digit1 == "" {
                        let char1 = chars[front]
                        if char1.isNumber {
                            digit1 = String(char1)
                        }
                        front+=1
                    }

                    var back = chars.count - 1
                    var digit2 = ""
                    while digit2 == "" {
                        let char2 = chars[back]
                        if char2.isNumber {
                            digit2 = String(char2)
                        }
                        back-=1
                    }

                    if let newNumber = Int(digit1 + digit2) {
                        finalSum += newNumber
                    }
                }
                completion(.success(finalSum))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    // Calculates the calibration value looking at the NUMERIC digits (0,1,2,3,4,5,6,7,8,9) and
    // WORDS representing digits (zero, one, two, three, four, five, six, seven, eight, nine)
    // 👻 BEWARE the test case of "oneight"
    func calculateDigitAndWordCalibration(completion: @escaping (Result<Int, FileRetrievingError>) -> Void) {
        puzzleInputInteractor.getPuzzleInput(day: day) { result in
            switch result {
            case .success(let file):
                var finalSum = 0
                let wordToNumberMap: [String: String] = ["one": "1",
                                                         "two": "2",
                                                         "three": "3",
                                                         "four": "4",
                                                         "five": "5",
                                                         "six": "6",
                                                         "seven": "7",
                                                         "eight": "8",
                                                         "nine": "9"
                ]
                let regex = "[1-9]|one|two|three|four|five|six|seven|eight|nine"
                let reversedRegex = "[1-9]|eno|owt|eerht|ruof|evif|xis|neves|thgie|enin"

                file.enumerateLines { (line, _) -> Void in
                    do {
                        var digit1 = ""
                        let firstDigitRegex = try Regex(regex)
                        if let firstMatch = line.firstMatch(of: firstDigitRegex) {
                            digit1 = line[firstMatch.range].lowercased()
                        }

                        let isDigit1NumberWord = digit1.count != 1
                        if isDigit1NumberWord, let numberString = wordToNumberMap[digit1] {
                            digit1 = numberString
                        }

                        var digit2 = ""
                        let secondDigitRegex = try Regex(reversedRegex)
                        let reversedLine = String(line.reversed())
                        if let lastMatch = reversedLine.firstMatch(of: secondDigitRegex) {
                            digit2 = String(reversedLine[lastMatch.range].lowercased().reversed())
                        }

                        let isDigit2NumberWord = digit2.count != 1
                        if isDigit2NumberWord, let numberString = wordToNumberMap[digit2] {
                            digit2 = numberString
                        }

                        if let newNumber = Int(digit1 + digit2) {
                            finalSum += newNumber
                        }
                    } catch {
                        print("Don't worry it's not your fault. There was a problem processing the regex")
                    }
                }
                completion(.success(finalSum))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

}
