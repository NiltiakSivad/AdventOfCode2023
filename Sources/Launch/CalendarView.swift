import SwiftUI

struct CalendarView: View {
    @State private var showDay0 = false
    @State private var showDay1 = false
    @State private var showDay2 = false
    @State private var showDay3 = false

    var body: some View {
        HStack {
            VStack {
                Button("Day 0", action: {
                    showDay0.toggle()
                })
                .buttonStyle(.borderedProminent)
                .tint(.green)
                .alert("Yay to me 🎉 for starting my Advent of Code journey!", isPresented: $showDay0) {
                    Button("👏", role: .cancel) { }
                }

                Button("Day 1", action: {
                    showDay1 = true
                })
                .buttonStyle(.borderedProminent)
                .tint(.green)
                .sheet(isPresented: $showDay1) {
                    let presenter = Day1TrebuchetPresenter()
                    Day1TrebuchetView(delegate: presenter)
                }
                Button("Day 2", action: {
                    showDay2 = true
                })
                .buttonStyle(.borderedProminent)
                .tint(.green)
                .sheet(isPresented: $showDay2) {
                    let presenter = Day2CubeConundrumPresenter()
                    Day2CubeConundrumView(delegate: presenter)
                }
                Button("Day 3", action: {
                    showDay3 = true
                })
                .buttonStyle(.borderedProminent)
                .tint(.green)
                .sheet(isPresented: $showDay3) {
                    let presenter = Day3GearRatiosPresenter()
                    Day3GearRatiosView(delegate: presenter)
                }
                .buttonStyle(.borderedProminent)
                .tint(.green)
                Button("Day 4", action: {})
                    .buttonStyle(.borderedProminent)
                    .tint(.red)
                Button("Day 5", action: {})
                    .buttonStyle(.borderedProminent)
                    .tint(.red)
                Button("Day 6", action: {})
                    .buttonStyle(.borderedProminent)
                    .tint(.red)
                Button("Day 7", action: {})
                    .buttonStyle(.borderedProminent)
                    .tint(.red)
                Button("Day 8", action: {})
                    .buttonStyle(.borderedProminent)
                    .tint(.red)
                Button("Day 9", action: {})
                    .buttonStyle(.borderedProminent)
                    .tint(.red)
                Button("Day 10", action: {})
                    .buttonStyle(.borderedProminent)
                    .tint(.red)
                Button("Day 11", action: {})
                    .buttonStyle(.borderedProminent)
                    .tint(.red)
                Button("Day 12", action: {})
                    .buttonStyle(.borderedProminent)
                    .tint(.red)
            }
            .frame(maxWidth: .infinity)

            VStack {
                Button("Day 13", action: {})
                    .buttonStyle(.borderedProminent)
                    .tint(.red)
                Button("Day 14", action: {})
                    .buttonStyle(.borderedProminent)
                    .tint(.red)
                Button("Day 15", action: {})
                    .buttonStyle(.borderedProminent)
                    .tint(.red)
                Button("Day 16", action: {})
                    .buttonStyle(.borderedProminent)
                    .tint(.red)
                Button("Day 17", action: {})
                    .buttonStyle(.borderedProminent)
                    .tint(.red)
                Button("Day 18", action: {})
                    .buttonStyle(.borderedProminent)
                    .tint(.red)
                Button("Day 19", action: {})
                    .buttonStyle(.borderedProminent)
                    .tint(.red)
                Button("Day 20", action: {})
                    .buttonStyle(.borderedProminent)
                    .tint(.red)
                Button("Day 21", action: {})
                    .buttonStyle(.borderedProminent)
                    .tint(.red)
                Button("Day 22", action: {})
                    .buttonStyle(.borderedProminent)
                    .tint(.red)
                Button("Day 23", action: {})
                    .buttonStyle(.borderedProminent)
                    .tint(.red)
                Button("Day 24", action: {})
                    .buttonStyle(.borderedProminent)
                    .tint(.red)
                Button("Day 25", action: {})
                    .buttonStyle(.borderedProminent)
                    .tint(.red)
            }
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    CalendarView()
}
