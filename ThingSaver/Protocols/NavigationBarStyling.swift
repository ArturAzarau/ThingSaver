//
// Created by Артур Азаров on 21.01.2018.
// Copyright (c) 2018 Paul Hudson. All rights reserved.
//

import UIKit

protocol NavigationBarStyling {
    func setCustomTitle(of string: String)
}

extension NavigationBarStyling where Self: UIViewController {
    func setCustomTitle(of string: String) {
        navigationController?.navigationBar.isTranslucent = false
        title = string
        if let font = UIFont(name: "AvenirNext-Heavy", size: 30) {
            let attrs = [NSAttributedStringKey.font: font]
            navigationController?.navigationBar.titleTextAttributes = attrs
        }
    }
}