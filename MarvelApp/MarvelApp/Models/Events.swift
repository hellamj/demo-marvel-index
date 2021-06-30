//
//  Events.swift
//  MarvelApp
//
//  Created by admin on 6/29/21.
//

import Foundation

struct EventResponse: Codable {
    var data: EventData?
    
}

struct EventData: Codable {
    var results: [EventResult]?
}

struct EventResult: Codable {
    var urls: [Urles]?
    var thumbnail: Imagee?
}


struct Urles: Codable {
    var type: String?
    var url: String?
}

struct Imagee: Codable {
    var path: String?
    var imageExtension: String?
    
    private enum CodingKeys: String, CodingKey {
        case path
        case imageExtension = "extension"
    }
}
