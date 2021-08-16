//
//  MainRouter.swift
//  CountriesFlags
//
//  Created by Марина Айбулатова on 13.08.2021.
//

import UIKit

class MainRouter: BaseRouter {
    func showFlags(with selectedFlag: FlagModel?) {
        let factory = FlagsFactory(selectedFlag)
        let vc = factory.makeViewController()
        vc.delegate = viewController as? MainViewController
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
