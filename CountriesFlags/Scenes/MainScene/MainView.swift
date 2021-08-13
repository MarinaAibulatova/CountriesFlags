//
//  MainView.swift
//  CountriesFlags
//
//  Created by Марина Айбулатова on 13.08.2021.
//

import UIKit

class MainView: UIView {
    //MARK: - public properties
    var flagLabel: UILabel!
    var chooseButton: UIButton!
    
    //MARK: - private properties
    var contentStackView: UIStackView!
    
    //MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - private properties
    private func setupViews() {
        backgroundColor = .white
        contentStackView = {
            let i = UIStackView()
            i.axis = .vertical
            i.spacing = 10
            i.alignment = .fill
            i.distribution = .fill
            return i
        }()
        
        flagLabel = {
            let i = UILabel()
            i.text = "Your country"
            i.textAlignment = .center
            i.font = UIFont.systemFont(ofSize: 14)
            i.textColor = .black
            
            return i
        }()
        
        chooseButton = {
           let i = UIButton()
            i.setTitle("Please, choose your country", for: .normal)
            i.setTitleColor(.systemTeal, for: .normal)
            i.backgroundColor = UIColor.systemGray
            i.layer.cornerRadius = 10
            
            return i
        }()
        
        addSubview(contentStackView)
        contentStackView.addArrangedSubview(flagLabel)
        contentStackView.addArrangedSubview(chooseButton)
    }
    
    private func setupConstraints() {
        contentStackView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide.snp.top)
            $0.width.equalToSuperview()
            $0.height.equalTo(300)
        }
    }

}
