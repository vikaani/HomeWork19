//
//  ViewController.swift
//  HomeWork19
//
//  Created by Vika on 26.04.2024.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func loadData() {
        let urlString = "https://reqres.in/api/unknown"
        
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else { return }
            guard let responseData = data else { return }
            
            do {
                let result = try JSONDecoder().decode(UserListResponse.self, from: responseData)
                debugPrint(result)
            } catch {
                debugPrint(error.localizedDescription)
            }
        }.resume()
    }
}

struct UserListResponse: Decodable {
    let page: Int
    let perPage: Int
    let total: Int
    let totalPages: Int
    let data: [UserResponse]
    
    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case total
        case totalPages = "total_pages"
        case data
    }
    
    struct UserResponse: Decodable {
        let id: Int
        let name: String
        let year: Int
        let color: String
        let pantoneValue: String
        
        enum CodingKeys: String, CodingKey {
            case id
            case name
            case year
            case color
            case pantoneValue = "pantone_value"
        }
    }
}
