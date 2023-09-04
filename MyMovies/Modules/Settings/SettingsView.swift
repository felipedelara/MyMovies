//
//  SettingsView.swift
//  MyMovies
//
//  Created by Felipe Lara on 02/09/2023.
//

import SwiftUI

struct SettingsView: View {

    @ObservedObject var viewModel: SettingsViewModel

    var body: some View {
        VStack {
            Image(systemName: "popcorn.circle").font(.system(size: 120)).foregroundColor(viewModel.isValidAccessToken ? .green : .red)

            TextField("Enter an access token for the API", text: $viewModel.accessToken)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
                .onAppear {

                    self.viewModel.attemptSavedToken()
                }

            Button(action: {
                self.viewModel.validateToken()
            }) {
                PrimaryButtonContent(title: "Validate token", isLoading: viewModel.isLoading)
            }
            .padding(.horizontal, 20)
            .frame(height: 40.0)
            .buttonStyle(PrimaryButtonStyle())

            if viewModel.isValidAccessToken {
                Text("Valid token ✅ You can start using the app normally.")
                    .foregroundColor(.green)
                    .font(.callout)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
            } else {
                Text("Invalid or no token ❌ Please add a valid API token from TheMovieDB")
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
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(viewModel: SettingsViewModel())
    }
}
