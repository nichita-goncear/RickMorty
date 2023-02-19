//
//  ApiManager.swift
//  Rick&Morty
//
//  Created by Nikita Gonchar on 17.02.2023.
//

import Foundation

class ServiceManager {
    public static let shared = ServiceManager()
    
    private init() {}
    
    func getRequest<T: Decodable>(urlString: String, success: @escaping (T) -> (), fail: @escaping () -> ()) {
        guard let url = URL(string: urlString) else {
            return fail()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode),
                  let data = data,
                  error == nil else {
                return fail()
            }
            
            if let model = try? JSONDecoder().decode(T.self, from: data) {
                success(model)
            } else {
                fail()
            }
        }
        
        task.resume()
    }
}
