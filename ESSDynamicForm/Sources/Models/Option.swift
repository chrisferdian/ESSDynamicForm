//
//  Option.swift
//  ESSDynamicForm
//
//  Created by AIA-Chris on 22/07/19.
//

import Foundation

public struct Option: Codable {
    let label, value: String?
    public init(label: String?, value: String?) {
        self.label = label
        self.value = value
    }
}
