//
//  SimulationInteractor.swift
//  VKInfect
//
//  Created by Pavel on 27.03.2024
//

protocol SimulationInteractorProtocol: AnyObject {
}

class SimulationInteractor: SimulationInteractorProtocol {
    //MARK: - Property
    weak var presenter: SimulationPresenterProtocol?
}
