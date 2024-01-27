import Foundation

struct RootCoordinator {
    
    func launch() -> RootView {
        let presenter = RootViewPresenter()
        var view = RootView(properties: .default)
        view.loginView.delegate = presenter
        view.delegate = presenter
        presenter.renderer = view
        return view
    }
}
