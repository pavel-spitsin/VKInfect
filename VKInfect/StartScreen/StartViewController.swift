//
//  StartScreenViewController.swift
//  VKInfect
//
//  Created by Pavel on 26.03.2024.
//

import UIKit

protocol StartViewControllerProtocol: AnyObject {
}

class StartViewController: UIViewController {
    //MARK: - Property
    var presenter: StartPresenterProtocol?
    private lazy var startView: StartView = {
        let start = StartView()
        start.presenter = presenter
        return start
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupLayout()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    
}

//MARK: - Private functions
private extension StartViewController {
    func setupViews() {
        view.backgroundColor = .vkGray100
    }
    
    func setupLayout() {
        view.addSubview(startView)
        
        startView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            startView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            startView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            startView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
        ])
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(true)
    }
}

//MARK: - StartViewControllerProtocol
extension StartViewController: StartViewControllerProtocol {
}
