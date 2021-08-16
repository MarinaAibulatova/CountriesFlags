//
//  ViewController.swift
//  CountriesFlags
//
//  Created by Марина Айбулатова on 12.08.2021.
//

import UIKit
import RxCocoa
import RxSwift

protocol FlagsDelegate: AnyObject {
    func didFinishFlag(_ id: Int)
}

class FlagsViewController: UIViewController {

    //MARK: - private properties
    private let disposeBag = DisposeBag()
    
    private weak var collectionView: UICollectionView!
    weak var delegate: FlagsDelegate?
    
    var viewModel: FlagsViewModel
    var router: FlagsRouter!
    
    init(viewModel: FlagsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        configureRouter()
        configureNavigatorBar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let indexPath = IndexPath(row: viewModel.choosedFlag.value, section: 0)
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .top)
    }
    
    //MARK: - private methods
    private func configureViews() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func configureBinding() {
        
        collectionView.rx
            .itemSelected
            .subscribe(
                onNext: {
                    [weak self] (indexPath) in
                    self?.viewModel.choosedFlag.accept(indexPath.row)
                    self?.delegate?.didFinishFlag(indexPath.row)
                })
            .disposed(by: disposeBag)
    }
    
    private func configureRouter() {
        router = FlagsRouter(self)
    }
    
    private func configureNavigatorBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "square.and.arrow.down.fill"),
            style: .plain,
            target: router,
            action: #selector(router.back))
    }
}

extension FlagsViewController: UICollectionViewDelegate {
  
}

extension FlagsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.flags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "id", for: indexPath) as! FlagCollectionViewCell
        let flag = viewModel.flags[indexPath.row]
        cell.configure(flag)
        
        return cell
    }
    
    
}
