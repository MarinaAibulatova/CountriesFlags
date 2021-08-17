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
    weak var delegate: FlagsDelegate?
    
    var viewModel: FlagsViewModel
    var router: FlagsRouter!
    var isMultiple: Bool = false
    var flags: [FlagModel] = []
    
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
        
        self.flags = viewModel.selectedFlags.value
        
        DispatchQueue.main.async {
            for flag in self.viewModel.selectedFlags.value {
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
        collectionView.allowsMultipleSelection = self.isMultiple
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
        setTitleImageView(for: viewModel.selectedFlags.value)
    }
    
   @objc func didFinishSelected(_ sender: UIButton) {
        self.delegate?.didFinishFlag(viewModel.selectedFlags.value)
        self.router.back()
    }
    
    private func setTitleImageView(for flags: [FlagModel]) {
        if !self.isMultiple, flags.count > 0 {
            let flag = flags[0]
            if let url = flag.url {
                KingfisherManager.shared.retrieveImage(with: url) {
                    (result) in
                    
                    switch result {
                    case .success(let value):
                        DispatchQueue.main.async {
                            let imageView = UIImageView(image: value.image)
                            imageView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
                            imageView.contentMode = .scaleAspectFit
                            self.navigationItem.titleView = imageView
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
 
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if isMultiple {
            self.viewModel.selectedFlags.accept(
                self.viewModel.selectedFlags.value + [viewModel.flags[indexPath.row]])
            flags = self.viewModel.selectedFlags.value
        }else {
            self.viewModel.selectedFlags.accept([viewModel.flags[indexPath.row]])
            setTitleImageView(for: viewModel.selectedFlags.value)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
       
        if isMultiple {
            let index = flags.firstIndex(of: viewModel.flags[indexPath.row])
            flags.remove(at: index!)
            self.viewModel.selectedFlags.accept(flags)
        }else {
            self.viewModel.selectedFlags.accept([])
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
