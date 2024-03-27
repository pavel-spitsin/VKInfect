//
//  SimulationRouter.swift
//  VKInfect
//
//  Created by Pavel on 27.03.2024
//

import UIKit

protocol SimulationRouterProtocol {
    func openStartScreen()
}

class SimulationRouter {
    //MARK: - Property
    weak var viewController: SimulationViewController?
}

//MARK: - SimulationRouterProtocol
extension SimulationRouter: SimulationRouterProtocol {
    func openStartScreen() {
        DispatchQueue.main.async {
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            let navVC = appDelegate?.window?.rootViewController as? UINavigationController
            navVC?.popToViewController(ofClass: StartViewController.self)
        }
    }
}
