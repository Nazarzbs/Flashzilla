//
//  Card.swift
//  Flashzilla
//
//  Created by Nazar on 2/9/24.
//

import Foundation
import SwiftData

@Model
class Card: Identifiable {
    var id: UUID
    var prompt: String
    var answer: String
    var created: Date
    
    init(id: UUID, prompt: String, answer: String, created: Date) {
        self.prompt = prompt
        self.answer = answer
        self.id = id
        self.created = created
    }
    
//    func encode(to encoder: any Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(prompt, forKey: .prompt)
//        try container.encode(answer, forKey: .answer)
//        try container.encode(id, forKey: .id)
//    }
//    
//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        prompt = try container.decode(String.self, forKey: .prompt)
//        answer = try container.decode(String.self, forKey: .answer)
//        id = try container.decode(UUID.self, forKey: .id)
//        
//    }
    
    static let example = Card(id: UUID(), prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Whittaker", created: Date.now)
    
//    private enum CodingKeys: String, CodingKey {
//            case id
//            case prompt
//            case answer
//        }
}


