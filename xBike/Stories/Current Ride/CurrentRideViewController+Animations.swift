//
//  CurrentRideViewController+Animations.swift
//  xBike
//
//  Created by Francisco Obarrio on 09/04/2023.
//

import UIKit
import SnapKit

/// Animations
extension CurrentRideViewController {
    
    func doAnimModalStartFadeIn() {
        addModalStart()
        
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.8,  options: [.curveEaseIn], animations: {
            self.modalStartView.snp.updateConstraints { (make) in
                make.bottom.equalToSuperview().offset(-30)
            }
            self.view.layoutIfNeeded()
            
        })
    }
    
    func doAnimModalStartFadeOff() {
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.8,  options: [.curveEaseIn], animations: {
            self.modalStartView.snp.updateConstraints { (make) in
                make.bottom.equalToSuperview().offset(400)
            }
            self.view.layoutIfNeeded()
            
        })
    }
    
    func doAnimModalYourTimeFadeIn() {
        addModalYourTime()
        
        UIView.animate(withDuration: 0.4, delay: 0.3, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.8,  options: [.curveEaseIn], animations: {
            self.modalYourTimeView.snp.updateConstraints { (make) in
                make.centerY.equalToSuperview()
            }
            self.view.layoutIfNeeded()
            
        })
    }
    
    func doAnimModalYourTimeFadeOff() {
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.8,  options: [.curveEaseIn], animations: {
            self.modalYourTimeView.snp.updateConstraints { (make) in
                make.centerY.equalToSuperview().offset(800)
            }
            self.view.layoutIfNeeded()
        })
    }
    
    func doAnimModalSuccessFadeIn() {
        addModalSuccess()
        
        UIView.animate(withDuration: 0.4, delay: 0.3, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.8,  options: [.curveEaseIn], animations: {
            self.modalSuccessView.snp.updateConstraints { (make) in
                make.centerY.equalToSuperview().offset(50)
            }
            self.view.layoutIfNeeded()
        })
    }
    
    func doAnimModalSuccessFadeOff() {
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.8,  options: [.curveEaseIn], animations: {
            self.modalSuccessView.snp.updateConstraints { (make) in
                make.centerY.equalToSuperview().offset(800)
            }
            self.view.layoutIfNeeded()
            
        })
    }
}
