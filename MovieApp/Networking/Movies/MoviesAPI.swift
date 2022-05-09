//
//  MoviesAPI.swift
//  MovieApp
//
//  Created by Mohamed on 02/04/2022.
//

import Foundation


protocol MoviesAPIProtocol {
    func getMovies(completion: @escaping (Swift.Result<MoviesResponse?, NSError>) -> Void)
}

class MoviesAPI: BaseAPI<MoviesNetworking>, MoviesAPIProtocol {
    func getMovies(completion: @escaping (Swift.Result<MoviesResponse?, NSError>) -> Void) {
        self.fetchData(target: .getMovies, responseClass: MoviesResponse.self) { (result) in
            completion(result)
        }
        
    }
}
/*
 protocol MoviesAPIProtocol {
 func getMovies(completion: @escaping (BaseResponse<[Movie]>?, String?) -> Void)
 }
 
 class MoviesAPI: BaseAPI<UsersNetworking>, MoviesAPIProtocol {
 
 //MARK: - Requests
 
 func getMovies(completion: @escaping (BaseResponse<[Movie]>?, String?) -> Void) {
 
 self.fetchData(target: .getMovies, responseClass: BaseResponse<[Movie]>.self) { (result) in
 completion(result)
 }
 
 }
 }
 */
