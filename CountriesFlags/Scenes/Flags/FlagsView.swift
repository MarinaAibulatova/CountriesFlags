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
    var imageView: UIImageView!
    //MARK: - private properties
    private var layot: UICollectionViewFlowLayout!
    
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
        backgroundColor = .white
        layot = {
            let i = UICollectionViewFlowLayout()
            i.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
            i.itemSize = CGSize(width: UIScreen.main.bounds.width / 5, height: UIScreen.main.bounds.width / 5)
            return i
        }()
        
        collectionView = {
            let i = UICollectionView(frame: .zero, collectionViewLayout: layot)
            i.backgroundColor = .white
            i.register(FlagCollectionViewCell.self, forCellWithReuseIdentifier: "id")
            return i
        }()
        
        imageView = {
            let i = UIImageView()
            i.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
            i.contentMode = .scaleAspectFit
            
            return i
        }()
        
        addSubview(collectionView)
    }
    
    private func setupConstraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(0)
        }
        
    }
}


