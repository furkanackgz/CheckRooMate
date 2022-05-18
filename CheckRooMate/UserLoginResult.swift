//
//  UserLoginResult.swift
//  CheckRooMate
//
//  Created by Furkan Açıkgöz on 18.05.2022.
//

import Foundation

struct UserLoginResult: Codable {
    let userId: Int?
    let username: String?
    let password: String?
    let name: String?
    let surname: String?
    let email: String?
    let phone: String?
    let signupdate: String?
}
