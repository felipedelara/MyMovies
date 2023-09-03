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
}

class APIService {

    //TODO: mobe page to header
    let getMoviesUrlString = "https://api.themoviedb.org/3/movie/popular?language=en-US&page=1"

    func getMovies() async throws -> [Movie] {

        guard let token = UserDefaults.standard.string(forKey: Constants.apiAccessTokenKey) else {

            throw ServiceError.noToken
        }

        let headers = ["accept": "application/json",
                       "Authorization": "Bearer \(token)"]

        guard let url = URL(string: getMoviesUrlString) else {

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
}
