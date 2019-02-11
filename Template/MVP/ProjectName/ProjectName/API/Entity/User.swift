//
//  User.swift
//  GitHub
//
//  Created by AuthorName
//  Copyright © 2019 OrganizationName. All rights reserved.
//

import Foundation

public struct User: Codable {
    public let login: String
    public let id: Int
    public let nodeID: String
    public let avatarURL: URL
    public let gravatarID: String
    public let url: URL
    public let receivedEventsURL: URL
    public let type: String

    public init(login: String,
                id: Int,
                nodeID: String,
                avatarURL: URL,
                gravatarID: String,
                url: URL,
                receivedEventsURL: URL,
                type: String) {
        self.login = login
        self.id = id
        self.nodeID = nodeID
        self.avatarURL = avatarURL
        self.gravatarID = gravatarID
        self.url = url
        self.receivedEventsURL = receivedEventsURL
        self.type = type
    }
}
