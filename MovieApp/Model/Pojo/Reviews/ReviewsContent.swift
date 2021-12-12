//
//  ReviewsContent.swift
//  MovieApp
//
//  Created by Mohamed on 22/08/2021.
//

import Foundation

struct ReviewsContent: Codable {
    var content: String
    var author: String
    
//    enum CodingKeys: String, CodingKey {
//        case content = "content"
//    }
    
}




/*
// MARK: - Result
struct ReviewsResults: Codable {
    let author: String
    let authorDetails: AuthorDetails
    let content, createdAt, id, updatedAt: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case author
        case authorDetails = "author_details"
        case content
        case createdAt = "created_at"
        case id
        case updatedAt = "updated_at"
        case url
    }
}
*/
