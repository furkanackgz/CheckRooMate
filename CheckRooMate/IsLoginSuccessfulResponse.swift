//
//  IsLoginSuccessfulResponse.swift
//  CheckRooMate
//
//  Created by Furkan Açıkgöz on 18.05.2022.
//

import Foundation

struct IsLoginSuccessfulResponse: Codable {
    let result: UserLoginResult?
    let isLoginSuccessful: Bool?
}
