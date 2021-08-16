//
//  ViewController.swift
//  CountriesFlags
//
//  Created by Марина Айбулатова on 12.08.2021.
//

import UIKit
import RxCocoa
import RxSwift
import Kingfisher

protocol FlagsDelegate: AnyObject {
    func didFinishFlag(_ selectedFlag: FlagModel?)
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
        
        DispatchQueue.main.async {
            if let selectedFlag = self.viewModel.selectedFlag.value {
                let indexPath = IndexPath(row: selectedFlag.id, section: 0)
                self.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .top)
            }
        }
    }
    
    
    //MARK: - private methods
    private func configureViews() {
        collectionView.register(FlagCollectionViewCell.self, forCellWithReuseIdentifier: FlagCollectionViewCell.idCell)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func configureBinding() {
        
    }
    
    private func configureRouter() {
        router = FlagsRouter(self)
    }
    
    private func configureNavigatorBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "square.and.arrow.down.fill"),
            style: .plain,
            target: self,
            action: #selector(didFinishSelected(_:))
        )
        setTitleImageView(for: viewModel.selectedFlag.value)
    }
    
   @objc func didFinishSelected(_ sender: UIButton) {
        self.delegate?.didFinishFlag(viewModel.selectedFlag.value)
        self.router.back()
    }
    
    private func setTitleImageView(for flag: FlagModel?) {
        if let flag = flag, let url = flag.url {
            KingfisherManager.shared.retrieveImage(with: url) {
                (result) in
                
                switch result {
                case .success(let value):
                    print(value.image)
                    DispatchQueue.main.async {
                        let imageView = UIImageView(image: value.image)
                        imageView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
                        imageView.contentMode = .scaleAspectFit
                        self.navigationItem.titleView = imageView
                    }
                case .failure(let error):
                    print(error.errorDescription)
                }
            }
        }
    }
}

extension FlagsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let cell = collectionView.cellForItem(at: indexPath) as! FlagCollectionViewCell
        
        if cell.isSelected {
            collectionView.selectItem(at: nil, animated: true, scrollPosition: .centeredVertically)
            self.viewModel.selectedFlag.accept(nil)
            
            return false
        }
        self.viewModel.selectedFlag.accept(viewModel.flags[indexPath.row])
        setTitleImageView(for: viewModel.selectedFlag.value)
        return true
    }
}

extension FlagsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.flags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FlagCollectionViewCell.idCell, for: indexPath) as! FlagCollectionViewCell
        let flag = viewModel.flags[indexPath.row]
        cell.configure(flag)
        
        return cell
    }
    
}
