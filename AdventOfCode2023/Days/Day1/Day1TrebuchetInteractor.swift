import Foundation

struct Day1TrebuchetInteractor {
    let DAY_ONE_FILE_NAME = "day-1"
    
    func getCalibrationData() throws -> NSString? {
        try FileProcessor.getFile(name: DAY_ONE_FILE_NAME)
    }
}
