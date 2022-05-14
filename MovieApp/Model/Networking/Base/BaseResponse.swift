//
//  BaseResponse.swift
//  MovieApp
//
//  Created by Mohamed on 02/04/2022.
//

import Foundation

class BaseResponse<T: Codable>: Codable {
    
    var result: T?
}
