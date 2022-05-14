//
//  BaseAPI.swift
//  MovieApp
//
//  Created by Mohamed on 02/04/2022.
//

import Foundation
import Alamofire


class BaseAPI<T: TargetType> {
    
    func fetchData<M: Decodable>(target: T, responseClass: M.Type, completion: @escaping (Swift.Result<M?, NSError>) -> Void) {
        let method = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
        let headers = Alamofire.HTTPHeaders(target.headers ?? [:])
        let params = buildParams(task: target.task)
        
        AF.request(target.baseURL + target.path, method: method, parameters: params.0, encoding: params.1, headers: headers).responseJSON { (response) in
            guard let statusCode = response.response?.statusCode else {
                // ADD Custom Error
                completion(.failure(NSError()))
                return
            }
            
            if statusCode == 200 { // 200 reflect success response
                //Successful request
                guard let jsonResponse = try? response.result.get() else {
                    // ADD Custom Error
                    let error = NSError(domain: target.baseURL, code: 0, userInfo: [NSLocalizedDescriptionKey: ErrorMessage.genericsError])
                    completion(.failure(error))
                    return
                }
                guard let theJsonData = try? JSONSerialization.data(withJSONObject: jsonResponse, options: []) else {
                    // ADD Custom Error
                    let error = NSError(domain: target.baseURL, code: 0, userInfo: [NSLocalizedDescriptionKey: ErrorMessage.genericsError])
                    completion(.failure(error))
                    return
                }
                guard let responseObj = try? JSONDecoder().decode(M.self, from: theJsonData) else {
                    // ADD Custom Error
                    let error = NSError(domain: target.baseURL, code: 0, userInfo: [NSLocalizedDescriptionKey: ErrorMessage.genericsError])
                    completion(.failure(error))
                    return
                }
                completion(.success(responseObj))
            } else {
                // ADD Custom Error base on staus cose 401 / 404 ..
                //Error paring for the error message from back end
                let message = "Error Message parsing from BE"
                let error = NSError(domain: target.baseURL, code: statusCode, userInfo: [NSLocalizedDescriptionKey: message])
                completion(.failure(error))
            }
            
            
        }
    }
    
    
    /*
    func fetchData<M: Decodable>(target: T, responseClass: M.Type, completion: @escaping (M?, String?) -> Void) {
        let method = Alamofire.HTTPMethod(rawValue: target.method.rawValue)
        let headers = Alamofire.HTTPHeaders(target.headers ?? [:])
        let params = buildParams(task: target.task)
        
        AF.request(target.baseURL + target.path, method: method, parameters: params.0, encoding: params.1, headers: headers).responseJSON { (response) in
            guard let statusCode = response.response?.statusCode else {
                // ADD Custom Error
                completion(nil, response.error?.localizedDescription)
                return
            }
            
            if statusCode == 200 { // 200 reflect success response
                //Successful request
                guard let jsonResponse = try? response.result.get() else {
                    // ADD Custom Error
                    let error = NSError(domain: target.baseURL, code: 0, userInfo: [NSLocalizedDescriptionKey: ErrorMessage.genericsError])
                    completion(nil, response.error?.localizedDescription)
                    return
                }
                guard let theJsonData = try? JSONSerialization.data(withJSONObject: jsonResponse, options: []) else {
                    // ADD Custom Error
                    let error = NSError(domain: target.baseURL, code: 0, userInfo: [NSLocalizedDescriptionKey: ErrorMessage.genericsError])
                    completion(nil, response.error?.localizedDescription)
                    return
                }
                guard let responseObj = try? JSONDecoder().decode(M.self, from: theJsonData) else {
                    // ADD Custom Error
                    let error = NSError(domain: target.baseURL, code: 0, userInfo: [NSLocalizedDescriptionKey: ErrorMessage.genericsError])
                    completion(nil, response.error?.localizedDescription)
                    return
                }
                completion(responseObj, nil)
            } else {
                // ADD Custom Error base on staus cose 401 / 404 ..
                //Error paring for the error message from back end
                let message = "Error Message parsing from BE"
                let error = NSError(domain: target.baseURL, code: statusCode, userInfo: [NSLocalizedDescriptionKey: message])
                completion(nil, response.error?.localizedDescription)
            }
            
            
        }
    }
    */
    
    private func buildParams(task: Task) -> ([String: Any], ParameterEncoding) {
        switch task {
        
        case .requestPlain:
            return ([:], URLEncoding.default)
        case .requestParameters(parameters: let parameters, encoding: let encoding):
            return (parameters, encoding)
        }
    
    }
}

