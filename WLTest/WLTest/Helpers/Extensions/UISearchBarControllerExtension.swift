//
//  UISearchBarControllerExtension.swift
//  WLTest
//
//  Created by Martin on 23/12/2018.
//  Copyright © 2018 Martin. All rights reserved.
//

import Foundation
import UIKit

extension UISearchController {

    static func withResetButton(searchBarDelegate : UISearchBarDelegate) -> UISearchController {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = searchBarDelegate
        searchController.searchBar.setValue(Texts.reset, forKey:"_cancelButtonText")
        return searchController
    }
}
