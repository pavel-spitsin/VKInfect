//
//  Person.swift
//  VKInfect
//
//  Created by Pavel on 27.03.2024.
//

protocol PersonProltocol: AnyObject {
    func personInfected()
}

class Person {
    //MARK: - Property
    var isSick: Bool = false {
        didSet {
            delegate?.personInfected()
        }
    }
    weak var delegate: PersonProltocol?
}
