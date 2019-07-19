//
//  Field.swift
//  ESSDynamicForm
//
//  Created by AIA-Chris on 10/07/19.
//  Copyright © 2019 chrizers. All rights reserved.
//

import Foundation

// MARK: - Field
public struct Field: Codable {
    let placeholder, id: String?
    let type: TypeEnum?
    
    enum CodingKeys: String, CodingKey {
        case placeholder
        case id
        case type
    }
    
    public init(type: TypeEnum?, placeholder: String?, id: String?) {
        self.type = type
        self.placeholder = placeholder
        self.id = id
    }
}
