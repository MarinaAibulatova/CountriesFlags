//
//  FlagsFactory.swift
//  CountriesFlags
//
//  Created by Марина Айбулатова on 13.08.2021.
//

import UIKit

class FlagsFactory: SceneFactory {
    var selectedFlags: [FlagModel]
    
    init(_ selectedFlags: [FlagModel]) {
        self.selectedFlags = selectedFlags
    }
    func makeViewModel() -> FlagsViewModel {
        return FlagsDetailViewModel(currentFlags: selectedFlags)
    }
    
    func makeViewController() -> some FlagsViewController {
        return FlagsViewController(viewModel: self.makeViewModel())
    }
}
