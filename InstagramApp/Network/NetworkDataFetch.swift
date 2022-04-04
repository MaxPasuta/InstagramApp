//
//  NetworkDataFetch.swift
//  InstagramApp
//
//  Created by Максим Пасюта on 27.03.2022.
//

import Foundation

import Foundation
import UIKit


class NetworkDataFetch {
    
    static let shared = NetworkDataFetch()
    
    private init() {}
    
    private var position = 0
    
    func fetch10Post( responce: @escaping([Post]?, Error?) -> Void){

        let urlString = "https://jsonplaceholder.typicode.com/photos?_start=\( self.position)&_limit=10"
        self.position =  self.position + 10
        
        NetworkRequest.shated.requestData(urlString: urlString) { result in
            
            switch result {
            case .success(let data):
                do {
                    let data = try JSONDecoder().decode([Post].self, from: data)
                    responce(data, nil)
                    
                } catch let jsonerror{
                    print("Failed to decode JSON: \(jsonerror.localizedDescription)")
                }
                
            case .failure(let error):
                print("Error received reuestiing data: \(error.localizedDescription)")
                responce(nil, error)
            }
        }
    }
}
