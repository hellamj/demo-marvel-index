//
//  Characters.swift
//  MarvelApp
//
//  Created by admin on 6/24/21.
//

import Foundation

struct CharacterResponse: Codable {
    var code: Int?
    var status: String?
    var copyright: String?
    var attributionText: String?
    var attributionHTML: String?
    var data: CharacterData?
    var etag: String?
}
struct CharacterData: Codable {
    var offset: Int?
    var limit: Int?
    var total: Int?
    var count: Int?
    var results: [CharacterResult]?
}
struct CharacterResult: Codable {
    var id: Int?
    var name: String?
    var description: String?
    var modified: String?
    var resourceURI: String?
    var urls: [CharacterUrl]?
    var thumbnail: Thumbnail?
    var comics: Comics?
    var stories: Stories?
    var events: Events?
    var series: Series?
}
struct CharacterUrl: Codable {
    var type: String?
    var url: String?
}
struct Thumbnail: Codable {
    var path: String?
    var thumbExtension: String?
    private enum CodingKeys: String, CodingKey {
        case path
        case thumbExtension = "extension"
    }
}
struct Comics: Codable {
    var available: Int?
    var returned: Int?
    var collectionURI: String?
    var items: [ComicItem]?
}
struct ComicItem: Codable {
    var resourceURI: String?
    var name: String?
}
struct Stories: Codable {
    var available: Int?
    var returned: Int?
    var collectionURI: String?
    var items: [StorieItem]?
}
struct StorieItem: Codable {
    var resourceURI: String?
    var name: String?
    var type: String?
}
struct Events: Codable {
    var available: Int?
    var returned: Int?
    var collectionURI: String?
    var items: [EventItem]?
}
struct EventItem: Codable {
    var resourceURI: String?
    var name: String?
}
struct Series: Codable {
    var available: Int?
    var returned: Int?
    var collectionURI: String?
    var items: [SerieItem]?
}
struct SerieItem: Codable {
    var resourceURI: String?
    var name: String?
}
