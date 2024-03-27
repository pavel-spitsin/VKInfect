//
//  StartScreenView.swift
//  VKInfect
//
//  Created by Pavel on 26.03.2024.
//

import UIKit

class StartView: UIView {
    //MARK: - Property
    var presenter: StartPresenterProtocol?
    private lazy var groupSizeTextField: ParametricTextField = {
        let textField = ParametricTextField(title: "РАЗМЕР ГРУППЫ",
                                            placeholder: "Введите размер группы",
                                            description: "Количество людей в моделируемой группе")
        return textField
    }()
    private lazy var infectionFactorTextField: ParametricTextField = {
        let textField = ParametricTextField(title: "ФАКТОР ЗАРАЖЕНИЯ",
                                            placeholder: "Введите фактор заражения",
                                            description: "Количество людей, которое может быть заражено одним человеком при контакте")
        return textField
    }()
    private lazy var periodTextField: ParametricTextField = {
        let textField = ParametricTextField(title: "ПЕРИОД",
                                            placeholder: "Введите период",
                                            description: "Период пересчета количества зараженных людей")
        return textField
    }()
    private lazy var runButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .vkBlue
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.setTitle("Запустить моделирование", for: .normal)
        button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchDown)
        button.addTarget(self, action: #selector(runButtonAction(_:)), for: .touchUpInside)
        return button
    }()
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .clear
        stackView.axis = .vertical
        stackView.spacing = 32 //24
        return stackView
    }()
    
    //MARK: - Init
    init() {
        super.init(frame: .zero)
        fillStackView()
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Private functions
private extension StartView {
    func fillStackView() {
        stackView.addArrangedSubview(groupSizeTextField)
        stackView.addArrangedSubview(infectionFactorTextField)
        stackView.addArrangedSubview(periodTextField)
        stackView.addArrangedSubview(runButton)
    }
    
    func setupViews() {
        backgroundColor = .vkWhite
        layer.cornerRadius = 10
    }
    
    func setupLayout() {
        addSubview(stackView)
        
        runButton.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            runButton.heightAnchor.constraint(equalToConstant: 40),
            
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
        ])
    }
    
    @objc func runButtonAction(_ sender: UIButton) {
        sender.alpha = 1.0
        
        if areAllFieldsFilled() {
            guard let groupSize = Int(groupSizeTextField.textField.text!),
                  let factor = Int(infectionFactorTextField.textField.text!),
                  let period = Int(periodTextField.textField.text!) else { return }
            presenter?.runButtonTapped(groupSize: groupSize, factor: factor, period: period)
        }
    }
    
    @objc func buttonPressed(_ sender: UIButton) {
        sender.alpha = 0.5
    }
    
    func areAllFieldsFilled() -> Bool {
        var allFieldsFilled = true
        
        for arrSubview in stackView.arrangedSubviews {
            if let arrSub = arrSubview as? ParametricTextField {
                if let text = arrSub.textField.text, text.isEmpty {
                    allFieldsFilled = false
                    arrSub.errorShakeAnimation()
                    break
                }
            }
        }
        
        return allFieldsFilled
    }
}
