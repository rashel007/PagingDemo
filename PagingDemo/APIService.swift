//
//  APIService.swift
//  PagingDemo
//
//  Created by Estique Ahmed on 1/11/20.
//

import Foundation


class APIServic {
    
    var isFetchingData = false
    
    
    func fetchData(pagination: Bool , completion: @escaping (Result<[String], Error>) -> Void) {
        isFetchingData = true
        let data = [
            "Apple",
            "Google",
            "Facebook",
            "Amazon",
            "Uber",
            "Grab",
            "Bkash",
            "Apple",
            "Google",
            "Facebook",
            "Amazon",
            "Uber",
            "Grab",
            "Bkash",
            "Apple",
            "Google",
            "Facebook",
            "Amazon",
            "Uber",
            "Grab",
            "Bkash",
            "Apple",
            "Google",
            "Facebook",
            "Amazon",
            "Uber",
            "Grab",
            "Bkash"
        ]
        
        let newData  = [
            "Banana",
            "Mango",
            "Orange",
            "Graps"
        ]
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
            self.isFetchingData = false
            completion(.success(pagination ? newData : data))
        }
        
    }
}
