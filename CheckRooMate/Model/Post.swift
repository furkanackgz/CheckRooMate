//
//  Post.swift
//  CheckRooMate
//
//  Created by Furkan Açıkgöz on 24.05.2022.
//

import Foundation

struct Post: Codable {
    
    var postId: Int?
    var userId: Int?
    var postContent: String?
    var images: String?
    var postTime: String?
    
}
