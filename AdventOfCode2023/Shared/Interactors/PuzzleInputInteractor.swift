import Foundation

struct PuzzleInputInteractor {
    
    private let sessionTokenInteractor = SessionTokenInteractor();
    private let localFileInteractor = LocalFileInteractor();
    
    func getPuzzleInput(day: String, completion: @escaping (Result<String, FileRetrievingError>) -> Void) {
        if let token = sessionTokenInteractor.getSessionToken() {
            getRemotePuzzleInput(day: day, token: token, completion: completion)
        } else {
            getLocalPuzzleInput(day: day, completion: completion)
        }
    }
    
    private func getLocalPuzzleInput(day: String, completion: @escaping (Result<String, FileRetrievingError>) -> Void) {
        let FILE_NAME = "day-\(day)"

        LocalFileInteractor.getFile(name: FILE_NAME, completion: completion)
    }
    
    private func getRemotePuzzleInput(day: String, token: String, completion: @escaping (Result<String, FileRetrievingError>) -> Void) {
        let urlString = "https://adventofcode.com/2023/day/\(day)/input"
        
        guard let url = URL(string: urlString) else { print("Invalid URL"); return }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("text/plain", forHTTPHeaderField: "Content-Type")
        request.setValue("session=\(token)", forHTTPHeaderField: "Cookie")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error != nil {
                completion(.failure(FileRetrievingError.networkFailure(message: "Unable to retrieve the remote puzzle input")))
            }
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                  case 200...299:
                    if let data = data {
                        let puzzleInput = String(decoding: data, as: UTF8.self)
                        completion(.success(puzzleInput))
                    }
                  default:
                    completion(.failure(FileRetrievingError.networkFailure(message: "Unable to retrieve the remote puzzle input")))
                  }
            }
        }
        task.resume()
    }
}


