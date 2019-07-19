//
//  FormElement.swift
//  ESSDynamicForm
//
//  Created by AIA-Chris on 05/07/19.
//  Copyright © 2019 chrizers. All rights reserved.
//

import Foundation

// MARK: - FormElement
public class FormElement: Codable {
    let formName, distributionChannelCode: String?
    let elementsForm: [ElementsForm]?
    
    enum CodingKeys: String, CodingKey {
        case formName
        case distributionChannelCode
        case elementsForm
    }
    
    public init(formName: String?, distributionChannelCode: String?, elementsForm: [ElementsForm]?) {
        self.formName = formName
        self.distributionChannelCode = distributionChannelCode
        self.elementsForm = elementsForm
    }
}
