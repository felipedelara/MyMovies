//
//  SettingsViewModel.swift
//  MyMovies
//
//  Created by Felipe Lara on 04/09/2023.
//

import Foundation

class SettingsViewModel: ObservableObject {

    @Published var accessToken: String = ""
    @Published private(set) var isValidAccessToken: Bool = false
    @Published private(set) var isLoading: Bool = false

    func attemptSavedToken() {

        if let token = self.getAccessToken() {

            self.accessToken = token
            self.validateToken()
        }
    }

    func validateToken() {

        self.isLoading = true

        Task {

            do {
                let isValidAccessToken = await APIService().authenticate(apiAccessToken: self.accessToken)

                if isValidAccessToken {

                    self.save(accessToken: self.accessToken)
                }

                DispatchQueue.main.async {

                    self.isValidAccessToken = isValidAccessToken
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
