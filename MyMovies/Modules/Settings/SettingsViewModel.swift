//
//  SettingsViewModel.swift
//  MyMovies
//
//  Created by Felipe Lara on 04/09/2023.
//

import Foundation

class SettingsViewModel: ObservableObject {

    // MARK: - Published properties
    @Published var accessToken: String = ""
    @Published private(set) var isValidAccessToken: Bool = false
    @Published private(set) var isLoading: Bool = false

    // MARK: - Lifecycle usage
    private var apiService: APIServiceType
    private var userDefaultsManager: UserDefaultsManagerType

    init(apiService: APIServiceType = APIService(),
         userDefaultsManager: UserDefaultsManagerType = UserDefaultsManager()) {

        self.apiService = apiService
        self.userDefaultsManager = userDefaultsManager
    }

    // MARK: - Functions
    func attemptSavedToken() {

        if let token = self.userDefaultsManager.getAccessToken() {

            self.accessToken = token
            self.validateToken()
        }
    }

    func validateToken() {

        self.isLoading = true

        Task {
            do {
                let isValidAccessToken = await apiService.authenticate(apiAccessToken: self.accessToken)

                if isValidAccessToken {

                    self.userDefaultsManager.save(accessToken: self.accessToken)
                }

                DispatchQueue.main.async {

                    self.isValidAccessToken = isValidAccessToken
                    self.isLoading = false
                }
            }
        }
    }
}
