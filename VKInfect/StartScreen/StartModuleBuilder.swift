//
//  StartModuleBuilder.swift
//  VKInfect
//
//  Created by Pavel on 27.03.2024
//

import UIKit

class StartModuleBuilder {
    static func build() -> StartViewController {
        let interactor = StartInteractor()
        let router = StartRouter()
        let presenter = StartPresenter(interactor: interactor, router: router)
        let viewController = StartViewController()
        presenter.view = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
