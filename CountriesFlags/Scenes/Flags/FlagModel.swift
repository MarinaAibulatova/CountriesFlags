//
//  FlagModel.swift
//  CountriesFlags
//
//  Created by Марина Айбулатова on 12.08.2021.
//

import Foundation
import RxSwift
import RxCocoa

class FlagModel {
    static let shared: FlagModel = {
       let i = FlagModel()
        
        return i
    }()
    
    var id: BehaviorRelay<Int> = .init(value: 0)
    
    private init() {}
}
