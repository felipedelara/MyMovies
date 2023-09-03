//
//  SettingsView.swift
//  MyMovies
//
//  Created by Felipe Lara on 02/09/2023.
//

import SwiftUI

struct SettingsView: View {

    @State private var accessToken: String = ""
    @State private var isValidAccessToken: Bool = false
    @State private var isLoading: Bool = false

    var body: some View {
        VStack {
            Image(systemName: "popcorn.circle").font(.system(size: 120)).foregroundColor(isValidAccessToken ? .green : .red)

            TextField("Enter an access token for the API", text: $accessToken)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .onAppear {

                    self.attemptSavedToken()
                }

            Button(action: {
                self.validateToken()
            }) {
                PrimaryButtonContent(title: "Validate token", isLoading: isLoading)
            }
            .padding(.horizontal, 20)
            .frame(height: 40.0)
            .buttonStyle(PrimaryButtonStyle())

            if isValidAccessToken {
                Text("Valid token ✅ You can start using the app normally.")
                    .foregroundColor(.green)
                    .font(.callout)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
            } else {
                Text("Invalid token ❌ Please add a valid API token from TheMovieDB")
                    .foregroundColor(.red)
                    .font(.callout)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
            }

            Link("Go to TheMovieDB", destination: URL(string: "https://developer.themoviedb.org/v3/reference/intro/authentication#api-key-quick-start")!)
                .font(.body)
                .padding()

            Spacer()
        }.padding(.top, 20)
    }

    func attemptSavedToken() {

        if let token = self.getAccessToken() {

            self.accessToken = token
            self.validateToken()
        }
    }

    func validateToken() {

        Task {

            self.isLoading = true

            do {
                self.isValidAccessToken = await APIService().authenticate(apiAccessToken: self.accessToken)

                if self.isValidAccessToken {

                    self.save(accessToken: self.accessToken)
                }

                DispatchQueue.main.async {

                    self.isLoading = false
                }
            }
        }
    }

    func getAccessToken() -> String? {

        return UserDefaults.standard.string(forKey: Constants.apiAccessTokenKey)
    }

    func save(accessToken: String) {

        UserDefaults.standard.set(accessToken, forKey: Constants.apiAccessTokenKey)
        UserDefaults.standard.synchronize()
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
