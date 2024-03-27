//
//  SimulationListCell.swift
//  VKInfect
//
//  Created by Pavel on 27.03.2024.
//

import UIKit

protocol SimulationListCellDelegate: AnyObject{
    func cellDidTapped()
}

class SimulationListCell: UICollectionViewCell {
    //MARK: - Property
    static let identifier = String(describing: SimulationListCell.self)
    var person: Person?
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        person?.delegate = self
        configureComponents()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func prepareForReuse() {
        super.prepareForReuse()
        updateImage()
    }
}

//MARK: - Private functions
private extension SimulationListCell {
    func configureComponents() {
        backgroundColor = .vkWhite
        contentView.backgroundColor = .clear
        updateImage()
    }
    
    func setupLayout() {
        contentView.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func updateImage() {
        DispatchQueue.main.async {
            if let person = self.person, person.isSick  {
                self.imageView.image = UIImage(named: "icon_sick")
            } else {
                self.imageView.image = UIImage(named: "icon_healthy")
            }
        }
    }
}

//MARK: - SimulationListCellDelegate
extension SimulationListCell: SimulationListCellDelegate {
    func cellDidTapped() {
        person?.isSick = true
        updateImage()
    }
}

//MARK: - PersonProltocol
extension SimulationListCell: PersonProltocol {
    func personInfected() {
        updateImage()
    }
}
