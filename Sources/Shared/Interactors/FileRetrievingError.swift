import Foundation

enum FileRetrievingError: Error {
    case notFound(message: String)
    case networkFailure(message: String)
}
