//
//  APIService.swift
//  MyMovies
//
//  Created by Felipe Lara on 03/09/2023.
//

import Foundation

enum ServiceError: Error {

    case noToken
    case invalidUrl
    case genericError
}

protocol APIServiceType {

    func getMovies() async throws -> [Movie]
    func authenticate(apiAccessToken: String) async -> Bool
}

class APIService: APIServiceType {

    func getMovies() async throws -> [Movie] {

        guard let token = UserDefaults.standard.string(forKey: Constants.apiAccessTokenKey) else {

            throw ServiceError.noToken
        }

        let headers = ["accept": "application/json",
                       "Authorization": "Bearer \(token)"]

        guard let url = URL(string: Constants.getMoviesUrlString) else {

            throw ServiceError.invalidUrl
        }

        var request = URLRequest(url: url)

        for header in headers {
            request.addValue(header.value, forHTTPHeaderField: header.key)
        }

        do {

            let (data, _) = try await URLSession.shared.data(for: request)
            let decoder = JSONDecoder()

            let response = try decoder.decode(ListResponse.self, from: data)
            return response.results

        } catch {

            throw error
        }
    }

    func authenticate(apiAccessToken: String) async -> Bool {

        let headers = ["accept": "application/json",
                       "Authorization": "Bearer \(apiAccessToken)"]

        guard let url = URL(string: Constants.authenticateUrl) else {

            //TODO: make it throw
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

            return false
        }
    }
}
