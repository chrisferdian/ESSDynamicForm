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
    let queue: Int?
    let groupType: String?
    let fields: [Field]?
    
    init(queue: Int?, groupType: String?, fields: [Field]?) {
        self.queue = queue
        self.groupType = groupType
        self.fields = fields
    }
}
