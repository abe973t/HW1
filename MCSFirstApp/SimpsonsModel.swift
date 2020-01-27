//
//  xTableViewCell.swift
//  MCSFirstApp
//
//  Created by mcs on 1/23/20.
//  Copyright © 2020 mcs. All rights reserved.
//

import UIKit

struct RootClass: Decodable {
    var abstractField: String!
    var abstractSource: String!
    var abstractText: String!
    var abstractURL: String!
    var answer: String!
    var answerType: String!
    var definition: String!
    var definitionSource: String!
    var definitionURL: String!
    var entity: String!
    var heading: String!
    var image: String!
    var imageHeight: Int!
    var imageIsLogo: Int!
    var imageWidth: Int!
    var infobox: String!
    var redirect: String!
    var relatedTopics: [RelatedTopic]!
    var type: String!
    
    enum Keys: String, CodingKey {
      case relatedTopics = "RelatedTopics"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
          
        self.relatedTopics = try container.decode([RelatedTopic]?.self, forKey: .relatedTopics)
    }
}

struct RelatedTopic: Decodable {
    var firstURL: String!
    var icon: Icon!
    var result: String!
    var text: String!
        
    enum Keys: String, CodingKey {
      case firstURL = "FirstURL", icon = "Icon", result = "Result", text = "Text"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
          
        self.firstURL = try container.decode(String?.self, forKey: .firstURL)
        self.icon = try container.decode(Icon?.self, forKey: .icon)
        self.result = try container.decode(String?.self, forKey: .result)
        self.text = try container.decode(String?.self, forKey: .text)
    }
}

struct Icon: Decodable {
    var height: String!
    var url: String!
    var width: String!
        
    enum Keys: String, CodingKey {
        case height = "Height", url = "URL", width = "Width"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
              
        self.height = try container.decode(String?.self, forKey: .height)
        self.url = try container.decode(String?.self, forKey: .url)
        self.width = try container.decode(String?.self, forKey: .width)
    }
}
