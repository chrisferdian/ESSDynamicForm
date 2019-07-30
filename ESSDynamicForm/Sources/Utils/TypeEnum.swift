//
//  TypeEnum.swift
//  ESSDynamicForm
//
//  Created by AIA-Chris on 17/07/19.
//  Copyright © 2019 chrizers. All rights reserved.
//

import Foundation

public enum TypeEnum: String, Codable {
    case fieldText = "fieldText"
    case fieldNumber = "fieldNumber"
    case fieldEmail = "fieldEmail"
    case pickerImage = "pickerImage"
    case fieldDate = "fieldDate"
    case textView = "textView"
    case radioGroup = "radio"
}
