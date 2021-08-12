//
//  FlagsView.swift
//  CountriesFlags
//
//  Created by Марина Айбулатова on 12.08.2021.
//

import UIKit

class FlagsView: UIView {
    
    //MARK: - public properties
    var collectionView: UICollectionView!
    
    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - private methods
    private func setupViews() {
        collectionView = {
            let i = UICollectionView()
            
            return i
        }()
    }
    
    private func setupConstraints() {
        
    }
    
    
    

    
    
    
    

    

}
