//
//  UIModalSuccess.swift
//  xBike
//
//  Created by Francisco Obarrio on 06/04/2023.
//

import UIKit
import SnapKit

protocol UIModalSuccessDelegate: AnyObject {
    func doCloseModal()
}

class UIModalSuccessView: UIView {
    
    weak var delegate: UIModalSuccessDelegate?
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 25
        view.backgroundColor = .white
        return view
    }()
    
    lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 1, green: 0.556, blue: 0.146, alpha: 1)
        return view
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Abel-Regular", size: 25)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.text = "ModalSuccessDescription".localized
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    lazy var okButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont(name: "Abel-Regular", size: 18)
        button.setTitleColor(UIColor(red: 0.742, green: 0.742, blue: 0.742, alpha: 1), for: .normal)
        button.contentHorizontalAlignment = .center
        button.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        button.setTitle("ButtonOK".localized, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(contentView)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(okButton)
        
        
        contentView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(40)
        }
        
        okButton.snp.makeConstraints { make in
            make.width.equalTo(150)
            make.height.equalTo(40)
            make.bottom.equalToSuperview().inset(45)
            make.centerX.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleTap() {
        delegate?.doCloseModal()
    }
    
}

