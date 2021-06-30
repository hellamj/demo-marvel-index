//
//  Comics.swift
//  MarvelApp
//
//  Created by admin on 6/28/21.
//

import Foundation

struct ComicResponse: Codable {
    var data: ComicData?
    
}

struct ComicData: Codable {
    var results: [ComicResult]?
}

struct ComicResult: Codable {
    var urls: [Url]?
    var thumbnail: Image?
}


struct Url: Codable {
    var type: String?
    var url: String?
}

struct Image: Codable {
    var path: String?
    var imageExtension: String?
    
    private enum CodingKeys: String, CodingKey {
        case path
        case imageExtension = "extension"
    }
}

