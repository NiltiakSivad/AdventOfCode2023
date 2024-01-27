import SwiftUI

protocol Day2CubeConundrumViewDelegate {
    func calculateGameIdSum(completion: @escaping (Result<Int, FileRetrievingError>) -> Void)
    func calculatePowerSum(completion: @escaping (Result<Int, FileRetrievingError>) -> Void)

}

struct Day2CubeConundrumView: View {
    @State private var showErrorAlert = false
    
    @State private var part1Result = 0
    @State private var part2Result = 0

    
    var delegate: Day2CubeConundrumViewDelegate?
    
    var body: some View {
        List {
            Section {
                Text("Day 2 🟥🟩🟦")
                    .font(.largeTitle)
                    .bold()
                    .multilineTextAlignment(.leading)
                VStack {
                    Text("You're launched high into the atmosphere! The apex of your trajectory just barely reaches the surface of a large island floating in the sky. It's quite cold, but you don't see much snow. An Elf runs over to greet you. The Elf explains that you've arrived at Snow Island and apologizes for the lack of snow.")
                    
                    Spacer()
                    Text("Before explaining the situation, the Elf would like to play a game with you. He loads a bag with a random number of cubes, revealing some before putting them back. You record the data.")
                    
                    Spacer()
                    Text("The Elf would first like to know which games would have been possible if the bag contained only 12 red cubes, 13 green cubes, and 14 blue cubes. What is the sum of the IDs of those games?").bold().italic()
                    Spacer()
                    Button("Calculate", action: {
                        delegate?.calculateGameIdSum(completion: { result in
                            switch result {
                            case .success(let sum):
                                part1Result = sum
                            case .failure(let error):
                                showErrorAlert = true
                                switch error {
                                case FileRetrievingError.notFound(let message):
                                    print(message)
                                case FileRetrievingError.networkFailure(let message):
                                    print(message)
                                }
                            }
                        })
                    })
                    .buttonStyle(.borderedProminent)
                    .tint(.mint)
                }
                .padding()
                if (part1Result != 0) {
                    Section {
                        Text("💥 Calculation: \(part1Result)").font(.title).foregroundStyle(.red).bold()
                    }
                }
                
            }
            
            if (part1Result != 0) {
                Section {
                    Text("Part Two")
                        .font(.title2)
                        .bold()
                        .multilineTextAlignment(.leading)
                    VStack {
                        Text("The Elf says they've stopped producing snow because they aren't getting any water! He isn't sure why the water stopped; however, he can show you how to get to the water source to check it out for yourself. It's just up ahead!")
                        Spacer()
                        Text("As you continue your walk, the Elf poses a second question: in each game you played, what is the fewest number of cubes of each color that could have been in the bag to make the game possible?")
                        Spacer()
                        Text("The power of a set of cubes is equal to the numbers of fewest red, green, and blue cubes multiplied together.")
                        Spacer()
                        Text("For each game, find the minimum set of cubes that must have been present. What is the sum of the power of these sets?")
                        Spacer()
                        Button("Calibrate", action: {
                            delegate?.calculatePowerSum(completion: { result in
                                switch result {
                                case .success(let sum):
                                    part2Result = sum
                                case .failure(let error):
                                    showErrorAlert = true
                                    switch error {
                                    case FileRetrievingError.notFound(let message):
                                        print(message)
                                    case FileRetrievingError.networkFailure(let message):
                                        print(message)
                                    }
                                }
                            })
                        })
                        .buttonStyle(.borderedProminent)
                        .tint(.mint)
                    }
                    .padding()
                    if (part2Result != 0) {
                        Section {
                            Text("💥 Calibration: \(part2Result)").font(.title).foregroundStyle(.red).bold()
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
    Day2CubeConundrumView()
}
