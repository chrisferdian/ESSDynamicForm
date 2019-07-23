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

    @IBOutlet weak var forms: ESSDynamicForm!
    var staticFields = [ElementsForm]()
    override func viewDidLoad() {
        super.viewDidLoad()
        loadStaticForm()
    }

    func loadStaticForm() {
        //create static form elements
        let fieldName = Field(type: .fieldText, placeholder: "First Name",
                              id: "firstName", option: nil, positionType: nil)
        let lastName = Field(type: .fieldText, placeholder: "Last Name",
                             id: "firstName", option: nil, positionType: nil)
        let elementGroup1 = ElementsForm(fields: [fieldName, lastName])
        staticFields.append(elementGroup1)
        let address = Field(type: .fieldNumber, placeholder: "Address",
                            id: "Address", option: nil, positionType: nil)
        let elementGroup2 = ElementsForm(fields: [address])
        staticFields.append(elementGroup2)
        let radio = Option(label: "Yes", value: "ya")
        let radioNo = Option(label: "No", value: "no")
        let fieldRadios = Field(type: .radioGroup, placeholder: "Jenis Kelamin",
                                id: "jkel", option: [radio, radioNo], positionType: "vertical")

        staticFields.append(ElementsForm(fields: [fieldRadios]))
        let formE = FormElement(formName: "forms", distributionChannelCode: "xxx", elementsForm: staticFields)
        forms.setElements(with: formE)
        forms.setViewController(with: self)
        forms.build()
    }
}
