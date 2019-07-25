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
    let placeholder, id: String?, positionType: String?
    let type: TypeEnum?
    let option: [Option]?

    enum CodingKeys: String, CodingKey {
        case placeholder
        case id
        case type
        case option
        case positionType
    }
    public init(
        type: TypeEnum?, placeholder: String?, id: String?, option: [Option]? = nil, positionType: String? = nil
    ) {
        self.type = type
        self.placeholder = placeholder
        self.id = id
        self.option = option
        self.positionType = positionType

    }
}
