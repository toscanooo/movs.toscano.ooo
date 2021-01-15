//
//  Movie.swift
//  sky-poc
//
//  Created by toscano on 12/10/20.
//

import Foundation

struct Movie: Codable {
    let id: Int?
    let title: String?
    let overview: String?
    let description: String?
    let poster_path: String?
}
