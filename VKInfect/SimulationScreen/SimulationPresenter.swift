//
//  SimulationPresenter.swift
//  VKInfect
//
//  Created by Pavel on 27.03.2024
//

protocol SimulationPresenterProtocol: AnyObject {
    func simulationCompleted()
}

class SimulationPresenter {
    //MARK: - Property
    weak var view: SimulationViewProtocol?
    var router: SimulationRouterProtocol
    var interactor: SimulationInteractorProtocol

    //MARK: - Init
    init(interactor: SimulationInteractorProtocol, router: SimulationRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

//MARK: - SimulationPresenterProtocol
extension SimulationPresenter: SimulationPresenterProtocol {
    func simulationCompleted() {
        router.openStartScreen()
    }
}
