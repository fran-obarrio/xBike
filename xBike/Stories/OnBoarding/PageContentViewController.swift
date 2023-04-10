//
//  PageContentViewController.swift
//  xBike
//
//  Created by Francisco Obarrio on 07/04/2023.
//

import UIKit
import SnapKit

protocol PagerDelegate: AnyObject {
    func closeOnBoarding()
}

class PageContentViewController: UIViewController {
        
    weak var delegate: PagerDelegate?
    
    lazy var imageViewPager: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = image
        return imageView
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Abel-Regular", size: 40)
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = pagerText
        return label
    }()
    
    var image: UIImage? {
        didSet {
            imageViewPager.image = image
        }
    }
    
    var pagerText: String? {
        didSet {
            descriptionLabel.text = pagerText
        }
    }
    
    var isLastPageView: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .orange
        self.view.addSubview(imageViewPager)
        self.view.addSubview(descriptionLabel)
        
        
        imageViewPager.snp.makeConstraints { make in
            make.size.equalTo(100)
            make.centerY.equalToSuperview().offset(-50)
            make.centerX.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(imageViewPager.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(40)
        }
        
        if isLastPageView {
            let btnRightMenu: UIButton = UIButton()
            btnRightMenu.setImage(UIImage(named: "icons8-cancel"), for: .normal)
            btnRightMenu.addTarget(self, action: #selector(closePagerController), for: .touchUpInside)
            btnRightMenu.contentHorizontalAlignment = .right
            
            self.view.addSubview(btnRightMenu)
            btnRightMenu.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(50)
                make.trailing.equalToSuperview().inset(25)
                make.width.height.equalTo(40)
            }
        }
    }
    
    init(title: String, imageName: UIImage?, isLastPage: Bool = false) {
        super.init(nibName: nil, bundle: nil)
        image = imageName
        pagerText = title
        isLastPageView = isLastPage
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func closePagerController(){
        delegate?.closeOnBoarding()
    }
    
}
