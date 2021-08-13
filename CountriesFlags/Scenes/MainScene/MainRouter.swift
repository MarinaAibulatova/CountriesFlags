//
//  MainRouter.swift
//  CountriesFlags
//
//  Created by Марина Айбулатова on 13.08.2021.
//

import UIKit

class MainRouter: BaseRouter {
    func showFlags() {
        let factory = FlagsFactory()
        let vc = factory.makeViewController()
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
