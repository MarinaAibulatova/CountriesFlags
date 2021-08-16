//
//  FlagsFactory.swift
//  CountriesFlags
//
//  Created by Марина Айбулатова on 13.08.2021.
//

import UIKit

class FlagsFactory: SceneFactory {
    var selectedFlag: FlagModel?
    
    init(_ selectedFlag: FlagModel?) {
        self.selectedFlag = selectedFlag
    }
    func makeViewModel() -> FlagsViewModel {
        return FlagsDetailViewModel(currentFlag: selectedFlag)
    }
    
    func makeViewController() -> some FlagsViewController {
        return FlagsViewController(viewModel: self.makeViewModel())
    }
}
