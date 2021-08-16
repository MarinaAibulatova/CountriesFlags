//
//  FlagsFactory.swift
//  CountriesFlags
//
//  Created by Марина Айбулатова on 13.08.2021.
//

import UIKit

class FlagsFactory: SceneFactory {
    var flagId: Int?
    
    init(_ flagId: Int?) {
        self.flagId = flagId
    }
    func makeViewModel() -> FlagsViewModel {
        return FlagsDetailViewModel(flagId: flagId)
    }
    
    func makeViewController() -> some FlagsViewController {
        return FlagsViewController(viewModel: self.makeViewModel())
    }
}
