//
//  UserDefaultsManager.swift
//  MyMovies
//
//  Created by Felipe Lara on 04/09/2023.
//

import Foundation

protocol UserDefaultsManagerType {

    func getAccessToken() -> String?
    func save(accessToken: String)
}

class UserDefaultsManager: UserDefaultsManagerType {

    func getAccessToken() -> String? {

        return UserDefaults.standard.string(forKey: Constants.apiAccessTokenKey)
    }

    func save(accessToken: String) {

        UserDefaults.standard.set(accessToken, forKey: Constants.apiAccessTokenKey)
        UserDefaults.standard.synchronize()
    }
}
