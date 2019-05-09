//
//  JWTManager.swift
//  FlightClient
//
//  Created by Jose Garcia on 09/05/2019.
//  Copyright © 2019 Jose Garcia. All rights reserved.
//

import Foundation

class JWTManager {
    static let standard = JWTManager()

    private enum JWTTokenConstants: String {
        case accessToken
        case refreshToken
        case expiredAt
    }

    public func persist(jwtTokens: JWTTokens) {
        UserDefaults.standard.set(jwtTokens.accessToken, forKey: JWTTokenConstants.accessToken.rawValue)
        UserDefaults.standard.set(jwtTokens.refreshToken, forKey: JWTTokenConstants.refreshToken.rawValue)
        UserDefaults.standard.set(jwtTokens.expiredAt, forKey: JWTTokenConstants.expiredAt.rawValue)
    }

    public func deleteTokens() {
        UserDefaults.standard.set(nil, forKey: JWTTokenConstants.accessToken.rawValue)
        UserDefaults.standard.set(nil, forKey: JWTTokenConstants.refreshToken.rawValue)
        UserDefaults.standard.set(nil, forKey: JWTTokenConstants.expiredAt.rawValue)
    }
}
