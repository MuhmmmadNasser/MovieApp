//
//  MovieApiManage.swift
//  MovieApp
//
//  Created by Mohamed on 13/08/2021.
//

import Foundation
import Alamofire

class HomeMovieApiManager {
    
    
    func fetchData(completion: @escaping([Movie]?, String?) -> Void){
        
        //let url = URL(string: "http://api.themoviedb.org/3/discover/movie?api_key=15ce9ec70ad1f97cc77805efcdc0bb68")
        
        if let url = URL(string: "https://api.themoviedb.org/3/discover/movie?%20desc&api_key=15ce9ec70ad1f97cc77805efcdc0bb68"){
            
            let request = AF.request(url, method: .get, encoding: JSONEncoding.default)
            
            request.responseJSON { (dataResponse) in
                if let data = dataResponse.data{
                    
                    let jsondecoder = JSONDecoder()
                    
                    do{
                        if let decodedObj = try? jsondecoder.decode(Menu.self, from: data){
                            
                            completion(decodedObj.results, nil)
                        }
                    }
                    catch{
                        print(error.localizedDescription)
                    }
                    
                }
                if let error = dataResponse.error{
            
                    completion(nil, error.localizedDescription)
                    
                }
            }
            
        }
        
    }
 
 
    
    
    
    
    
     //MARK: - If I want to make sure of data
    func fetchDataApi(){
        
        let url = URL(string: "https://api.themoviedb.org/3/discover/movie?%20desc&api_key=15ce9ec70ad1f97cc77805efcdc0bb68")

        var request = AF.request(url as! URLConvertible, method: .get, encoding: JSONEncoding.default)
        
        request.responseJSON { (dataResponse) in
            if let data = dataResponse.data{
                
                print(String(data: data, encoding: .utf8))
            }
            if let error = dataResponse.error{
                print(error.localizedDescription)
            }
        }
        
    }
    
 
}
