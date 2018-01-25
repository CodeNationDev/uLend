//
//  ItemPageViewController.swift
//  uLendApp
//
//  Created by Manu on 24/1/18.
//  Copyright © 2018 Manu. All rights reserved.
//

import UIKit

class ItemPageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    
    var pageControl = UIPageControl.appearance()
    
    

    

    lazy var subViewControllers = {
        return [
            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ItemsOwnViewController"),
            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ItemsNonOwnViewController")
        ]
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.delegate = self
        self.dataSource = self
        setViewControllers([subViewControllers[0]], direction: .forward, animated: true, completion: nil)
        configurePageControl()
    }
    
    


}



extension ItemPageViewController {
    
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        //        return subViewControllers[0]
        
        
        let currentIndex = subViewControllers.index(of: viewController) ?? 0
        
        if currentIndex <= 0 {
            return nil
        }
        
        return subViewControllers[currentIndex - 1]
        
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        //        return subViewControllers[1]
        let currentIndex = subViewControllers.index(of: viewController) ?? 0
        
        if currentIndex >= subViewControllers.count - 1 {
            return nil
        }
        
        return subViewControllers[currentIndex + 1]
    }
    
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return subViewControllers.count
    }
    
    
    
    
    func configurePageControl() {
        // The total number of pages that are available is based on how many available colors we have.
        //        pageControl = UIPageControl(frame: CGRect(x: 0,y: UIScreen.main.bounds.minY - 100,width: UIScreen.main.bounds.width,height: 50))
        print(UIScreen.main.bounds.minY)
        pageControl = UIPageControl(frame: CGRect(x: 0, y: UIScreen.main.bounds.minY + 5, width: UIScreen.main.bounds.width, height: 50))
        //        pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        pageControl.numberOfPages = subViewControllers.count
        pageControl.currentPage = 0
        pageControl.tintColor = UIColor.black
        pageControl.pageIndicatorTintColor = UIColor.white
        pageControl.currentPageIndicatorTintColor = UIColor.black
        self.view.addSubview(pageControl)
        
    }
    
    
    
    // MARK: Delegate functions
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        self.pageControl.currentPage = subViewControllers.index(of: pageContentViewController)!
    }
}
