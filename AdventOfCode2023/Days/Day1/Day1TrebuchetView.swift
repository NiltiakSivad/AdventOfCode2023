import SwiftUI

protocol Day1TrebuchetViewDelegate {
    func calculateDigitCalibration() throws -> Int
    func calculateDigitAndWordCalibration() throws -> Int
}

struct Day1TrebuchetView: View {
    var delegate: Day1TrebuchetViewDelegate?
    
    @State private var showErrorAlert = false
    
    @State private var firstCalibrationResult = 0
    
    @State private var secondCalibrationResult = 0
    
    var body: some View {
        List {
            Section {
                Text("Day 1 🚀")
                    .font(.largeTitle)
                    .bold()
                    .multilineTextAlignment(.leading)
                VStack {
                    Text("There is a problem with global snow production. As a result, a bunch of elves are about to launch you into the sky with a trebuchet. However, it needs to be calibrated first.")
                    
                    Spacer()
                    Text("On each line of the calibration document the calibration value can be found by combining the first digit and the last digit (in that order) to form a single two-digit number. For example `a1b2c3d4e5f` yields 15 and `treb7uchet` yields 77.")
                    
                    Spacer()
                    Text("What is the sum of all of the calibration values?").bold().italic()
                    Spacer()
                    Button("Calibrate", action: {
                        do {
                            firstCalibrationResult = try delegate?.calculateDigitCalibration() ?? 0
                        }
                        catch FileProcessingError.notFound(let message) {
                            print(message)
                            showErrorAlert = true
                        } catch {
                            print("Unknown file processing error occurred")
                            showErrorAlert = true
                        }
                    })
                    .buttonStyle(.borderedProminent)
                    .tint(.mint)
                }
                .padding()
                
                if (firstCalibrationResult != 0) {
                    Section {
                        Text("💥 Calibration: \(firstCalibrationResult)").font(.title).foregroundStyle(.red).bold()
                    }
                }
            }
            if (firstCalibrationResult != 0) {
                Section {
                    Text("Part Two")
                        .font(.title2)
                        .bold()
                        .multilineTextAlignment(.leading)
                    VStack {
                        Text("Your calculation isn't quite right. It looks like some of the digits are actually spelled out with letters: one, two, three, four, five, six, seven, eight, and nine also count as valid 'digits'. Try calculating the sum again with this new rule. For example `abcone2threexyz` yields 13 and `7pqrstsixteen` yields 76.")
                        Button("Calibrate", action: {
                            do {
                                secondCalibrationResult = try delegate?.calculateDigitAndWordCalibration() ?? 0
                            }
                            catch FileProcessingError.notFound(let message) {
                                print(message)
                                showErrorAlert = true
                            } catch {
                                print("Unknown file processing error occurred")
                                showErrorAlert = true
                            }
                        })
                        .buttonStyle(.borderedProminent)
                        .tint(.mint)
                    }
                    .padding()
                    if (secondCalibrationResult != 0) {
                        Section {
                            Text("💥 Calibration: \(secondCalibrationResult)").font(.title).foregroundStyle(.red).bold()
                        }
                    }
                }
                
            }
            
        }.listStyle(.insetGrouped)
            .alert("There was an error retrieving the calibration file. Don't worry, it's not your fault.", isPresented: $showErrorAlert) {
                Button("☹️", role: .cancel) { }
            }
    }
}

#Preview {
    Day1TrebuchetView()
}
