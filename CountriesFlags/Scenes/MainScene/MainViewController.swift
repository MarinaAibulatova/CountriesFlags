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
    
    private var choosedFlagId: Int?

    //MARK: - public properties
    var router: MainRouter!
    
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
        configureRouter()
    }
    
    //MARK: - private methods
    private func configureViews() {
        chooseButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }
    
    private func configureBinding() {
        //test
        
    }
    
    private func configureRouter() {
        router = MainRouter(self)
    }
    
    //MARK: - actions
    @objc func buttonTapped(_ sender: UIButton) {
        router.showFlags(id: choosedFlagId)
    }
    
    // MARK: - Navigation


}

extension MainViewController: FlagsDelegate {
    func didFinishFlag(_ id: Int?) {
        flagLabel.text = (id == nil) ? "" : String(id!)
        choosedFlagId = id
    }
}
