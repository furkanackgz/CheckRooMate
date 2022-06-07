//
//  UserInformation.swift
//  CheckRooMate
//
//  Created by Furkan Açıkgöz on 7.06.2022.
//

import Foundation

struct UserInformation: Codable {
    var userId: Int?
    var username: String?
    var password: String?
    var name: String?
    var surname: String?
    var email: String?
    var phone: String?
    var signUpDate: String?
    
    enum CodingKeys: String,CodingKey {
        case userId
        case username
        case password
        case name
        case surname
        case email
        case phone
        case signUpDate = "signupdate"
    }
}
