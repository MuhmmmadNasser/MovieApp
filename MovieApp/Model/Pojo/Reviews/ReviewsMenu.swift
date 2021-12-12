//
//  ReviewsMenu.swift
//  MovieApp
//
//  Created by Mohamed on 18/08/2021.
//

import Foundation


struct ReviewMenu: Codable {
    let id: Int
    let results: [ReviewsContent]
    
}



/*
// MARK: - Welcome
struct ReviewsMenu: Codable {
    let id, page: Int
    let results: [ReviewsResults]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case id, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
*/
  
