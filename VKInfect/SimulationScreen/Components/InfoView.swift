//
//  InfoView.swift
//  VKInfect
//
//  Created by Pavel on 27.03.2024.
//

import UIKit

class InfoView: UIView {
    //MARK: - Property
    var image: UIImage?
    var amount: Int = 0 {
        didSet {
            updateLabel()
        }
    }
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .vkGray100
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.contentMode = .center
        return imageView
    }()
    private lazy var label: PaddingLabel = {
        let label = PaddingLabel()
        label.layer.cornerRadius = 8
        label.layer.masksToBounds = true
        label.text = "\(amount)"
        label.backgroundColor = .vkGray100
        label.textColor = .vkGray400
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .left
        return label
    }()
    
    //MARK: - Init
    init(image: UIImage) {
        self.image = image
        super.init(frame: .zero)
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Private functions
private extension InfoView {
    func setupViews() {
        backgroundColor = .vkWhite
        if let smallImage = image {
            let resizedImage = smallImage.resized(to: CGSize(width: 32, height: 32))
            imageView.image = resizedImage
            contentMode = .center
        }
    }
    
    func setupLayout() {
        addSubview(imageView)
        addSubview(label)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            imageView.trailingAnchor.constraint(equalTo: label.leadingAnchor, constant: -8),
            imageView.heightAnchor.constraint(equalToConstant: 40),
            imageView.widthAnchor.constraint(equalToConstant: 40),
            
            label.topAnchor.constraint(equalTo: imageView.topAnchor),
            label.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            label.heightAnchor.constraint(equalTo: imageView.heightAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
        ])
    }
    
    func updateLabel() {
        DispatchQueue.main.async {
            self.label.text = "\(self.amount)"
        }
    }
}
