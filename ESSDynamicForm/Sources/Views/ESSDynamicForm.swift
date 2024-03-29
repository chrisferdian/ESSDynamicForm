//
//  ViewController.swift
//  ESSDynamicForm
//
//  Created by AIA-Chris on 05/07/19.
//  Copyright © 2019 chrizers. All rights reserved.
//

import UIKit

public class ESSDynamicForm: UIView {

    public lazy var scrollable: ScrollableStackView = {
        let instance = ScrollableStackView(frame: CGRect.zero)
        instance.translatesAutoresizingMaskIntoConstraints = false
        instance.layoutMargins = .zero

        return instance
    }()
    private var elements = [ElementsForm]()
    private var imagePicker: ImagePicker!
    let datePicker = UIDatePicker()
    private var currentImageViewIdentifire: String = ""
    private var hostVC: UIViewController!
    weak var delegate: ESSDynamicFormDelegate?
    public var margin: CGFloat = 16
    public var fieldValues = [String: Any]()
    //Use this init for programmatically implementation
    init(with mainController: UIViewController, frame: CGRect, margin: CGFloat = 16, delegate: ESSDynamicFormDelegate) {
        self.init()
        self.hostVC = mainController
        self.frame = frame
        imagePicker = ImagePicker(presentationController: hostVC, delegate: self)
        setupScrollable()
    }
    public override init(frame: CGRect) {
        super.init(frame: frame)
        scrollable.frame = frame
        setupScrollable()
    }
    public required init?(coder aDecoder: NSCoder) {super.init(coder: aDecoder)}
    public func setViewController(with viewController: UIViewController) {
        self.hostVC = viewController
    }
    public func setElements(with elements: FormElement) {
        self.elements = elements.elementsForm!
    }
    open override func awakeFromNib() {
        super.awakeFromNib()
        setupScrollable()
    }
    
    private func setupScrollable() {
        scrollable.frame = frame
        addSubview(scrollable)
        scrollable.translatesAutoresizingMaskIntoConstraints = false
        datePicker.datePickerMode = .date
        //Setup scrollable constraint
        scrollable.topAnchor.constraint(equalTo: topAnchor, constant: margin).isActive = true
        scrollable.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin).isActive = true
        scrollable.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -margin).isActive = true
        scrollable.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin).isActive = true
        scrollable.frame = frame
        scrollable.backgroundColor = .clear
        scrollable.stackView.backgroundColor = .clear
        scrollable.stackView.distribution = .fillProportionally
        scrollable.stackView.alignment = .center
        scrollable.scrollView.layoutMargins = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
    }
    public func build() {
        self.imagePicker = ImagePicker(presentationController: hostVC, delegate: self)
        for tmpElement in elements {
            if tmpElement.fields!.count > 1 {
                addMultipleElement(fields: tmpElement.fields!)
            } else {
                addSingleElement(fields: tmpElement.fields!)
            }
        }
        DispatchQueue.main.async {
            self.scrollable.stackView.addHorizontalSeparators(color: .gray)
        }
    }
    private func addMultipleElement(fields: [Field]) {
        let horizontalStack = UIStackView(frame: .zero)
        horizontalStack.axis = .horizontal
        horizontalStack.distribution = .fillEqually
        horizontalStack.spacing = margin
        for element in fields {
            guard let placeholder = element.placeholder else { return }
            guard let identifire = element.id else { return }
            if element.type == TypeEnum.fieldText {
                print(identifire)
                self.addTextField(with: placeholder, identifire: identifire,
                                  inputType: .default, stackview: horizontalStack, fieldInputView: nil)
            } else if element.type == TypeEnum.fieldNumber {
                self.addTextField(with: placeholder, identifire: identifire,
                                  inputType: .numberPad, stackview: horizontalStack, fieldInputView: nil)
            } else if element.type == TypeEnum.pickerImage {
                self.addImageView(with: UIImage(named: "placeholder")!, identifier: identifire,
                                  stackview: horizontalStack)
            } else if element.type == TypeEnum.fieldDate {
                self.addTextField(with: placeholder, identifire: identifire,
                                  inputType: .default, stackview: horizontalStack, fieldInputView: datePicker)
            } else if element.type == TypeEnum.fieldEmail {
                self.addTextField(with: placeholder, identifire: identifire,
                                  inputType: .emailAddress, stackview: horizontalStack)
            }
        }
        scrollable.stackView.addArrangedSubview(horizontalStack)
    }
    private func addSingleElement(fields: [Field]) {
        for element in fields {
            guard let placeholder = element.placeholder else { return }
            guard let identifire = element.id else { return }
            if element.type == TypeEnum.fieldText {
                self.addTextField(with: placeholder, identifire: identifire,
                                  inputType: .default)
            } else if element.type == TypeEnum.fieldNumber {
                self.addTextField(with: placeholder, identifire: identifire,
                                  inputType: .numberPad)
            } else if element.type == TypeEnum.pickerImage {
                self.addImageView(with: UIImage(named: "placeholder"), identifier: identifire,
                                  stackview: nil)
            } else if element.type == TypeEnum.fieldText {
                self.addTextField(with: placeholder, identifire: identifire,
                                  inputType: .default, fieldInputView: datePicker)
            } else if element.type == TypeEnum.radioGroup {
                self.addRadioGroup(with: placeholder, identifire: identifire,
                                   stackView: nil, options: element.option ?? [Option]())
            } else if element.type == TypeEnum.fieldEmail {
                self.addTextField(with: placeholder, identifire: identifire,
                                  inputType: .emailAddress, stackview: nil)
            }
        }
    }
    internal func addImageView(with placeholder: UIImage?, identifier: String, stackview: UIStackView?) {
        let imageVContainer = UIImageView(frame: .zero)
        imageVContainer.heightAnchor.constraint(equalToConstant: 275).isActive = true
        imageVContainer.widthAnchor.constraint(equalToConstant: scrollable.frame.width).isActive = true
        imageVContainer.contentMode = .scaleAspectFill
        if placeholder != nil {
            imageVContainer.image = placeholder
        }
        if stackview != nil {
            stackview?.addArrangedSubview(imageVContainer)
        } else {
            scrollable.stackView.addArrangedSubview(imageVContainer)
        }
        imageVContainer.isUserInteractionEnabled = true
        imageVContainer.accessibilityIdentifier = identifier
        imageVContainer.clipsToBounds = true
        imageVContainer.addGestureRecognizer(
            UITapGestureRecognizer.init(target: self,
                                        action: #selector(ESSDynamicForm.imagePickerTapped(sender:)))
        )
    }
    internal func addTextField(with placeholder: String, identifire: String,
                               inputType: UIKeyboardType, stackview: UIStackView? = nil, fieldInputView: UIView? = nil) {
        let textfield = UITextField(frame: .zero)
        textfield.accessibilityIdentifier = identifire
        textfield.placeholder = placeholder
        textfield.maxLength = 5
        textfield.heightAnchor.constraint(equalToConstant: 55).isActive = true
        textfield.keyboardType = inputType
        textfield.widthAnchor.constraint(equalToConstant: scrollable.frame.width).isActive = true
        if fieldInputView != nil {
            textfield.inputView = nil
            let popVIew = UIView(frame: .zero)
            let popOverContent = UIViewController()
            popVIew.addSubview(datePicker)
            popOverContent.view = popVIew
            popOverContent.modalPresentationStyle = .popover
            if let popoverController = popOverContent.popoverPresentationController {
                popoverController.sourceView = textfield
                popoverController.sourceRect = textfield.bounds
                popoverController.permittedArrowDirections = .any
            }
            hostVC.present(popOverContent, animated: true, completion: nil)
        }
        textfield.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        if stackview != nil {
            stackview?.addArrangedSubview(textfield)
        } else {
            scrollable.stackView.addArrangedSubview(textfield)
        }
    }
    internal func addRadioGroup(with placeholder: String, identifire: String,
                                stackView: UIStackView?, options: [Option]) {
        let segmented = UISegmentedControl(frame: .zero)
        segmented.accessibilityIdentifier = identifire
        segmented.translatesAutoresizingMaskIntoConstraints = false
        segmented.heightAnchor.constraint(equalToConstant: 44).isActive = true
        segmented.addTarget(self, action: #selector(segmentedDidChange(_:)), for: .valueChanged)
        DispatchQueue.main.async {
            self.scrollable.stackView.addArrangedSubview(segmented)
            segmented.widthAnchor.constraint(equalTo: self.scrollable.stackView.widthAnchor).isActive = true
            for numberOption in 0...options.count - 1 {
                segmented.insertSegment(withTitle: options[numberOption].label!, at: numberOption, animated: true)
            }
            segmented.layer.borderColor = UIColor.blue.cgColor
            segmented.layer.borderWidth = 0.75
            segmented.layer.cornerRadius = segmented.bounds.height / 2
            segmented.layer.masksToBounds = true
        }
    }
    @objc func imagePickerTapped(sender: UITapGestureRecognizer) {
        currentImageViewIdentifire = sender.view!.accessibilityIdentifier!
        for viewFromStack in scrollable.stackView.arrangedSubviews {
            if let imageV = viewFromStack as? UIImageView {
                if (imageV.accessibilityIdentifier?.elementsEqual(currentImageViewIdentifire))! {
                    self.imagePicker.present(from: imageV)
                }
            }
        }
    }
    public func getFormData() {
        print(fieldValues)
        DispatchQueue.main.async {
            self.delegate?.formResponse(form: self, didFinishFormWithData: self.fieldValues)
        }
    }
    private func validate(YourEMailAddress: String) -> Bool {
        let REGEX: String
        REGEX = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", REGEX).evaluate(with: YourEMailAddress)
    }
    @IBAction func jumpToViewAction(_ sender: Any) {
        scrollable.scrollToItem(index: 11)
    }
    //
    @objc func segmentedDidChange(_ segmented: UISegmentedControl) {
        let selectedIndex = segmented.selectedSegmentIndex
        fieldValues.updateValue(
            segmented.titleForSegment(at: selectedIndex) ?? "",
            forKey: segmented.accessibilityIdentifier ?? ""
        )
    }
    //
    @objc func textFieldDidChange(_ textField: UITextField) {
        fieldValues.updateValue(textField.text ?? "", forKey: textField.accessibilityIdentifier ?? "")
    }
}
extension ESSDynamicForm: ImagePickerDelegate {
    public func didSelect(image: UIImage?, url: URL?) {
        for viewFromStack in scrollable.stackView.arrangedSubviews {
            if let imageV = viewFromStack as? UIImageView {
                if (imageV.accessibilityIdentifier?.elementsEqual(currentImageViewIdentifire))! {
                    imageV.image = image
                    self.fieldValues.updateValue(url!, forKey: imageV.accessibilityIdentifier ?? "")
                }
            }
        }
    }
}
