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
    
    //MARK: - private properties
    private var flags: [UIImage]!
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
        flags = Assets.Flag.allFlags
        
        layot = {
            let i = UICollectionViewFlowLayout()
            i.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
            i.itemSize = CGSize(width: 60, height: 60)
            return i
        }()
        
        collectionView = {
            let i = UICollectionView(frame: .zero, collectionViewLayout: layot)
            i.delegate = self
            i.dataSource = self
            i.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "id")
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

//MARK: - UICollectionViewDataSource
extension FlagsView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        flags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "id", for: indexPath)
        cell.backgroundColor = .red
        
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension FlagsView: UICollectionViewDelegate {
    
}
