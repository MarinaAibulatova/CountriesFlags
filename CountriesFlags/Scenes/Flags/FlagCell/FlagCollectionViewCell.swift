//
//  FlagViewCell.swift
//  CountriesFlags
//
//  Created by Марина Айбулатова on 12.08.2021.
//

import UIKit

class FlagCollectionViewCell: UICollectionViewCell {
    //MARK: - public properties
    var imageFlag: UIImageView!
    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - private methods
    private func setupView() {
        imageFlag =  {
            let i = UIImageView()
            i.contentMode = .scaleToFill
            return i
        }()
        
        addSubview(imageFlag)
    }
    
    private func setupConstraints() {
        imageFlag.snp.makeConstraints {
            $0.edges.equalTo(0)
        }
    }
    


    
    
    

}
