import Foundation

struct PuzzleInputInteractor {
    
    private let sessionTokenInteractor = SessionTokenInteractor();
    
    func getPuzzleInput(day: Int, completion: @escaping (Result<String, Error>) -> Void) {
        let urlString = "https://adventofcode.com/2023/day/\(day)/input"
        
        guard let url = URL(string: urlString), let token = sessionTokenInteractor.getSessionToken() else {
            print("Invalid URL or no session token in keychain")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("text/plain", forHTTPHeaderField: "Content-Type")
        request.setValue("session=\(token)", forHTTPHeaderField: "Cookie")
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Something went wrong while retrieving the puzzle input")
                completion(.failure(error))
            }
            if let data = data {
                let puzzleInput = String(decoding: data, as: UTF8.self)
                completion(.success(puzzleInput))
            }
        }
        task.resume()
    }
}


