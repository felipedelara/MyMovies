//
//  ListResponse.swift
//  MyMovies
//
//  Created by Felipe Lara on 02/09/2023.
//

import Foundation

//MARK: - ListResponse
struct ListResponse: Codable {

    let page: Int
    let results: [Movie]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {

        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
