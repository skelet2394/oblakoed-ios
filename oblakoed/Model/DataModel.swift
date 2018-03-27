//
//  DataModel.swift
//  oblakoed
//
//  Created by Valery Silin on 26/03/2018.
//  Copyright © 2018 Valery Silin. All rights reserved.
//

struct DataModel: Codable {
    
    let project: [Project]
    let todo: [Todo]
    
    struct Project: Codable {
        let id: Int
        let title: String
        enum CodingKeys: String, CodingKey {
            case id
            case title
        }
    }
    
    struct Todo: Codable {
        let todoId: Int
        let text: String
        let projectId: Int?
        let isCompleted: Bool
        
        enum CodingKeys: String, CodingKey {
            case todoId = "id"
            case text
            case projectId = "project_id"
            case isCompleted
        }
        
        
    }
}
