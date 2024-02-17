import SwiftUI

protocol Day3GearRatiosViewDelegate: AnyObject {
    func loadGridData(completion: @escaping(Result<Void, FileRetrievingError>) -> Void)
    func calculateGearIdSum(completion: @escaping (Result<Int, Error>) -> Void)

}

struct Day3GearRatiosView: View {
    @State private var showErrorAlert = false

    @State private var part1Result = 0
    @State private var part2Result = 0

    var delegate: Day3GearRatiosViewDelegate?

    var body: some View {
        List {
            Section {
                Text("Day 3 ⚙️")
                    .font(.largeTitle)
                    .bold()
                    .multilineTextAlignment(.leading)
                VStack {
                    Text("""
                        You and the Elf eventually reach a gondola lift station;
                        he says the gondola lift will take you up to the water
                        source, but this is as far as he can bring you. You go inside.
                        """)

                    Spacer()
                    Text("""
                        You turn around to see a slightly-greasy Elf with a wrench
                        and a look of surprise. 'Sorry, I wasn't expecting anyone!
                        The gondola lift isn't working right now; it'll still be a
                        while before I can fix it.' You offer to help.
                        """)

                    Spacer()
                    Text("""
                        The engine schematic (your puzzle input) consists of a visual
                        representation of the engine. There are lots of numbers and
                        symbols you don't really understand, but apparently any number
                        adjacent to a symbol, even diagonally, is a 'part number' and
                        should be included in your sum. (Periods (.) do not count as a
                        symbol.) What is the sum of all of the part numbers in the engine schematic?
                        """)
                        .bold()
                        .italic()
                    Spacer()
                    Button("Calculate", action: {
                        delegate?.calculateGearIdSum(completion: { result in
                            switch result {
                            case .success(let sum):
                                part1Result = sum
                            case .failure(_):
                                showErrorAlert = true
                            }
                        })
                    })
                    .buttonStyle(.borderedProminent)
                    .tint(.mint)
                }
                .padding()
                if part1Result != 0 {
                    Section {
                        Text("💥 Calculation: \(part1Result)").font(.title).foregroundStyle(.red).bold()
                    }
                }

            }

            if part1Result != 0 {
                Section {
                    Text("Part Two")
                        .font(.title2)
                        .bold()
                        .multilineTextAlignment(.leading)
                    VStack {
                        Text("""
                            The Elf says they've stopped producing snow because they aren't
                            getting any water! He isn't sure why the water stopped; however,
                            he can show you how to get to the water source to check it out for yourself.
                            It's just up ahead!
                            """)
                        Spacer()
                        Text("""
                             As you continue your walk, the Elf poses a second question: in each
                             game you played, what is the fewest number of cubes of each color that
                             could have been in the bag to make the game possible?
                             """)
                        Spacer()
                        Text("""
                             The power of a set of cubes is equal to the numbers of fewest red, green,
                             and blue cubes multiplied together.
                             """)
                        Spacer()
                        Text("""
                            For each game, find the minimum set of cubes that must have been present.
                            What is the sum of the power of these sets?
                        """)
                        Spacer()
                        Button("Calibrate", action: {

                        })
                        .buttonStyle(.borderedProminent)
                        .tint(.mint)
                    }
                    .padding()
                    if part2Result != 0 {
                        Section {
                            Text("💥 Calibration: \(part2Result)").font(.title).foregroundStyle(.red).bold()
                        }
                    }
                }

            }
        }
        .listStyle(.insetGrouped)
        .alert("""
                There was an error retrieving the calibration file.
                Don't worry, it's not your fault.
                """, isPresented: $showErrorAlert) {
            Button("☹️", role: .cancel) { }
        }
        .onAppear {
            delegate?.loadGridData(completion: { result in
                switch result {
                case .success:
                    print("Data retrieved successfully.")
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
        }
    }
}

#Preview {
    Day2CubeConundrumView()
}
