//
//  FlagsFactory.swift
//  CountriesFlags
//
//  Created by Марина Айбулатова on 13.08.2021.
//

import UIKit

class FlagsFactory: SceneFactory {
    
    func makeViewModel() -> FlagsViewModel {
        return FlagsDetailViewModel()
    }
    
    func makeViewController() -> some FlagsViewController {
        return FlagsViewController(viewModel: self.makeViewModel())
    }
}
