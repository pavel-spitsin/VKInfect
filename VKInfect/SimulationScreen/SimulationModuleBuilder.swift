//
//  SimulationModuleBuilder.swift
//  VKInfect
//
//  Created by Pavel on 27.03.2024
//

import UIKit

class SimulationModuleBuilder {
    static func build(groupSize: Int, factor: Int, period: Int) -> SimulationViewController {
        let interactor = SimulationInteractor()
        let router = SimulationRouter()
        let presenter = SimulationPresenter(interactor: interactor, router: router)
        let viewController = SimulationViewController(groupSize: groupSize,
                                                      infectionFactor: factor,
                                                      period: period)
        presenter.view  = viewController
        viewController.presenter = presenter
        interactor.presenter = presenter
        router.viewController = viewController
        return viewController
    }
}
