//
//  SettingsDataSource.swift
//  MyMovies
//
//  Created by Felipe Lara on 03/09/2023.
//

import Foundation

protocol SettingsDataSourceType {

    func getAccessToken() -> String?
    func save(accessToken: String)
    func authenticate(apiAccessToken: String) async -> Bool
}

enum Constants {

    static let apiAccessTokenKey = "apiAccessTokenKey"
}

//TODO: move this, add protocol, and adjust dependencies
class SettingsDataSource: SettingsDataSourceType  {

    func getAccessToken() -> String? {

        return UserDefaults.standard.string(forKey: Constants.apiAccessTokenKey)
    }

    func save(accessToken: String) {

        UserDefaults.standard.set(accessToken, forKey: Constants.apiAccessTokenKey)
        UserDefaults.standard.synchronize()
    }

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
            print(authenticateResponse)

            return authenticateResponse.success

        } catch {

            print(error)
            return false
        }
    }
}

class SettingsDataSourceMock: SettingsDataSourceType {

    func getAccessToken() -> String? { nil }
    func save(accessToken: String) { }
    func authenticate(apiAccessToken: String) async -> Bool { true }
}
