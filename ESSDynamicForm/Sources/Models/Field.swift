//
//  Field.swift
//  ESSDynamicForm
//
//  Created by AIA-Chris on 10/07/19.
//  Copyright © 2019 chrizers. All rights reserved.
//

import Foundation

// MARK: - Field
class Field: Codable {
    let placeholder, id: String?
    let type: TypeEnum?
    
    init(type: TypeEnum?, placeholder: String?, id: String?) {
        self.type = type
        self.placeholder = placeholder
        self.id = id
    }
}
