//
//  LoansPageViewController.swift
//  uLendApp
//
//  Created by Manu on 23/1/18.
//  Copyright © 2018 Manu. All rights reserved.
//

import UIKit



class LoansPageViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    
    
    @IBOutlet var pageControl: UIPageControl!
    var pageContainer: UIPageViewController!
    var pages = [UIViewController]()
    var currentIndex: Int?
    private var pendingIndex: Int?
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentIndex = pages.index(of: viewController)!
        if currentIndex == 0 {
            return nil
        }
        let previousIndex = abs((currentIndex - 1) % pages.count)
        return pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currentIndex = pages.index(of: viewController)!
        if currentIndex == pages.count-1 {
            return nil
        }
        let nextIndex = abs((currentIndex + 1) % pages.count)
        return pages[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        pendingIndex = pages.index(of: pendingViewControllers.first!)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            currentIndex = pendingIndex
            if let index = currentIndex {
                pageControl.currentPage = index
            }
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup the pages
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let page1: UIViewController! = storyboard.instantiateViewController(withIdentifier: "page1")
        let page2: UIViewController! = storyboard.instantiateViewController(withIdentifier: "page2")
//        let page3: UIViewController! = storyboard.instantiateViewControllerWithIdentifier("page3")
        pages.append(page1)
        pages.append(page2)
//        pages.append(page3)
        
        // Create the page container
        pageContainer = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageContainer.delegate = self
        pageContainer.dataSource = self
        pageContainer.setViewControllers([page1], direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)
        
        // Add it to the view
        view.addSubview(pageContainer.view)
        
        // Configure our custom pageControl
        view.bringSubview(toFront: pageControl)
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = 0
        
    }



}
