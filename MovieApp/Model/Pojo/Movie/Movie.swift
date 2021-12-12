//
//  Movie.swift
//  MovieApp
//
//  Created by Mohamed on 13/08/2021.
//

import Foundation


struct Movie: Codable {
    
    
    var id: Int
    var voteAverage: Double
    var posterPath: String
    var releaseDate: String
    var title:String
    var overview: String
    var popularity: Double
     
     enum CodingKeys: String, CodingKey {
        case id
        case title
        case voteAverage = "vote_average"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case overview, popularity
     }

    /*
    var adult: Bool
    var backdropPath: String
    var genreIDS: [Int]
    var id: Int
    var originalLanguage, originalTitle, overview: String
    var popularity: Double
    var posterPath, releaseDate, title: String
    var video: Bool
    var voteAverage: Double
    var voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
 */
 
 
}
