//
//  GetTodos.swift
//  oblakoed
//
//  Created by Valery Silin on 25/03/2018.
//  Copyright © 2018 Valery Silin. All rights reserved.
//

import UIKit
import CodableAlamofire
import Alamofire


class GetTodos {
    
    let url = "https://oblakoed.herokuapp.com/todo/show.json"
    let decoder = JSONDecoder()
    
    
    func getTodosData (completion: @escaping ([DataModel.Project], [DataModel.Todo]) -> Void){
        

        Alamofire.request(url).responseDecodableObject(decoder: decoder) { (response:DataResponse<DataModel>) in
            if response.result.isSuccess {
                if let data = response.result.value {
                    completion(data.project, data.todo)
                }
            } else {
            print("SHITERROR")
            }
            
        }
    }

}
//                    let jsonData = response.result.value
//                    let decoder = JSONDecoder()
//                    let data = try! decoder.decode(DataModel.self, from: jsonData as! Data)
//                    dump(data)
