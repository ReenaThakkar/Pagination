//
//  APIManager.swift
//  PaginationData
//
//  Created by Reena on 6/1/24.
//

import Alamofire

class APIService {
    static let shared = APIService()
    
    func fetchPosts(page: Int, completion: @escaping ([Post]?, Error?) -> Void) {
        let url = "https://jsonplaceholder.typicode.com/posts"
        let parameters: Parameters = ["_page": page]
        
        AF.request(url, parameters: parameters).responseDecodable(of: [Post].self) { response in
            switch response.result {
            case .success(let posts):
                completion(posts, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
