//
//  Constants.swift
//  MovieApp
//
//  Created by Mohamed on 02/04/2022.
//

import Foundation

struct Constants {
    static var ID: Int?
    static var KEY: Int?
    static let BASE_URL = "https://api.themoviedb.org/3"
    static let GET_MOVIES = "/discover/movie?%20desc&api_key=15ce9ec70ad1f97cc77805efcdc0bb68"
    static let GET_REVIEW = "/movie/\(ID)/reviews?api_key=15ce9ec70ad1f97cc77805efcdc0bb68"
    static let GET_TRAILER = "/movie/\(KEY)/videos?api_key=15ce9ec70ad1f97cc77805efcdc0bb68"
    
}
struct ErrorMessage {
    static let genericsError = "Something went wrong, Please try again later"
}
