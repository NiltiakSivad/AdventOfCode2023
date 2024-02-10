import SwiftUI

protocol LoginViewDelegate {
    func loginTapped(token: String)
    func useLocalPuzzleInputTapped()
}

struct LoginView: View {
    
    var delegate: LoginViewDelegate?
    
    @State private var sessionToken = ""
    
    var body: some View {
        List {
            Text("Log In").font(.largeTitle).bold()
            VStack {
                Spacer()
                Text("Advent of Code generates different puzzle input for every user. \n\nEnter your session token below if you would like to use puzzle data from your own account and generate solutions for it. If not, this app is bundled with sample input.")
                Spacer()
                Spacer()
                TextField("Enter your session token", text: $sessionToken)
                Spacer()
                Button(action: {
                    if (sessionToken != "") {
                        delegate?.loginTapped(token: sessionToken)
                    }
                }) {
                    Text("Log in")
                        .frame(maxWidth: .infinity)
                }.tint(.green)
                .buttonStyle(.borderedProminent)
                Button(action: {
                    delegate?.useLocalPuzzleInputTapped()
                }) {
                    Text("No thanks, use local puzzle input").tint(.black)
                        .frame(maxWidth: .infinity)
                      
                }
                .foregroundColor(.black)
                    .buttonStyle(.bordered)
                Spacer()
            }

            Text("⚠️ This is an obviously sketch thing to ask for; however, this is a test application for learning purposes only. The token is used only to retrieve your puzzle input, and is stored on your local device in the keychain so you are not asked again on subsequent launches.").font(.footnote).foregroundStyle(.gray).bold()
        }
        .listStyle(.insetGrouped)
    }
}

#Preview {
    LoginView()
}
