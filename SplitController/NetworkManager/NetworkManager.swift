//
//  NetworkManager.swift
//  SplitController
//
//  Created by Gor on 11/27/20.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    
    func loadJson( completion: @escaping ([Metadata]?) -> Void) {
        let url = URL(string: "https://www.helix.am/temp/json.php")
        if let url = url {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                let decoder = JSONDecoder()
                if let data = data, let result = try? decoder.decode(Json.self, from: data) {
                    completion(result.metadata)
                } else {
                    completion(nil)
                }
            }
            task.resume()
        } else {
            completion(nil)
        }
    }
    
    func requestImage(for url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
}
