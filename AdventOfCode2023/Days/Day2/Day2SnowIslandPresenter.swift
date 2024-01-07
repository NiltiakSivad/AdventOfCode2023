import Foundation

struct Day2SnowIslandPresenter: Day2SnowIslandViewDelegate {
    let puzzleInputInteractor = PuzzleInputInteractor()
    let DAY_NUM = 2
    
    func getInput() {
        puzzleInputInteractor.getPuzzleInput(day: DAY_NUM, completion: { result in
            switch result {
            case .success(var input):
                print("In the Callback")
                input.enumerateLines { (line, _) -> () in
                    print(line)
                }
            case .failure(var error):
                print("An error occurred")
            }
        })
    }
    
}
