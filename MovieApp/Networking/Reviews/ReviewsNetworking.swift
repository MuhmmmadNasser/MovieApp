//
//  ReviewsNetworking.swift
//  MovieApp
//
//  Created by Mohamed on 03/04/2022.
//

import Foundation
import Alamofire

enum ReviewsNetworking {
    case getReviews(id: Int)
}

extension ReviewsNetworking: TargetType {
    var baseURL: String {
        switch self {
        default:
            return Constants.BASE_URL
        }
    }
    
    var path: String {
        switch self {
        case .getReviews(id: var id):
            return "/movie/\(id)/reviews?api_key=15ce9ec70ad1f97cc77805efcdc0bb68"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getReviews:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getReviews:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return [:]
        }
    }
    
    
}

