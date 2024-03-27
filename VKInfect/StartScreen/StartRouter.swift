//
//  StartRouter.swift
//  VKInfect
//
//  Created by Pavel on 27.03.2024
//

import Foundation

protocol StartRouterProtocol {
    func openSimulationScreen(groupSize: Int, factor: Int, period: Int)
}

class StartRouter {
    //MARK: - Property
    weak var viewController: StartViewController?
}

//MARK: - StartRouterProtocol
extension StartRouter: StartRouterProtocol {
    func openSimulationScreen(groupSize: Int, factor: Int, period: Int) {
        DispatchQueue.main.async {
            let vc = SimulationModuleBuilder.build(groupSize: groupSize, factor: factor, period: period)
            self.viewController?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
