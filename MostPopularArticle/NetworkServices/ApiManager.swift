//
//  APIManager.swift
//  MostPopularArticle
//
//  Created by Sudhir Kumar on 12/11/20.
//

import Foundation

enum ArticlePeriod: Int {
    case day = 1
    case week = 7
    case month = 30
}

class ApiManager {
    let defaultSession = URLSession(configuration: .default)
    
    var dataTask: URLSessionDataTask?
    var errorMessage = ""
    
    static let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    func fetchArticles(period: ArticlePeriod, success: @escaping ([Article]) -> (), failure: @escaping (String) -> ()) {
        let completeUrl = Constants.baseUrl + "/\(period.rawValue).json?api-key=\(Constants.apiKey)"
        guard let url = URL(string: completeUrl) else {
            failure("Invalid url conversion.")
            return
        }
        
        dataTask = defaultSession.dataTask(with: url) { [weak self] (data, response, error) in
            defer {
                self?.dataTask = nil
            }
            
            if let hasError = error {
                failure("\(hasError.localizedDescription)")
            } else if let data = data {
                do {
                    let responseReslut = try ApiManager.jsonDecoder.decode(Articles.self, from: data)
                    DispatchQueue.main.async {
                        success(responseReslut.results)
                    }
                } catch {
                    DispatchQueue.main.async {
                        print("JSON decode error: \(error)")
                        failure(error.localizedDescription)
                    }
                }
            }
        }
        dataTask?.resume()
    }
}
