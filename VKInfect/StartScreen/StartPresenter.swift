//
//  StartPresenter.swift
//  VKInfect
//
//  Created by Pavel on 27.03.2024
//

protocol StartPresenterProtocol: AnyObject {
    func runButtonTapped(groupSize: Int, factor: Int, period: Int)
}

class StartPresenter {
    //MARK: - Property
    weak var view: StartViewControllerProtocol?
    var router: StartRouterProtocol
    var interactor: StartInteractorProtocol

    //MARK: - Init
    init(interactor: StartInteractorProtocol, router: StartRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

//MARK: - StartPresenterProtocol
extension StartPresenter: StartPresenterProtocol {
    func runButtonTapped(groupSize: Int, factor: Int, period: Int) {
        router.openSimulationScreen(groupSize: groupSize, factor: factor, period: period)
    }
}
