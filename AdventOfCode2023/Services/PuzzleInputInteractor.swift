import Foundation

struct PuzzleInputInteractor {
    
    func getPuzzleInput(day: Int, completion: @escaping (Result<String, Error>) -> Void) {
        let urlString = "https://adventofcode.com/2023/day/\(day)/input"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        let token = "53616c7465645f5f09a8960b70b3650c45f98705cef5b7b77ff7f05a46646c17e3f3a23f160217d4d5cb49aced2c283df653f466a7a9b15df353bbdf3e17b91a"
        
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


