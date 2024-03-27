//
//  ParametricTextField.swift
//  VKInfect
//
//  Created by Pavel on 26.03.2024.
//

import UIKit

class ParametricTextField: UIView {
    //MARK: - Property
    private let isNumeric: Bool
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .vkGray400
        return label
    }()
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .vkGray100
        textField.layer.cornerRadius = 8
        textField.layer.masksToBounds = true
        textField.setLeftPadding(textField.layer.cornerRadius)
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.textColor = .vkGray400
        textField.tintColor = .vkGray400
        return textField
    }()
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.numberOfLines = .zero
        label.textColor = .vkGray400
        return label
    }()
    
    //MARK: - Init
    init(title: String?, placeholder: String?, description: String?, isNumeric: Bool = true) {
        self.isNumeric = isNumeric
        super.init(frame: .zero)
        titleLabel.text = title
        textField.placeholder = placeholder
        descriptionLabel.text = description
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Private functions
private extension ParametricTextField {
    func setupViews() {
        backgroundColor = .vkWhite
        if isNumeric {
            textField.keyboardType = .asciiCapableNumberPad
            addDoneButtonToKeyboard()
        } else {
            textField.keyboardType = .default
        }
    }
    
    func addDoneButtonToKeyboard() {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                            target: nil,
                                            action: nil)
        let doneBarButton =  UIBarButtonItem(title: "Готово",
                                             style: .plain,
                                             target: self,
                                             action: #selector(buttonPressed(_:)))
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        textField.inputAccessoryView = keyboardToolbar
    }
    
    func setupLayout() {
        addSubview(titleLabel)
        addSubview(textField)
        addSubview(descriptionLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 18),
            
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.heightAnchor.constraint(equalToConstant: 40),
            
            descriptionLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 4),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    @objc func buttonPressed(_ sender: UIButton) {
        textField.resignFirstResponder()
    }
}
