//
//  Articles.swift
//  reader
//
//  Created by Krina on 10/11/24.
//


import Foundation
struct Articles : Codable {
    let source : Source?
    let author : String?
    let title : String?
    let description : String?
    let url : String?
    let urlToImage : String?
    let publishedAt : Date?
    let content : String?
    
    enum CodingKeys: String, CodingKey {
        
        case source = "source"
        case author = "author"
        case title = "title"
        case description = "description"
        case url = "url"
        case urlToImage = "urlToImage"
        case publishedAt = "publishedAt"
        case content = "content"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        source = try values.decodeIfPresent(Source.self, forKey: .source)
        author = try values.decodeIfPresent(String.self, forKey: .author)?.trimmingCharacters(in: .whitespaces)
        title = try values.decodeIfPresent(String.self, forKey: .title)?.trimmingCharacters(in: .whitespaces)
        description = try values.decodeIfPresent(String.self, forKey: .description)?.trimmingCharacters(in: .whitespaces)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        urlToImage = try values.decodeIfPresent(String.self, forKey: .urlToImage)
        let dateStr = try values.decodeIfPresent(String.self, forKey: .publishedAt)
        publishedAt = dateStr?.toDate(format: "yyyy-MM-dd'T'HH:mm:ssZ")
        content = try values.decodeIfPresent(String.self, forKey: .content)

    }
    
}




