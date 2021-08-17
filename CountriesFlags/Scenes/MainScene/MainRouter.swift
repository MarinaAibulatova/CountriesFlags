//
//  MainRouter.swift
//  CountriesFlags
//
//  Created by Марина Айбулатова on 13.08.2021.
//

import UIKit

class MainRouter: BaseRouter {
    func showFlags(with selectedFlags: [FlagModel], isMultiple: Bool) {
        let factory = FlagsFactory(selectedFlags)
        let vc = factory.makeViewController()
        vc.delegate = viewController as? MainViewController
        vc.isMultiple = isMultiple
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
