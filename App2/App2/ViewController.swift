//
//  ViewController.swift
//  App2
//
//  Created by Franco Cirillo on 12/02/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var stars: UILabel!
    @IBOutlet weak var level: UILabel!
    @IBOutlet weak var finalText: UILabel!
    @IBOutlet weak var continuaButton: UIButton!
    @IBOutlet weak var avatar: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        finalText.isHidden = true
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.hidesBackButton = true;
        self.navigationController?.navigationItem.backBarButtonItem?.isEnabled = false;
        self.navigationController!.interactivePopGestureRecognizer!.isEnabled = false;
        
        if PersistenceManager.fetchData().count == 0 {let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "TutorialViewController")
            //self.newViewController?.isModalInPresentation = true
            self.navigationController?.pushViewController(newViewController, animated: true)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        if PersistenceManager.fetchData().count != 0 {
            var user = PersistenceManager.fetchData()[0]
            userName.text = user.name!
            stars.text = String(user.points)
            level.text = String(user.lastLevel + 1)
            avatar.image = UIImage(named: user.avatar!)
            if user.lastLevel == 50 {
                finalText.isHidden = false
                continuaButton.isHidden = true
            }
        }
    }
    
//    @IBAction func unwind( _ seg: UIStoryboardSegue) {
//    }
    
}

