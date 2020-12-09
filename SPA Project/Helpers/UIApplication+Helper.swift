//
//  UIApplication+Helper.swift
//  SPA Project
//
//  Created by Emanuil Gospodinov on 9.12.20.
//

import UIKit

extension UIApplication {
    func changeRootViewController(to viewController: UIViewController, animation: UIView.AnimationOptions) {
        
        guard let window = windows.first else { return }
        
        window.rootViewController = viewController
        
        let options: UIView.AnimationOptions = animation
        let duration: TimeInterval = 0.3
        
        UIView.transition(with: window, duration: duration, options: options, animations: nil, completion: nil)
    }
}
