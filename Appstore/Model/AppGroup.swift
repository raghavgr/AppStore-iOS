//
//  AppGroup.swift
//  Appstore
//
//  Created by Sai Grandhi on 5/30/19.
//  Copyright © 2019 Grandhi. All rights reserved.
//

import Foundation

struct AppGroup: Decodable{
    
    let feed: Feed
}


struct Feed: Decodable {
    let title: String
    let results: [FeedResult]
}

struct FeedResult: Decodable {
    let name, artistName, artworkUrl100: String
}
