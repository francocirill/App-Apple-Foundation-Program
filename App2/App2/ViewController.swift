//
//  ViewController.swift
//  App2
//
//  Created by Franco Cirillo on 12/02/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.hidesBackButton = true;
        self.navigationController?.navigationItem.backBarButtonItem?.isEnabled = false;
        self.navigationController!.interactivePopGestureRecognizer!.isEnabled = false;
    self.view.backgroundColor = UIColor(patternImage: UIImage(named: "imgpsh_fullsize (2)")!)
    }

    @IBAction func unwind( _ seg: UIStoryboardSegue) {
    }
    
}

