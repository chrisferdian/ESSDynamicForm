//
//  ViewController.swift
//  Example
//
//  Created by AIA-Chris on 22/07/19.
//  Copyright © 2019 chrizers. All rights reserved.
//

import UIKit
import ESSDynamicForm

class ViewController: UIViewController {

    @IBOutlet weak var forms:ESSDynamicForm!
    var staticFields = [ElementsForm]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadStaticForm()
    }

    func loadStaticForm() {
        //create static form eelements
        let fieldName = Field(type: .fieldText, placeholder: "First Name", id: "firstName")
        let lastName = Field(type: .fieldText, placeholder: "Last Name", id: "firstName")
        let elementGroup1 = ElementsForm(fields: [fieldName, lastName])
        staticFields.append(elementGroup1)
        let address = Field(type: .fieldNumber, placeholder: "Address", id: "Address")
        let elementGroup2 = ElementsForm(fields: [address])
        staticFields.append(elementGroup2)
        
        let fe = FormElement(formName: "forms", distributionChannelCode: "xxx", elementsForm: staticFields)
        forms.setElements(with: fe)
        forms.setViewController(with: self)
        forms.build()
    }

}

