//
//  GlobalExtensions.swift
//  VKInfect
//
//  Created by Pavel on 26.03.2024.
//

import UIKit

//MARK: - UINavigationController
extension UINavigationController {
    func popToViewController(ofClass: AnyClass, animated: Bool = true) {
      if let vc = viewControllers.last(where: { $0.isKind(of: ofClass) }) {
        popToViewController(vc, animated: animated)
      }
    }
}

//MARK: - UIView
extension UIView {
    func errorShakeAnimation() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.03
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 8,
                                                       y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 8,
                                                     y: self.center.y))
        self.layer.add(animation, forKey: "position")
        UINotificationFeedbackGenerator().notificationOccurred(.error)
    }
}

//MARK: - UITextField
extension UITextField {
    func setLeftPadding(_ amount: CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: frame.size.height))
        leftView = paddingView
        leftViewMode = .always
    }
}

//MARK: - UIImage
extension UIImage {
    func resized(to targetSize: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: targetSize).image { _ in
            self.draw(in: CGRect(origin: .zero, size: targetSize))
        }
    }
}
