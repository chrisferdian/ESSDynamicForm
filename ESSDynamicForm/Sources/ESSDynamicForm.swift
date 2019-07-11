//
//  ViewController.swift
//  ESSDynamicForm
//
//  Created by AIA-Chris on 05/07/19.
//  Copyright © 2019 chrizers. All rights reserved.
//

import UIKit

open class ESSDynamicForm: UIView {

    public lazy var scrollable: ScrollableStackView = {
        let instance = ScrollableStackView(frame: CGRect.zero)
        instance.translatesAutoresizingMaskIntoConstraints = false
        instance.layoutMargins = .zero
        return instance
    }()
    private var elements = [ElementsForm]()
    private var imagePicker: ImagePicker!
    let datePicker = UIDatePicker()
    private var currentImageViewIdentifire:String = ""
    private var vc:UIViewController!
    
    var delegate: ESSDynamicFormDelegate?
    public var margin:CGFloat = 16
    
    //Use this init for programmatically implementation
    init(with mainController:UIViewController, frame:CGRect, margin:CGFloat = 16, delegate:ESSDynamicFormDelegate) {
        self.init()
        self.vc = mainController
        self.frame = frame
        imagePicker = ImagePicker(presentationController: vc, delegate: self)
        setupScrollable()
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        scrollable.frame = frame
        setupScrollable()
    }
    
    public required init?(coder aDecoder: NSCoder) {super.init(coder: aDecoder)}
    
    public func setViewController(with viewController:UIViewController) {
        self.vc = viewController
    }
    
    func setElements(with elements:FormElement) {
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
        
        scrollable.topAnchor.constraint(equalTo: topAnchor, constant: margin).isActive = true
        scrollable.leadingAnchor.constraint(equalTo: leadingAnchor, constant: margin).isActive = true
        scrollable.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -margin).isActive = true
        scrollable.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -margin).isActive = true
        scrollable.frame = frame
        scrollable.stackView.distribution = .fillProportionally
        scrollable.stackView.alignment = .center
        scrollable.scrollView.layoutMargins = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
    }
    func build() {
        self.imagePicker = ImagePicker(presentationController: vc, delegate: self)
        for i in elements {
            let min:UInt32 = 30
            let max:UInt32 = UInt32(bounds.width - 10)
            let random = CGFloat(arc4random_uniform(max - min) + min) // between 30-130
            let rectangle = UIView(frame: CGRect(x: 0, y: 0, width: random, height: random))
            rectangle.backgroundColor = UIColor(red: CGFloat(drand48()), green: CGFloat(drand48()), blue: CGFloat(drand48()), alpha: 1.0)
            if i.fields!.count > 1 {
                let horizontalStack = UIStackView(frame: .zero)
                horizontalStack.axis = .horizontal
                horizontalStack.distribution = .fillEqually
                horizontalStack.spacing = margin
                for element in i.fields! {
                    guard let placeholder = element.placeholder else { return }
                    guard let identifire = element.id else { return }
                    if (element.type?.elementsEqual("fieldText"))! {
                        self.addTextField(with: placeholder, identifire: identifire, inputType: .default, stackview: horizontalStack, fieldInputView: nil)
                    } else if (element.type?.elementsEqual("fieldNumber"))! {
                        self.addTextField(with: placeholder, identifire: identifire, inputType: .numberPad, stackview: horizontalStack, fieldInputView: nil)
                    } else if (element.type?.elementsEqual("pickerImage"))! {
                        self.addImageView(with: UIImage(named: "")!, identifier: identifire, stackview: horizontalStack)
                    } else if (element.type?.elementsEqual("fieldDate"))! {
                        self.addTextField(with: placeholder, identifire: identifire, inputType: .default, stackview: horizontalStack, fieldInputView: datePicker)
                    }
                }
                scrollable.stackView.addArrangedSubview(horizontalStack)
            } else {
                for element in i.fields! {
                    guard let placeholder = element.placeholder else { return }
                    guard let identifire = element.id else { return }
                    if (element.type?.elementsEqual("fieldText"))! {
                        self.addTextField(with: placeholder, identifire: identifire, inputType: .default, stackview: nil, fieldInputView: nil)
                    } else if (element.type?.elementsEqual("fieldNumber"))! {
                        self.addTextField(with: placeholder, identifire: identifire, inputType: .numberPad, stackview: nil, fieldInputView: nil)
                    } else if (element.type?.elementsEqual("pickerImage"))! {
                        self.addImageView(with: UIImage(named: "")!, identifier: identifire, stackview: nil)
                    } else if (element.type?.elementsEqual("fieldDate"))! {
                        self.addTextField(with: placeholder, identifire: identifire, inputType: .default, stackview: nil, fieldInputView: datePicker)
                    }
                }
            }
        }
        DispatchQueue.main.async {
            self.scrollable.stackView.addHorizontalSeparators(color: .gray)
        }
    }
    internal func addImageView(with placeholder:UIImage, identifier:String, stackview:UIStackView?) {
        let imageVContainer = UIImageView(frame: .zero)
        imageVContainer.heightAnchor.constraint(equalToConstant: 275).isActive = true
        imageVContainer.widthAnchor.constraint(equalToConstant: scrollable.frame.width).isActive = true
        imageVContainer.contentMode = .scaleAspectFill
        imageVContainer.image = placeholder
        if stackview != nil {
            stackview?.addArrangedSubview(imageVContainer)
        } else {
            scrollable.stackView.addArrangedSubview(imageVContainer)
        }
        imageVContainer.isUserInteractionEnabled = true
        imageVContainer.accessibilityIdentifier = identifier
        imageVContainer.clipsToBounds = true
        imageVContainer.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(ESSDynamicForm.imagePickerTapped(sender:))))
    }
    internal func addTextField(with placeholder:String, identifire:String, inputType:UIKeyboardType, stackview:UIStackView?, fieldInputView:UIView?) {
        let textfield = UITextField(frame: .zero)
        textfield.accessibilityIdentifier = identifire
        textfield.placeholder = placeholder
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
//                popoverController.delegate = self
            }
            vc.present(popOverContent, animated: true, completion: nil)
//            presentViewController(savingsInformationViewController, animated: true, completion: nil)
            
        }
        if stackview != nil {
            stackview?.addArrangedSubview(textfield)
        } else {
            scrollable.stackView.addArrangedSubview(textfield)
        }
    }
    @objc func imagePickerTapped(sender: UITapGestureRecognizer) {
        currentImageViewIdentifire = sender.view!.accessibilityIdentifier!
        for i in scrollable.stackView.arrangedSubviews {
            if let iv = i as? UIImageView {
                if (iv.accessibilityIdentifier?.elementsEqual(currentImageViewIdentifire))! {
                    self.imagePicker.present(from: iv)
                }
            }
        }
    }
    public func getFormData() {
        var response = [FormResponse]()
        for i in scrollable.stackView.arrangedSubviews {
            if let field = i as? UITextField {
                let res = FormResponse(key: field.accessibilityIdentifier ?? "", value: field.text ?? "")
                response.append(res)
            }
            if let stack = i as? UIStackView {
                for x in stack.arrangedSubviews {
                    if let tf = x as? UITextField {
                        let res = FormResponse(key: tf.accessibilityIdentifier ?? "", value: tf.text ?? "")
                        response.append(res)
                    }
                }
            }
        }
        DispatchQueue.main.async {
            self.delegate?.formResponse(form: self, didFinishFormWithData: response)
        }
    }
    
    @IBAction func jumpToViewAction(_ sender: Any) {
        scrollable.scrollToItem(index: 11)
    }
}
extension ESSDynamicForm: ImagePickerDelegate {
    
    public func didSelect(image: UIImage?) {
        for i in scrollable.stackView.arrangedSubviews {
            if let iv = i as? UIImageView {
                if (iv.accessibilityIdentifier?.elementsEqual(currentImageViewIdentifire))! {
                    iv.image = image
                }
            }
        }
    }
}
