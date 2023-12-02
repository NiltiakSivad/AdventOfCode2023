import Foundation

enum FileProcessingError: Error {
    case notFound(message: String)
}

class FileProcessor {

    // Load an entire file into memory at once
    static func getFile(name: String, ext: String = "txt") throws -> NSString {
        guard let settingsURL = Bundle.main.url(forResource: name, withExtension: ext),
              let file = try? NSString(contentsOfFile: settingsURL.path, encoding: String.Encoding.ascii.rawValue) else {
            let message = "\(name).\(ext) data file not present"
            throw(FileProcessingError.notFound(message: message))
        }
        return file
    }
}
