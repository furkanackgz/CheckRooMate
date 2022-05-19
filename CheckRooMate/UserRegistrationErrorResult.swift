//
//  UserRegistrationErrorResult.swift
//  CheckRooMate
//
//  Created by Furkan Açıkgöz on 18.05.2022.
//

import Foundation

struct UserRegistrationErrorResult: Decodable {
    let code: String?
    let errno: Int?
    let sqlMessage: String?
    let sqlState: String?
    let index: Int?
    let sql: String?
}
