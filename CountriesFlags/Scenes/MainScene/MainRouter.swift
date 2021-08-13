//
//  MainRouter.swift
//  CountriesFlags
//
//  Created by Марина Айбулатова on 13.08.2021.
//

import UIKit

class MainRouter: BaseRouter {
    func showFlags(id: Int) {
        let factory = FlagsFactory(id)
        let vc = factory.makeViewController()
        vc.delegate = viewController as? MainViewController
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
