//
//  ESSTextField.swift
//  ESSDynamicForm
//
//  Created by AIA-Chris on 16/07/19.
//  Copyright © 2019 chrizers. All rights reserved.
//

import UIKit

@IBDesignable
class ESSTextField: UITextField {
    /**
     * Bottom line at the bottom of textField
     */
    var borderColor = UIColor.hexStringToUIColor(hex: "E0E0E0")
    /**
     * Width of bottom line
     */
    var borderWidth: Double = 1.0
    let labelError = UILabel()
    let label = UILabel(frame: .zero)
    var placeholderText: String = ""
    let padding = UIEdgeInsets(top: 0, left: 0, bottom: 5, right: 0)
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    /**
     * Call designated initializer
     */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        delegate = self
        setupUI()
        self.font = UIFont.systemFont(ofSize: 16)
        self.textColor = UIColor.hexStringToUIColor(hex: "212121")
    }
    /**
     * Initialize for programmatically
     */
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        self.font = UIFont.systemFont(ofSize: 16)
        self.textColor = UIColor.hexStringToUIColor(hex: "212121")
    }
    override func willMove(toSuperview newSuperview: UIView?) {
        if newSuperview != nil {
            NotificationCenter.default.addObserver(
                self, selector: #selector(textFieldDidEndEditing),
                name: UITextField.textDidEndEditingNotification, object: self
            )
            NotificationCenter.default.addObserver(
                self, selector: #selector(textFieldDidBeginEditing),
                name: UITextField.textDidBeginEditingNotification, object: self
            )
        }
    }
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    /**
     * This function called when user start editing textField
     */
    @objc func textFieldDidBeginEditing() {
        if placeholderText.elementsEqual("") {
            createLabelFloating()
        }
        borderColor = UIColor.hexStringToUIColor(hex: "333366")
        setupUI()
        removeError()
    }
    /**
     * This function called when user finish editing textField
     */
    @objc func textFieldDidEndEditing() {
        borderColor = UIColor.hexStringToUIColor(hex: "E0E0E0")
        borderColor = .gray
        setupUI()
        if text!.isEmpty {
            removeLabel()
        }
    }
    func removeLabel() {
        UIView.animate(withDuration: 0.3) {
            self.label.removeFromSuperview()
            self.placeholder = self.placeholderText
            self.placeholderText = ""
        }
    }
    /** this function responsible to draw line to the view without change a class of the view.
     * - author: Chris Ferdian <chrisferdian@onoff.insure>
     */
    func setupUI() {
        contentVerticalAlignment = .bottom
        self.borderStyle = .none
        let lineView = UIView()
        lineView.backgroundColor = borderColor
        lineView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(lineView)
        let metrics = ["width": NSNumber(value: borderWidth)]
        let views = ["lineView": lineView]
        self.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "H:|[lineView]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                metrics: metrics, views: views
            )
        )
        self.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "V:[lineView(width)]|", options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                metrics: metrics, views: views
            )
        )
    }
    /**
     * Create label on top of textField
     * - author: Chris Ferdian <chrisferdian@onoff.insure>
     */
    private func createLabelFloating() {
        placeholderText = self.placeholder ?? ""
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = placeholderText
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.hexStringToUIColor(hex: "#9E9E9E")
        UIView.animate(withDuration: 0.3) {
            self.addSubview(self.label)
            self.label.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
            self.label.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            self.label.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
            self.label.heightAnchor.constraint(equalToConstant: 10).isActive = true
        }
        self.placeholder = ""
    }
    /**
     * Create label at the bottom
     */
    public func createBottomNote(message: String) {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = message
        label.textColor = UIColor.hexStringToUIColor(hex: "#9E9E9E")
        self.addSubview(label)
        label.topAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    }
    /**
     * Create error message at the bottom
     */
    public func setErrorNote(message: String) {
        labelError.font = UIFont.systemFont(ofSize: 12)
        labelError.translatesAutoresizingMaskIntoConstraints = false
        labelError.text = message
        labelError.textColor = .red
        self.addSubview(labelError)
        labelError.topAnchor.constraint(equalTo: self.bottomAnchor, constant: 2).isActive = true
        labelError.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        UIView.animate(withDuration: 0.2, animations: {
            self.setupUI()
        })
    }
    public func removeError() {
        self.setErrorNote(message: "")
    }
}
