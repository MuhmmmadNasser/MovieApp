//
//  TrailerApiManage.swift
//  MovieApp
//
//  Created by Mohamed on 13/08/2021.
//

import Foundation
import Alamofire


class TrailerApiManage {
    
    
    func fetchTrailerData(key: Int ,completion: @escaping([Result]?, String?) -> Void){
        
        //let url = URL(string: "https://api.themoviedb.org/3/movie/385128/videos?api_key=15ce9ec70ad1f97cc77805efcdc0bb68")
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(key)/videos?api_key=15ce9ec70ad1f97cc77805efcdc0bb68")
            
        let request = AF.request(url as! URLConvertible, method: .get, encoding: JSONEncoding.default)
            
            request.responseJSON { (dataResponse) in
                if let data = dataResponse.data{
                    
                    let jsondecoder = JSONDecoder()
                    let decodedObj = try?jsondecoder.decode(TrailerMenu.self, from: data)
                        
                    completion(decodedObj?.results, nil)             
                }
                if let error = dataResponse.error{
                    completion(nil, error.localizedDescription)
                }
            }
    }
}

