//
//  TeamModel.swift
//  SwiftUI Dota Combine Demo
//
//  Created by Apple on 2021/10/5.
//

import Foundation

// MARK: - TeamModelElement

struct TeamModelElement: Codable,Hashable {
    let teamid: Int
    let rating: Double
    let wins, losses, lastMatchTime: Int
    let name, tag: String
    let logourl: String?

    enum CodingKeys: String, CodingKey {
        case teamid = "team_id"
        case rating, wins, losses
        case lastMatchTime = "last_match_time"
        case name, tag
        case logourl = "logo_url"
    }
}

typealias TeamModel = [TeamModelElement]
