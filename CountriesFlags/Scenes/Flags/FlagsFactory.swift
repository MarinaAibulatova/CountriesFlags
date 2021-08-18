//
//  FlagsFactory.swift
//  CountriesFlags
//
//  Created by Марина Айбулатова on 13.08.2021.
//

import UIKit

class FlagsFactory: SceneFactory {
    var selectedFlags: [FlagModel]
    var isMultiple: Bool
    
    init(_ selectedFlags: [FlagModel], _ isMultiple: Bool) {
        self.selectedFlags = selectedFlags
        self.isMultiple = isMultiple
    }
    func makeViewModel() -> FlagsViewModel {
        return FlagsDetailViewModel(currentFlags: selectedFlags, isMultiple)
    }
    
    func makeViewController() -> some FlagsViewController {
        return FlagsViewController(viewModel: self.makeViewModel())
    }
}
