//
//  ViewController.swift
//  CountriesFlags
//
//  Created by Марина Айбулатова on 12.08.2021.
//

import UIKit
import RxCocoa
import RxSwift

class FlagsViewController: UIViewController {

    //MARK: - private properties
    private let disposeBag = DisposeBag()
    
    private weak var collectionView: UICollectionView!
    
    //MARK: - life cycle
    override func loadView() {
        let view = FlagsView()
        self.collectionView = view.collectionView
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Flags"
       
        configureViews()
        configureBinding()
    }
    
    //MARK: - private methods
    private func configureViews() {
        
    }
    
    private func configureBinding() {
        let flags = Observable.of(Assets.Flag.allFlags)
        
        flags
            .bind(to: collectionView.rx.items) {
                (collectionView: UICollectionView, index: Int, element: UIImage) in
                let indexPath = IndexPath(item: index, section: 0)
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "id", for: indexPath) as! FlagCollectionViewCell
                cell.imageFlag.image = element
                
                return cell
            }
            .disposed(by: disposeBag)
        
        
        collectionView.rx
            .itemSelected
            .subscribe(
                onNext: {indexPath in
                    FlagModel.shared.id
                        .accept(indexPath.row)
                }).disposed(by: disposeBag)
    }
}
