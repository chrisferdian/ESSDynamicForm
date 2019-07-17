//
//  ElementsForm.swift
//  ESSDynamicForm
//
//  Created by AIA-Chris on 10/07/19.
//  Copyright © 2019 chrizers. All rights reserved.
//

import Foundation

// MARK: - ElementsForm
class ElementsForm: Codable {
    let fields: [Field]?
    
    init(fields: [Field]?) {
        self.fields = fields
    }
}
