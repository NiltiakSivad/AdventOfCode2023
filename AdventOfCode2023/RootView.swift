import SwiftUI

struct RootView: View {
    @State private var showToast = false
    
    var body: some View {
        NavigationStack {
            CalendarView()
                .navigationTitle("Advent of Code 2023")
        }
    }
    
}

#Preview {
    RootView()
}
