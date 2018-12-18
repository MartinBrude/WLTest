//
//  UIViewControllerExtension.swift
//  WLTest
//
//  Created by Martin on 21/12/2018.
//  Copyright © 2018 Martin. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {

    func presentAlert(title : String, message : String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: Texts.ok, style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
