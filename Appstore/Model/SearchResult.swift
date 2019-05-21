//
//  SearchResult.swift
//  Appstore
//
//  Created by Sai Grandhi on 5/20/19.
//  Copyright © 2019 Grandhi. All rights reserved.
//

import Foundation

struct SearchResult: Decodable {
    let resultCount: Int
    let results: [Result]
}

struct Result: Decodable {
    let trackName: String
    let primaryGenreName: String
    var averageUserRating: Float?
    let screenshotUrls: [String]
    let artworkUrl100: String // app icon
}
