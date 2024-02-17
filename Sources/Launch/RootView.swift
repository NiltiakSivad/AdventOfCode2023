import SwiftUI

protocol RootViewDelegate: AnyObject, AutoMockable, LoginViewDelegate {
    func checkLoginStatus()
}

protocol RootViewRendering {
    var properties: RootView.Properties { get set }
}

struct RootView: View, RootViewRendering {
    @ObservedObject var properties: RootView.Properties
    weak var delegate: RootViewDelegate?
    var loginView = LoginView()
    var calendarView = CalendarView()

    var body: some View {
        NavigationStack {
            if properties.showLoginView {
                loginView
            } else {
                calendarView.navigationTitle("Advent of Code 2023")
            }
        }.onAppear {
            delegate?.checkLoginStatus()
        }
    }
}

// MARK: - View Properties
extension RootView {
    class Properties: ObservableObject {
        static let `default` = Properties(showLoginView: true)

        @Published var showLoginView: Bool

        init(showLoginView: Bool) {
            self.showLoginView = showLoginView
        }

        func setUserLoggedIn() {
            showLoginView = false
        }

        func setUserLoggedOut() {
            showLoginView = true
        }
    }
}

#Preview {
    RootView(properties: .default)
}
