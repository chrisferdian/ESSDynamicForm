//
//  FormResponse.swift
//  ESSDynamicForm
//
//  Created by AIA-Chris on 10/07/19.
//  Copyright © 2019 chrizers. All rights reserved.
//

import Foundation

public class FormResponse: Codable {
    let key: String?
    let value: String?
    
    init(key:String, value:String) {
        self.key = key
        self.value = value
    }
}
