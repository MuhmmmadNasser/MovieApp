//
//  TrailerAPI.swift
//  MovieApp
//
//  Created by Mohamed on 03/04/2022.
//

import Foundation

protocol TrailerAPIProtocol {
    func getTrailer(key: Int, completion: @escaping (Swift.Result<TrailerResponse?, NSError>) -> Void)
}

class TrailerAPI: BaseAPI<TrailerNetworking>, TrailerAPIProtocol {
    func getTrailer(key: Int, completion: @escaping (Swift.Result<TrailerResponse?, NSError>) -> Void) {
        self.fetchData(target: .getTrailer(key: key), responseClass: TrailerResponse.self) { (result) in
            completion(result)
            
        }
    }
}
