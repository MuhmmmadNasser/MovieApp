//
//  MoviesNeworking.swift
//  MovieApp
//
//  Created by Mohamed on 02/04/2022.
//

import Foundation

import Alamofire

enum MoviesNetworking  {
    case getMovies
    case createUser(name: String, job: String)
}

extension MoviesNetworking: TargetType {
    var baseURL: String {
        switch self {
        default:
            return Constants.BASE_URL
        }
    }
    
    var path: String {
        switch self {
        case .getMovies:
            return Constants.GET_MOVIES
        case .createUser:
            return "/users"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getMovies:
            return .get
        case .createUser:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .getMovies:
            return .requestPlain
        case .createUser(let name, let job):
            return .requestParameters(parameters: ["name" : name, "job": job], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return [:]
        }
        /*
        switch self {
        default:
            return ["Authorization": "Token"]
        }*/
    }
    
    
}
