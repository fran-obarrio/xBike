//
//  OnBoardingViewController.swift
//  xBike
//
//  Created by Francisco Obarrio on 07/04/2023.
//

import UIKit
import SnapKit

class OnBoardingViewController: UIPageViewController {

    var pages = [UIViewController]()
    let pageControl = UIPageControl()
    let initialPage = 0
    
    var coordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isHidden = true
        
        setupPager()
        setupPagerControl()
        setupPagerLayout()
    }
    
    func setupPager() {
        dataSource = self
        delegate = self
        
        let page1 = PageContentViewController(title: "OnBoardingPage1".localized, imageName: UIImage(named: "icons8-bike-path"))
        let page2 = PageContentViewController(title: "OnBoardingPage2".localized, imageName: UIImage(named: "icons8-distance"))
        let page3 = PageContentViewController(title: "OnBoardingPage3".localized, imageName: UIImage(named: "icons8-progress"), isLastPage: true)
        page3.delegate = self
        
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        
        setViewControllers([pages[initialPage]], direction: .forward, animated: true, completion: nil)
                
    }
    
    func setupPagerControl() {
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .systemGray2
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = initialPage
        pageControl.addTarget(self, action: #selector(pageControlTapped(_:)), for: .valueChanged)
    }
    
    func setupPagerLayout() {
        view.addSubview(pageControl)
        
        pageControl.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(20)
            make.bottom.equalToSuperview().inset(50)
        }
    }

    @objc func pageControlTapped(_ sender: UIPageControl) {
        setViewControllers([pages[sender.currentPage]], direction: .forward, animated: true, completion: nil)
    }
    
}

extension OnBoardingViewController: PagerDelegate {
    func closeOnBoarding() {
        coordinator?.closeOnBoarding()
    }
}


// MARK: - DataSources
extension OnBoardingViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        
        if currentIndex == 0 {
            return pages.last
        } else {
            return pages[currentIndex - 1]
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        
        if currentIndex < pages.count - 1 {
            return pages[currentIndex + 1]
        } else {
            return pages.first
        }
    }
}

// MARK: - Delegates
extension OnBoardingViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        guard let viewControllers = pageViewController.viewControllers else { return }
        guard let currentIndex = pages.firstIndex(of: viewControllers[0]) else { return }
        
        pageControl.currentPage = currentIndex
    }
}
