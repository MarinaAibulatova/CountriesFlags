//
//  FlagsViewModel.swift
//  CountriesFlags
//
//  Created by Марина Айбулатова on 12.08.2021.
//

import Foundation
import RxSwift
import RxCocoa

protocol FlagsViewModel: AnyObject {
    var flags: [FlagModel] {get set}
    func saveFlag()
    
    var choosedFlag: BehaviorRelay<Int> {get set}
}

class FlagsDetailViewModel: FlagsViewModel {
    var choosedFlag: BehaviorRelay<Int> = .init(value: 0)
    
    var flags: [FlagModel]
    
    func saveFlag() {
        
    }
    
    init() {
        var flags: [FlagModel] = []
        var id = 0
        for item in Assets.Flag.allFlags {
            let flag = FlagModel(id: id, image: item)
            id += 1
            
            flags.append(flag)
        }
        self.flags = flags
    }
}
