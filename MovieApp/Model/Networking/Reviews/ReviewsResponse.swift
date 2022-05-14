//
//  ReviewsResponse.swift
//  MovieApp
//
//  Created by Mohamed on 03/04/2022.
//

import Foundation

class ReviewsResponse: Codable {
    var id: Int?
    var results: [ReviewsContent]?
}
