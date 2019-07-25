//
//  ESSDynamicFormTests.swift
//  ESSDynamicFormTests
//
//  Created by AIA-Chris on 11/07/19.
//  Copyright © 2019 chrizers. All rights reserved.
//

import XCTest
@testable import ESSDynamicForm

class ESSDynamicFormTests: XCTestCase {

    var forms: ESSDynamicForm?
    var dummyVC: DummyViewController?
    var staticFields = [ElementsForm]()

    override func setUp() {
        dummyVC = DummyViewController()
        forms = ESSDynamicForm(with: dummyVC!, frame: .init(x: 0, y: 0,
                                                        width: 375, height: 400), margin: 16, delegate: dummyVC!)
        forms?.updateConstraints()
    }

    func testLoadStaticForm() {
        //create static form eelements
        let fieldName = Field(type: .fieldText, placeholder: "First Name", id: "firstName")
        let lastName = Field(type: .fieldText, placeholder: "Last Name", id: "firstName")
        let elementGroup1 = ElementsForm(fields: [fieldName, lastName])
        staticFields.append(elementGroup1)
        let address = Field(type: .fieldNumber, placeholder: "Address", id: "Address")
        let elementGroup2 = ElementsForm(fields: [address])
        staticFields.append(elementGroup2)
        let formE = FormElement(formName: "forms", distributionChannelCode: "xxx", elementsForm: staticFields)
        forms!.setElements(with: formE)
        forms!.setViewController(with: dummyVC!)
        forms!.addImageView(with: nil, identifier: "profilePicture", stackview: nil)
        forms!.build()
    }
    func testgetValue() {
        XCTAssertNotNil(forms?.fieldValues)
    }
    func testOptionModel() {
        let optionYES = Option(label: "Yes", value: "Y")
        XCTAssertEqual(optionYES.label, "Yes")
    }
    func testTextView() {
        let textview = ESSTextView(frame: .zero, textContainer: .init())
        XCTAssertNotNil(textview)
    }
    func testTextField() {
        let textfield = ESSTextField(frame: .zero)
        XCTAssertNotNil(textfield)
    }
    func testHexColor() {
        let blackColor = UIColor.hexStringToUIColor(hex: "#0000000")
        XCTAssertNotNil(blackColor)
        XCTAssertNotNil(UIColor.secondaryPrimaryColor)
        forms?.backgroundColor = UIColor.secondaryPrimaryColor()
    }
    override func tearDown() {
        dummyVC = nil
    }
    func testPerformanceExample() {
        self.measure {}
    }
}
