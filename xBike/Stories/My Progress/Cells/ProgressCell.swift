//
//  ProgressCell.swift
//  xBike
//
//  Created by Francisco Obarrio on 06/04/2023.
//

import UIKit
import SnapKit

class ProgressCell: UITableViewCell {
    
    var cellData: RideModel? {
        didSet {
            timeLabel.text = cellData?.time ?? ""
            distanceLabel.text = cellData?.distance ?? ""
            initialAddressLabel.text = cellData?.startAddress ?? ""
            finalAddressLabel.text = cellData?.finalAddress ?? ""
        }
    }
    
    // MARK: - Views
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.font  = UIFont(name: "Abel-Regular", size: 30)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.text = "00 : 00 : 00"
        label.textAlignment = .left
        return label
    }()
    
    lazy var distanceLabel: UILabel = {
        let label = UILabel()
        label.font  = UIFont(name: "Abel-Regular", size: 22)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.text = "20.0 km"
        label.textAlignment = .left
        return label
    }()
    
    lazy var initialAddressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Abel-Regular", size: 12)
        label.textColor = UIColor(red: 0.488, green: 0.488, blue: 0.488, alpha: 1)
        label.text = "A: Av. Aramburu 245 Surquillo"
        label.textAlignment = .left
        return label
    }()
    
    lazy var finalAddressLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Abel-Regular", size: 12)
        label.textColor = UIColor(red: 0.488, green: 0.488, blue: 0.488, alpha: 1)
        label.text = "B: Av. Brasil 245 Magdalena"
        label.textAlignment = .left
        return label
    }()
    
    lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupViews() {
        contentView.addSubview(timeLabel)
        contentView.addSubview(distanceLabel)
        contentView.addSubview(initialAddressLabel)
        contentView.addSubview(finalAddressLabel)
        contentView.addSubview(separatorView)
        
        timeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(6)
            make.leading.equalToSuperview().inset(8)
            make.height.equalTo(30)
            make.width.equalTo(150)
        }

        distanceLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(6)
            make.centerY.equalToSuperview()
            make.height.equalTo(25)
            make.width.equalTo(80)
        }
        
        initialAddressLabel.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().inset(10)
            make.trailing.equalTo(distanceLabel.snp.leading).offset(-15)
            make.height.equalTo(12)
        }
        
        finalAddressLabel.snp.makeConstraints { make in
            make.top.equalTo(initialAddressLabel.snp.bottom).offset(5)
            make.leading.equalToSuperview().inset(10)
            make.trailing.equalTo(distanceLabel.snp.leading).offset(-15)
            make.height.equalTo(12)
            make.bottom.equalToSuperview().inset(16)
        }
        
        separatorView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(2)
            make.bottom.equalToSuperview().inset(1)
        }
    }
}
