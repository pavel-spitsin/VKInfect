//
//  StartInteractor.swift
//  VKInfect
//
//  Created by Pavel on 27.03.2024
//

protocol StartInteractorProtocol: AnyObject {
}

class StartInteractor: StartInteractorProtocol {
    //MARK: - Property
    weak var presenter: StartPresenterProtocol?
}
