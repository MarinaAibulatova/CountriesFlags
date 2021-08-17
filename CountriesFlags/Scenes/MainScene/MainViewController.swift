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
    private weak var switchView: UISwitch!
    
    private var selectedFlags: [FlagModel] = []

    //MARK: - public properties
    var router: MainRouter!
    
    //MARK: - life cycle
    override func loadView() {
        let view = MainView()
        self.flagLabel = view.flagLabel
        self.chooseButton = view.chooseButton
        self.switchView = view.switchView
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
        switchView.addTarget(self, action: #selector(switchViewTapped(_:)), for: .valueChanged)
    }
    
    private func configureBinding() {
      
    }
    
    private func configureRouter() {
        router = MainRouter(self)
    }

    private func setTitle() {
        title = switchView.isOn ? "Choosing few flags" : "Choosing flag"
    }
    
    private func setLabelText() {
        flagLabel.text = "You choosed \(String(selectedFlags.count)) \(selectedFlags.count > 0 ? "flag": "flags")"
    }
    
    //MARK: - actions
    @objc func buttonTapped(_ sender: UIButton) {
        router.showFlags(with: selectedFlags, isMultiple: switchView.isOn)
    }
    @objc func switchViewTapped(_ sender: UISwitch) {
        setTitle()
        //add clear choosing flags
        self.selectedFlags.removeAll()
        setTitle()
        setLabelText()
    }
    
    // MARK: - Navigation

}

extension MainViewController: FlagsDelegate {
    func didFinishFlag(_ selectedFlags: [FlagModel]) {
        self.selectedFlags = selectedFlags
        setLabelText()
    }
}
