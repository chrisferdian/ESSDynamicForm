//
//  ESSDynamicFormDelegate.swift
//  ESSDynamicForm
//
//  Created by AIA-Chris on 10/07/19.
//  Copyright © 2019 chrizers. All rights reserved.
//

import Foundation

public protocol ESSDynamicFormDelegate: class {
    func formResponse(form: ESSDynamicForm, didFinishFormWithData data: [String: Any])
}
