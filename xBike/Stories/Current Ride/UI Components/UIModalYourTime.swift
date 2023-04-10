//
//  UIModalYourTime.swift
//  xBike
//
//  Created by Francisco Obarrio on 06/04/2023.
//

import UIKit
import SnapKit

protocol UIModalYourTimeDelegate: AnyObject {
    func doStoreRide(time: String)
    func doDeleteRide()
}

class UIModalYourTimeView: UIView {
    
    weak var delegate: UIModalYourTimeDelegate?
    
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
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Abel-Regular", size: 25)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.text = "ModalYourTimeTitle".localized
        return label
    }()
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Abel-Regular", size: 40)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.text = "00 : 00 : 00"
        return label
    }()
    
    lazy var titleDistanceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Abel-Regular", size: 25)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.text = "ModalYourTimeDistance".localized
        return label
    }()

    lazy var distanceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Abel-Regular", size: 40)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.text = "10.0 km"
        return label
    }()
    
    lazy var startButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont(name: "Abel-Regular", size: 18)
        button.setTitleColor(UIColor(red: 1, green: 0.556, blue: 0.146, alpha: 1), for: .normal)
        button.setTitleColor(UIColor(red: 0.742, green: 0.742, blue: 0.742, alpha: 1), for: .disabled)
        button.contentHorizontalAlignment = .center
        button.addTarget(self, action: #selector(handleTapStore), for: .touchUpInside)
        button.setTitle("ButtonSTORE".localized, for: .normal)
        return button
    }()
    
    lazy var stopButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont(name: "Abel-Regular", size: 18)
        button.setTitleColor(UIColor(red: 0.742, green: 0.742, blue: 0.742, alpha: 1), for: .normal)
        button.contentHorizontalAlignment = .center
        button.addTarget(self, action: #selector(handleTapDelete), for: .touchUpInside)
        button.setTitle("ButtonDELETE".localized, for: .normal)
        return button
    }()
    
    var time: String? {
        didSet {
            timeLabel.text = time ?? ""
        }
    }
    
    var distance: String? {
        didSet {
            distanceLabel.text = distance ?? ""
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(titleDistanceLabel)
        contentView.addSubview(distanceLabel)
        contentView.addSubview(startButton)
        contentView.addSubview(stopButton)
        contentView.addSubview(separatorView)
        
        
        contentView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(35)
            make.centerX.equalToSuperview()
        }
        
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        
        titleDistanceLabel.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        distanceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleDistanceLabel.snp.bottom).offset(2)
            make.centerX.equalToSuperview()
        }
        
        separatorView.snp.makeConstraints { make in
            make.width.equalTo(3)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().inset(30)
            make.centerX.equalToSuperview()
        }
        
        startButton.snp.makeConstraints { make in
            make.width.equalTo(150)
            make.height.equalTo(40)
            make.bottom.equalToSuperview().inset(35)
            make.leading.equalToSuperview().inset(20)
        }
        
        stopButton.snp.makeConstraints { make in
            make.width.equalTo(150)
            make.height.equalTo(40)
            make.bottom.equalToSuperview().inset(35)
            make.trailing.equalToSuperview().inset(20)
        }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleTapStore() {
        delegate?.doStoreRide(time: time ?? "")
    }

    @objc func handleTapDelete() {
        delegate?.doDeleteRide()
    }

}

