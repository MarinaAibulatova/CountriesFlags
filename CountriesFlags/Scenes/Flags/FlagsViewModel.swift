//
//  FlagsViewModel.swift
//  CountriesFlags
//
//  Created by Марина Айбулатова on 12.08.2021.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

protocol FlagsViewModel: AnyObject {
    var flags: [FlagModel] {get set}
    func saveFlag()
    
    var choosedFlag: BehaviorRelay<Optional<Int>> {get set}
}

class FlagsDetailViewModel: FlagsViewModel {
    var choosedFlag: BehaviorRelay<Optional<Int>> = .init(value: nil)
    
    var flags: [FlagModel]
    
    func saveFlag() {
        
    }
    
    init(flagId: Int?) {
        var flags: [FlagModel] = []
        var id = 0
        for item in Assets.Flag.allFlags {
            
            let description = item.description
            let startIndex = description.index(description.startIndex, offsetBy: 36)
            let end = description.index(description.endIndex, offsetBy: -13)
            let range = startIndex..<end
            
            let url = URL.urlForImage(name: String(description[range]))
            
            let flag = FlagModel(id: id, url: url)
            id += 1
            
            flags.append(flag)
        }
        self.flags = flags
        self.choosedFlag.accept(flagId)
    }
}

