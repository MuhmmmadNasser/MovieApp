//
//  NetworkManager.swift
//  MovieApp
//
//  Created by Mohamed on 31/08/2021.
//

import Foundation
import Network

//Check if cellular data or WiFi is on in Swift
/*
class NetworkManager {
    
    func monitorNetwork(){
        let monitor = NWPathMonitor()
        
        monitor.pathUpdateHandler = { pathUpdateHandler in
            if pathUpdateHandler.status == .satisfied {
                print("Internet connection is on.")
            } else {
                print("There's no internet connection.")
                
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Network", message: "There's no internet connection.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    //print("There's no internet connection.")
                }
                

            }
        }
        let queue = DispatchQueue(label: "InternetConnectionMonitor")
        monitor.start(queue: queue)
    }
}
*/
