//
//  TutorialViewController.swift
//  App2
//
//  Created by Marco Venere on 20/02/21.
//

import UIKit

class TutorialViewController: UIViewController {


    
    override func viewDidLoad() {
        navigationItem.hidesBackButton = true;
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        self.navigationController?.navigationBar.tintColor = UIColor.white;
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
     */


}
