//
//  DummyViewController.swift
//  ESSDynamicFormTests
//
//  Created by AIA-Chris on 22/07/19.
//  Copyright © 2019 chrizers. All rights reserved.
//

import UIKit
import ESSDynamicForm

class DummyViewController: UIViewController, ESSDynamicFormDelegate {
    func formResponse(form: ESSDynamicForm, didFinishFormWithData data: [FormResponse]) {}
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
