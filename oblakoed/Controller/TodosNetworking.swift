//
//  TodosNetworking.swift
//  oblakoed
//
//  Created by Valery Silin on 25/03/2018.
//  Copyright © 2018 Valery Silin. All rights reserved.
//

import UIKit
import CodableAlamofire
import Alamofire


class TodosNetworking {
    
    let url = "https://oblakoed.herokuapp.com/todo/"
//    let url = "http://localhost:3000/todo/"
    let decoder = JSONDecoder()
    
    
    func getTodosData (completion: @escaping ([DataModel.Project], [DataModel.Todo]) -> Void){
        

        Alamofire.request(url+"show").responseDecodableObject(decoder: decoder) { (response:DataResponse<DataModel>) in
            if response.result.isSuccess {
                if let data = response.result.value {
                    completion(data.project, data.todo)
                }
            } else {
            print("SHITERROR")
            }
            
        }
    }
    func addNewTodo(projectId: Int, text: String) {
        Alamofire.request(url+"create", method: .post, parameters: ["todo":["project_id": projectId,
            "text":text]])
    }
    func updateTodoState(todoId: Int) {
        Alamofire.request(url+"update", method: .put, parameters: ["todo_id" : todoId])
    }

}
