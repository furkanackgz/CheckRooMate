//
//  UserReview.swift
//  CheckRooMate
//
//  Created by Furkan Açıkgöz on 7.06.2022.
//

import Foundation

struct UserReview: Codable {
    var userReviewId: Int?
    var reviewedId: Int?
    var reviewerId: Int?
    var reviewContent: String?
    var reviewTime: String?
    
    enum CodingKeys: String,CodingKey {
        case userReviewId = "userreviewId"
        case reviewedId
        case reviewerId
        case reviewContent
        case reviewTime
    }
}
