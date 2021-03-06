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
    func didFinishFlag(_ selectedFlag: [FlagModel])
}

class FlagsViewController: UIViewController {

    //MARK: - private properties
    private let disposeBag = DisposeBag()
    
    private weak var collectionView: UICollectionView!
    private weak var imageView: UIImageView!
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
        self.imageView = view.imageView
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
            for flag in self.viewModel.selectedFlags {
                let indexPath = IndexPath(row: flag.id, section: 0)
                self.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .top)
            }
        }
    }
    
    
    //MARK: - private methods
    private func configureViews() {
        collectionView.register(FlagCollectionViewCell.self, forCellWithReuseIdentifier: FlagCollectionViewCell.idCell)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.allowsMultipleSelection = self.viewModel.isMultiple
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
        setTitleImageView(for: viewModel.selectedFlags)
    }
    
   @objc func didFinishSelected(_ sender: UIButton) {
        self.delegate?.didFinishFlag(viewModel.selectedFlags)
        self.router.back()
    }
    
    private func setTitleImageView(for flags: [FlagModel]) {
        if !self.viewModel.isMultiple, flags.count > 0 {
            let flag = flags[0]
            if let url = flag.url {
                KingfisherManager.shared.retrieveImage(with: url) {
                    (result) in
                    
                    switch result {
                    case .success(let value):
                        DispatchQueue.main.async {
                            self.imageView.image = value.image
                            self.navigationItem.titleView = self.imageView
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
}

extension FlagsViewController: UICollectionViewDelegate {
 
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        let cell = collectionView.cellForItem(at: indexPath) as! FlagCollectionViewCell
        if cell.isSelected, !viewModel.isMultiple {
            self.viewModel.selectedFlags.removeAll()
            collectionView.deselectItem(at: indexPath, animated: true)
            return false
        }
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if viewModel.isMultiple {
            self.viewModel.selectedFlags += [viewModel.flags[indexPath.row]]
        }else {
            self.viewModel.selectedFlags = [viewModel.flags[indexPath.row]]
            setTitleImageView(for: viewModel.selectedFlags)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
       
        if viewModel.isMultiple {
            let index = self.viewModel.selectedFlags.firstIndex(of: viewModel.flags[indexPath.row])
            self.viewModel.selectedFlags.remove(at: index!)
        }else {
            self.viewModel.selectedFlags.removeAll()
        }
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
