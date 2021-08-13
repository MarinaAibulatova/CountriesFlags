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
    
    //MARK: - public methods
    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                contentView.layer.borderWidth = 2
                contentView.layer.borderColor = UIColor.gray.cgColor
            }else {
                contentView.layer.borderWidth = 0
                contentView.layer.borderColor = UIColor.white.cgColor
            }
        }
    }
    
    func configure(_ flag: FlagModel) {
        imageFlag.image = flag.image
    }
    
    
    //MARK: - private methods
    private func setupView() {
        imageFlag =  {
            let i = UIImageView()
            i.contentMode = .scaleAspectFit
            return i
        }()
        
        contentView.addSubview(imageFlag)
    }
    
    private func setupConstraints() {
        imageFlag.snp.makeConstraints {
            $0.edges.equalTo(0)
        }
    }
    


    
    
    

}
