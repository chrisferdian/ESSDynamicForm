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
    let ordered: Int?
    let label, type, placeholder, id: String?
    
    init(ordered: Int?, label: String?, type: String?, placeholder: String?, id: String?) {
        self.ordered = ordered
        self.label = label
        self.type = type
        self.placeholder = placeholder
        self.id = id
    }
}
