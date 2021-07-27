//
//  MarvelError.swift
//  Disney
//
//  Created by Pierre Moreau on 7/26/21.
//

struct MarvelError: Error {
    var title: String
    var message: String
    
    static var invalidUrl: MarvelError { MarvelError(title: "Failed", message: "The url format is invalid.") }
    static var generic: MarvelError { MarvelError(title: "Failed", message: "An error occured, please try again.") }
}

extension MarvelError: Codable {
    
    private enum CodingKeys: String, CodingKey {
        case title = "code"
        case message
        case status
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        //Backend seems to return two error struct type (code<String> + status<String>) or (code<Int> + message<String>)
        if let codeString = try? container.decode(String.self, forKey: .title) {
            title = codeString
            message = try container.decode(String.self, forKey: .message)
        }
        else {
            let codeInt = try container.decode(Int.self, forKey: .title)
            title = "Error code: \(codeInt)"
            message = try container.decode(String.self, forKey: .status)
        }
    }
    
    func encode(to encoder: Encoder) throws { }
}
