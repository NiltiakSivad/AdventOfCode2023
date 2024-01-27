import Foundation

class RootViewPresenter: RootViewDelegate {
    private let sessionTokenInteractor = SessionTokenInteractor();

    var renderer: RootViewRendering?

    func checkLoginStatus() {
        if sessionTokenInteractor.getSessionToken() == nil {
            renderer?.properties.showLoginView = true
        } else {
            renderer?.properties.showLoginView = false
        }
    }

    func loginTapped(token: String) {
        let didSucceed = sessionTokenInteractor.setSessionToken(token: token)
        if didSucceed {
            renderer?.properties.showLoginView = false
        } else {
            // Show error message
        }
    }
    
    func useLocalPuzzleInputTapped() {
        renderer?.properties.showLoginView = false
    }
    
}

// MARK: - State

private extension RootViewPresenter {
    final class State {
        private let isUserLoggedIn = false
    }
}
