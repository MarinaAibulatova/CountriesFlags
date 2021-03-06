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
    var isMultiple: Bool {get set}
    var selectedFlags: [FlagModel] {get set}
}

class FlagsDetailViewModel: FlagsViewModel {
    var selectedFlags: [FlagModel] = []
    var isMultiple: Bool = false
    var flags: [FlagModel]
    
    func saveFlag() {
        
    }
    
    init(currentFlags: [FlagModel], _ isMultiple: Bool) {
        var flags: [FlagModel] = []
        var id = 0
        
        if let docPath = Bundle.main.resourcePath {
            print(docPath)
            let imagesPath = docPath + "/flagsImages"
            let url = NSURL(fileURLWithPath: imagesPath)
            let fileManager = FileManager.default
            
            let properties = [URLResourceKey.localizedNameKey,
                              URLResourceKey.creationDateKey,
                              URLResourceKey.localizedTypeDescriptionKey]
            
            do {
                let imagesURL = try fileManager.contentsOfDirectory(at: url as URL, includingPropertiesForKeys: properties, options: FileManager.DirectoryEnumerationOptions.skipsHiddenFiles)
                
                for urlImage in imagesURL {
                    let flag = FlagModel(id: id, url: urlImage)
                    id += 1
                    flags.append(flag)
                }
            }catch {
                print(error.localizedDescription)
            }
        }
        
        self.flags = flags
        self.selectedFlags = currentFlags
        self.isMultiple = isMultiple
    }
}

