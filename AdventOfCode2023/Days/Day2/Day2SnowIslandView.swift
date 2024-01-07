import SwiftUI

protocol Day2SnowIslandViewDelegate {
    func getInput()
}

struct Day2SnowIslandView: View {
    var delegate: Day2SnowIslandViewDelegate?
    
    var body: some View {
        List {
            Section {
                Text("Day 2 🏝️")
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
                        delegate?.getInput()
                    })
                    .buttonStyle(.borderedProminent)
                    .tint(.mint)
                }
                .padding()
                
            }
        }.listStyle(.insetGrouped)
    }
}

#Preview {
    Day2SnowIslandView()
}
