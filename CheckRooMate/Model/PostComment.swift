//
//  PostComment.swift
//  CheckRooMate
//
//  Created by Furkan Açıkgöz on 25.05.2022.
//

import Foundation

struct PostComment: Codable {
    
    var postcommentId: Int?
    var postId: Int?
    var userId: Int?
    var commentContent: String?
    var commentTime: String?

}
