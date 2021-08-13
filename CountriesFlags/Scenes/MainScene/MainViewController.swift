//
//  MainViewController.swift
//  CountriesFlags
//
//  Created by Марина Айбулатова on 12.08.2021.
//

import UIKit
import RxCocoa
import RxSwift

class MainViewController: UIViewController {

    //MARK: - private properties
    private let disposeBag = DisposeBag()
    private weak var flagLabel: UILabel!
    private weak var chooseButton: UIButton!

    //MARK: - life cycle
    override func loadView() {
        let view = MainView()
        self.flagLabel = view.flagLabel
        self.chooseButton = view.chooseButton
        self.view = view
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Choosing flag"
        configureViews()
        configureBinding()
    }
    
    //MARK: - private methods
    private func configureViews() {
        chooseButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }
    
    private func configureBinding() {
        FlagModel.shared.id
            .asObservable()
            .map{id -> String in return String(id)}
            .bind(to: flagLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    //MARK: - actions
    @objc func buttonTapped(_ sender: UIButton) {
        let controller = FlagsViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    // MARK: - Navigation


}
