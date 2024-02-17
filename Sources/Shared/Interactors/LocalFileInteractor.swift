import Foundation

class LocalFileInteractor {

    // Load an entire file into memory at once
    static func getFile(name: String,
                        ext: String = "txt",
                        completion: @escaping (Result<String, FileRetrievingError>) -> Void) {
        if let settingsURL = Bundle.main.url(forResource: name, withExtension: ext),
           let file = try? NSString(contentsOfFile: settingsURL.path, encoding: String.Encoding.ascii.rawValue) {
            completion(.success(String(file)))
        } else {
            let message = "\(name).\(ext) data file not present"
            completion(.failure(FileRetrievingError.notFound(message: message)))
        }
    }
}
