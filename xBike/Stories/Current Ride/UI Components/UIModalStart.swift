//
//  UIModalStart.swift
//  xBike
//
//  Created by Francisco Obarrio on 06/04/2023.
//

import UIKit
import SnapKit

protocol UIModalStartDelegate: AnyObject {
    func doStartRide()
    func doStopRide(time: String)
}

class UIModalStartView: UIView {
    
    weak var delegate: UIModalStartDelegate?
    
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
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Abel-Regular", size: 40)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    lazy var startButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont(name: "Abel-Regular", size: 18)
        button.setTitleColor(UIColor(red: 1, green: 0.556, blue: 0.146, alpha: 1), for: .normal)
        button.setTitleColor(UIColor(red: 0.742, green: 0.742, blue: 0.742, alpha: 1), for: .disabled)
        button.contentHorizontalAlignment = .center
        button.addTarget(self, action: #selector(handleTapStart), for: .touchUpInside)
        button.setTitle("ButtonSTART".localized, for: .normal)
        return button
    }()
    
    lazy var stopButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont(name: "Abel-Regular", size: 18)
        button.setTitleColor(UIColor(red: 1, green: 0.556, blue: 0.146, alpha: 1), for: .normal)
        button.setTitleColor(UIColor(red: 0.742, green: 0.742, blue: 0.742, alpha: 1), for: .disabled)
        button.contentHorizontalAlignment = .center
        button.addTarget(self, action: #selector(handleTapStop), for: .touchUpInside)
        button.setTitle("ButtonSTOP".localized, for: .normal)
        button.isEnabled = false
        return button
    }()
    
    var timer = Timer()
    var time = 0
    
    var timeData: String? {
        didSet {
            timeLabel.text = timeData ?? ""
        }
    }
    
    func resetData() {
        time = 0
        timeLabel.text = "00 : 00 : 00"
        startButton.isEnabled = true
        stopButton.isEnabled = false
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(contentView)
        contentView.addSubview(timeLabel)
        contentView.addSubview(separatorView)
        contentView.addSubview(startButton)
        contentView.addSubview(stopButton)
        
        
        contentView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        timeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(35)
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
    
    func updateTimeLabel() {
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        timeData = String(format: "%02d : %02d : %02d", hours, minutes, seconds)
    }
    
    @objc func handleTapStart() {
        if timer.isValid {
            timer.invalidate()
        } else {
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            startButton.isEnabled = false
            stopButton.isEnabled = true
            
            delegate?.doStartRide()
        }
    }
    
    @objc func handleTapStop() {
        if timer.isValid {
            timer.invalidate()
            
            delegate?.doStopRide(time: timeLabel.text ?? "")
        } else {
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        }
    }
    
    @objc func updateTimer() {
        time += 1
        updateTimeLabel()
    }
    
}
