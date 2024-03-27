//
//  SimulationViewController.swift
//  VKInfect
//
//  Created by Pavel on 27.03.2024
//

import UIKit

protocol SimulationViewProtocol: AnyObject {
}

class SimulationViewController: UIViewController {
    //MARK: - Property
    var presenter: SimulationPresenterProtocol?
    private let groupSize: Int
    private let infectionFactor: Int
    private let period: Int
    private var timer: Timer?
    private var persons: [Person] = [Person]() {
        didSet {
            let healthyPersons = persons.count - sickPersons.count
            statusView.updateViews(healthy: healthyPersons, sick: sickPersons.count)
        }
    }
    private var sickPersons: [Person] = [Person]() {
        didSet {
            let healthyPersons = persons.count - sickPersons.count
            statusView.updateViews(healthy: healthyPersons, sick: sickPersons.count)
        }
    }
    private lazy var statusView: StatusView = {
        let status = StatusView()
        return status
    }()
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(SimulationListCell.self, forCellWithReuseIdentifier: "SimulationListCell")
        collectionView.isUserInteractionEnabled = true
        return collectionView
    }()
    private lazy var alert: UIAlertController = {
        let alert = UIAlertController(title: "Все члены группы заражены!", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        return alert
    }()
    
    //MARK: - Init
    init(groupSize: Int, infectionFactor: Int, period: Int) {
        self.groupSize = groupSize
        self.infectionFactor = infectionFactor
        self.period = period
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
}

//MARK: - Private functions
private extension SimulationViewController {
    func initialize() {
        view.backgroundColor = .vkGray100
        setupLayout()
        (1...groupSize).forEach { _ in
            persons.append(Person())
        }
    }
    
    func setupLayout() {
        view.addSubview(statusView)
        view.addSubview(collectionView)
        
        statusView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            statusView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            statusView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            statusView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            collectionView.topAnchor.constraint(equalTo: statusView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func showAlert() {
        UIView.animate(withDuration: 0.3) {
            self.present(self.alert, animated: true) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.alert.dismiss(animated: true) {
                        self.presenter?.simulationCompleted()
                    }
                }
            }
        }
    }
}

//MARK: - SimulationViewProtocol
extension SimulationViewController: SimulationViewProtocol {
}

//MARK: - UICollectionViewDataSource
extension SimulationViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        groupSize
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SimulationListCell.identifier,
                                                            for: indexPath) as? SimulationListCell else { return UICollectionViewCell() }
        cell.person = persons[indexPath.item]
        cell.person?.delegate = cell
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension SimulationViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at:indexPath) as? SimulationListCell else { return }
        cell.cellDidTapped()
        if let person = cell.person, person.isSick {
            sickPersons.append(person)
        }
        stopTimer()
        startTimer()
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension SimulationViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 17, left: 16, bottom: 50, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let insetsSum = 16.0 + 16.0 + 13.0
        let itemWidth = collectionView.frame.width/2.0 - insetsSum/2.0
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 13
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 13
    }
}

//MARK: - Simulation
private extension SimulationViewController {
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(period),
                                     target: self,
                                     selector: #selector(startSimulation),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc func startSimulation() {
        guard sickPersons.count < groupSize else {
            stopTimer()
            showAlert()
            return
        }
        
        DispatchQueue.global(qos: .background).async {
            self.infectPersons()
        }
    }
    
    func infectPersons() {
        persons.forEach { person in
            guard person.isSick else { return }
            let count = (0...infectionFactor).randomElement() ?? 0
            (0...count).forEach { _ in
                guard let person = persons.randomElement(), !person.isSick else { return }
                person.isSick = Bool.random()
                if person.isSick {
                    sickPersons.append(person)
                }
            }
        }
    }
}
