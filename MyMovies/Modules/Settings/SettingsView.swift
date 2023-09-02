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
                .padding()

            Button("Validate token") {
                self.validateToken()
            }.buttonStyle(PrimaryButtonStyle())
            .padding(.horizontal, 20)
            .disabled(isLoading)

            if isValidAccessToken {
                Text("Valid token ✅")
                    .foregroundColor(.green)
                    .font(.headline)
                    .padding(.horizontal, 20)
            } else {
                Text("Invalid or empty token ❌ please add a valid api token from themoviedb")
                    .foregroundColor(.red)
                    .font(.headline)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 4)

                Link("Go to themoviedb", destination: URL(string: "https://developer.themoviedb.org/v3/reference/intro/authentication#api-key-quick-start")!)
                    .font(.body)
                    .padding()
            }

            if isLoading {
                ProgressView("Checking token...")
                    .padding()
            }

            Spacer()
        }.padding(.top, 20)
    }

    // Function to validate token
    func validateToken() {

        self.isLoading = true
        Task {
            do {
                self.isValidAccessToken = await SettingsDataSource().authenticate(apiAccessToken: self.accessToken)

                DispatchQueue.main.async {

                    self.isLoading = false
                }
            }
        }
    }
}

struct PrimaryButtonStyle: ButtonStyle {

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(configuration.isPressed ? Color.blue.opacity(0.8) : Color.blue)
            .cornerRadius(10)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

//TODO: move this, add protocol, and adjust dependencies
class SettingsDataSource {

    func authenticate(apiAccessToken: String) async -> Bool {

        let headers = ["accept": "application/json",
                       "Authorization": "Bearer \(apiAccessToken)"]

        let getMoviesUrlString = "https://api.themoviedb.org/3/authentication"

        guard let url = URL(string: getMoviesUrlString) else {

            //TODO make it throw
            return false
        }

        var request = URLRequest(url: url)

        for header in headers {

            request.addValue(header.value, forHTTPHeaderField: header.key)
        }

        do {

            let (data, _) = try await URLSession.shared.data(for: request)
            let authenticateResponse = try JSONDecoder().decode(AuthenticateResponse.self, from: data)
            return authenticateResponse.success

        } catch {

            print(error)
            return false
        }
    }
}
