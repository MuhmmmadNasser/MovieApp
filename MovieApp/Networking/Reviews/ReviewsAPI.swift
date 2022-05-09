//
//  ReviewsAPI.swift
//  MovieApp
//
//  Created by Mohamed on 03/04/2022.
//

import Foundation

protocol ReviewsAPIProtocol {
    func ReviewsAPI (id: Int, completion: @escaping (Swift.Result<ReviewsResponse?, NSError>) -> Void)
}

class ReviewsAPI: BaseAPI<ReviewsNetworking>, ReviewsAPIProtocol {
    func ReviewsAPI(id: Int, completion: @escaping (Swift.Result<ReviewsResponse?, NSError>) -> Void) {
        self.fetchData(target: .getReviews(id: id), responseClass: ReviewsResponse.self) { (result) in
            completion(result)
        }
    }  
}
