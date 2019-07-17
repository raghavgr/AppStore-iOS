//
//  Service.swift
//  Appstore
//
//  Created by Sai Grandhi on 5/20/19.
//  Copyright © 2019 Grandhi. All rights reserved.
//

import Foundation

class Service {
    
    static let shared = Service() // singleton
    
    func fetchApps(searchTerm: String, completion: @escaping ([Result], Error?) -> ()) {
        let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&entity=software"
        guard let url = URL(string: urlString) else { return }
        // fetch data from Internet
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            
            if let err = err {
                print("Failed to retrieve apps: ", err)
                completion([], nil)
                return
            }
            
            // SUCCESS
            // print(String(data: data!, encoding: .utf8))
            guard let data = data else { return }
            do {
                let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
                //searchResult.results.forEach({print($0.trackName, $0.primaryGenreName)})

                
                completion(searchResult.results, nil)
                
            } catch let jsonErr{
                print("Failed to decode json: ", jsonErr)
                completion([], jsonErr)
            }
        }.resume() // fires off the request
    }
    
    func fetchGames(completion: @escaping (AppGroup?, Error?) -> ()) {
        // https://rss.itunes.apple.com/api/v1/us/ios-apps/new-games-we-love/all/50/explicit.json
        
        let urlString = "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-grossing/all/50/explicit.json"
        
        guard let url = URL(string: urlString)
            else {
                return
        }

        URLSession.shared.dataTask(with: url) {
            (data, resp, err) in
            
            if let err = err {
                print("Failed to retrieve games: ", err)

                completion(nil, err)
                return
            }
            
            //print(String(data: data!, encoding: .utf8))
            do {
                let appGroupResult = try JSONDecoder().decode(AppGroup.self, from: data!)
                //print(appGroupResult.feed.results)
                appGroupResult.feed.results.forEach({print($0.name)})
                completion(appGroupResult, nil)
            } catch let jsonErr {
                completion(nil, jsonErr)
                //print("Failed to decode jsonL ", jsonErr)
            }
        }.resume() // this will fire your request
        
    }
 
}
