//
//  Series.swift
//  MarvelApp
//
//  Created by admin on 6/29/21.
//

import Foundation

struct SeriesResponse: Codable {
    var data: SeriesData?
}

struct SeriesData: Codable {
    var results: [SeriesResult]?
}

struct SeriesResult: Codable {
    var urls: [Urls]?
    var thumbnail: Images?
}


struct Urls: Codable {
    var type: String?
    var url: String?
}

struct Images: Codable {
    var path: String?
    var imageExtension: String?
    
    private enum CodingKeys: String, CodingKey {
        case path
        case imageExtension = "extension"
    }
}
