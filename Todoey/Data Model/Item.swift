//
//  Model.swift
//  Todoey
//
//  Created by Илья Шаповалов on 15.06.2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

class Item: Codable {
    var title: String
    var done: Bool
    
    init(title: String, done: Bool = false) {
        self.title = title
        self.done = done
    }
}
