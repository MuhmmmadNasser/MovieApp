//
//  TrailerNetworking.swift
//  MovieApp
//
//  Created by Mohamed on 03/04/2022.
//

import Foundation
import  Alamofire

enum TrailerNetworking {
    case getTrailer(key: Int)
}

extension TrailerNetworking: TargetType {
    var baseURL: String {
        switch self {
        default:
            return Constants.BASE_URL
        }
    }
    
    var path: String {
        switch self {
        case .getTrailer(key: var key):
            return "/movie/\(key)/videos?api_key=15ce9ec70ad1f97cc77805efcdc0bb68"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getTrailer:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getTrailer:
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
