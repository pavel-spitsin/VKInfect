//
//  StatusView.swift
//  VKInfect
//
//  Created by Pavel on 27.03.2024.
//

import UIKit

protocol StatusViewProtocol {
    func updateViews(healthy: Int, sick: Int)
}

class StatusView: UIView {
    //MARK: - Property
    private lazy var healthyInfoView: InfoView = {
        let image = UIImage(named: "icon_healthy")!
        let infoView = InfoView(image: image)
        return infoView
    }()
    private lazy var sickInfoView: InfoView = {
        let image = UIImage(named: "icon_sick")!
        let infoView = InfoView(image: image)
        return infoView
    }()
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .clear
        stackView.axis = .vertical
        stackView.spacing = 0
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
private extension StatusView {
    func fillStackView() {
        stackView.addArrangedSubview(healthyInfoView)
        stackView.addArrangedSubview(sickInfoView)
    }
    
    func setupViews() {
        backgroundColor = .vkWhite
    }
    
    func setupLayout() {
        addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
}

//MARK: - StatusViewProtocol
extension StatusView: StatusViewProtocol {
    func updateViews(healthy: Int, sick: Int) {
        healthyInfoView.amount = healthy
        sickInfoView.amount = sick
    }
}
