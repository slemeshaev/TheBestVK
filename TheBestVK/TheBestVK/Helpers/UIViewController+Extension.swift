//
//  UIViewController+Extension.swift
//  TheBestVK
//
//  Created by Станислав Лемешаев on 14.06.2020.
//  Copyright © 2020 Станислав Лемешаев. All rights reserved.
//

import UIKit

extension UIViewController {
    
    class func loadFromStoryboard<T: UIViewController>() -> T {
        let name = String(describing: T.self)
        let storyboard = UIStoryboard(name: name, bundle: nil)
        if let viewController = storyboard.instantiateInitialViewController() as? T {
            return viewController
        } else {
            fatalError("Error: No initial view controller in \(name) storyboard")
        }
    }
}

