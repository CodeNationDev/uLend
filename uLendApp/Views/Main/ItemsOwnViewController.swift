//
//  ItemsOwnViewController.swift
//  uLendApp
//
//  Created by Manu on 23/1/18.
//  Copyright © 2018 Manu. All rights reserved.
//

import UIKit

final class ItemsOwnViewController: UIViewController {

    
    @IBOutlet var newItemQuestionView: UIView!
    
    @IBOutlet var newItemButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        newItemQuestionView.bounds = UIScreen.main.bounds
//        newItemQuestionView.bounds = self.view.bounds
//        newItemQuestionView.sizeToFit()
        

        
      
    }


    
    @IBAction func newItemPressed(_ sender: Any) {
        newItemButton.isEnabled = false
        animateView()
    }
    



}

extension ItemsOwnViewController {
    
    func animateView(){
        
        self.view.addSubview(newItemQuestionView)
        newItemQuestionView.center = self.view.center
        newItemQuestionView.transform = CGAffineTransform.init(scaleX: 0.01, y: 0.01)
        newItemQuestionView.alpha = 0
        
        UIView.animate(withDuration: 0.33) {
            self.newItemQuestionView.transform = CGAffineTransform.identity
            self.newItemQuestionView.alpha = 1
        }

    }
    
}
