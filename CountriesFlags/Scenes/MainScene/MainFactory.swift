//
//  MainFactory.swift
//  CountriesFlags
//
//  Created by Марина Айбулатова on 13.08.2021.
//

import UIKit

class MainFactory: SceneFactory {
    func makeViewModel() -> MainViewModel {
        return MainDetailViewModel()
    }
    func makeViewController() -> some UIViewController {
        return MainViewController()
    }
    
}
