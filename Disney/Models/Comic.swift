//
//  Comic.swift
//  Disney
//
//  Created by Pierre Moreau on 7/25/21.
//

import UIKit

struct Comic {
    var id: Int
    var title: String
    var thumbnail: URL?
    var description: String?
}

extension Comic: Decodable {
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case thumbnail
        case description
    }
    
    private enum ImageKeys: String, CodingKey {
        case path
        case extensionImage = "extension"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        
        if let imageContainer = try? container.nestedContainer(keyedBy: ImageKeys.self, forKey: .thumbnail),
           let imagePath = try? imageContainer.decodeIfPresent(String.self, forKey: .path),
           let imageExtension = try? imageContainer.decodeIfPresent(String.self, forKey: .extensionImage),
           !imagePath.isEmpty, !imageExtension.isEmpty {
            thumbnail = URL(string: imagePath + "." + imageExtension)
        }
        
        description = try? container.decodeIfPresent(String.self, forKey: .description)
    }
}
