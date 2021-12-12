//
//  ReviewsApiManage.swift
//  MovieApp
//
//  Created by Mohamed on 18/08/2021.
//

import Foundation
import Alamofire

// url = "https://api.themoviedb.org/3/movie/385128/reviews?api_key=15ce9ec70ad1f97cc77805efcdc0bb68"


class  ReviewsApiManage{

    func fetchReviewsData(id: Int, completion: @escaping([ReviewsContent]?, String?)->Void){
       
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)/reviews?api_key=15ce9ec70ad1f97cc77805efcdc0bb68")
           
           let request = AF.request(url as! URLConvertible, method: .get, encoding: JSONEncoding.default)
           
           request.responseJSON { (responseData) in
               if let data = responseData.data{
                   let jsonDecoder = JSONDecoder()
                       
                   let decodedobj = try?jsonDecoder.decode(ReviewMenu.self, from: data)
                   completion(decodedobj?.results, nil)
               }

               if let error = responseData.error{
                   completion(nil, error.localizedDescription)
               }
            
          }
       
      }
    
}

