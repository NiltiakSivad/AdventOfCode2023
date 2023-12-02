import SwiftUI

struct CalendarView: View {
    @State private var showDay0 = false
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
                Button("Day 1", action: {})
                    .buttonStyle(.borderedProminent)
                    .tint(.green)
                Button("Day 2", action: {})
                    .buttonStyle(.borderedProminent)
                    .tint(.red)
                Button("Day 3", action: {})
                    .buttonStyle(.borderedProminent)
                    .tint(.red)
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
