//
//  Model.swift
//  ChatGPT_Text
//
//  Created by Dhruvil Moradiya on 10/03/23.
//

import Foundation


// MARK: - Temperatures
struct OpenAPIResponse: Codable {
    let id, object: String
    let created: Int
    let choices: [Choice]
    let usage: Usage
}

// MARK: - Choice
struct Choice: Codable {
    let index: Int
    let message: Message
    let finishReason: String

    enum CodingKeys: String, CodingKey {
        case index, message
        case finishReason = "finish_reason"
    }
}

// MARK: - Message
struct Message: Codable {
    var role, content: String
}

// MARK: - Usage
struct Usage: Codable {
    let promptTokens, completionTokens, totalTokens: Int

    enum CodingKeys: String, CodingKey {
        case promptTokens = "prompt_tokens"
        case completionTokens = "completion_tokens"
        case totalTokens = "total_tokens"
    }
}
