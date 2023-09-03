//
//  AuthenticateResponse.swift
//  MyMovies
//
//  Created by Felipe Lara on 02/09/2023.
//

import Foundation

// MARK: - AuthenticateResponse
struct AuthenticateResponse: Codable {

    let statusCode: Int
    let statusMessage: String
    let success: Bool

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case statusMessage = "status_message"
        case success
    }
}
