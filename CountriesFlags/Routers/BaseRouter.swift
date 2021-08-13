//
//  BaseRouter.swift
//  CountriesFlags
//
//  Created by Марина Айбулатова on 13.08.2021.
//

import UIKit

class BaseRouter {
    weak var viewController: UIViewController?
    
    init(_ viewController: UIViewController) {
        self.viewController = viewController
    }
    
    @objc func back () {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
}
