//
//  ImageGen.swift
//  ChatGPT_Text
//
//  Created by Dhruvil Moradiya on 11/03/23.
//

import Foundation

struct DALLEResponse: Decodable {
    let created: Int
    let data: [Photo]
}

struct Photo: Decodable {
    let url: String
}
