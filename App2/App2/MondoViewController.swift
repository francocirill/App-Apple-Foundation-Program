//
//  MondoViewController.swift
//  App2
//
//  Created by Stefano D’Amato on 07/04/21.
//

import UIKit

class MondoViewController: UIViewController {

    @IBOutlet weak var mondo: UILabel!
    
    @IBOutlet weak var background: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.hidesBackButton = true;
        self.navigationController?.navigationItem.backBarButtonItem?.isEnabled = false;
        self.navigationController!.interactivePopGestureRecognizer!.isEnabled = false;
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [unowned self] in
                    self.performSegue(withIdentifier: "start", sender: nil)
                }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if PersistenceManager.fetchData().count != 0 {
            var user = PersistenceManager.fetchData()[0]
            switch user.lastLevel+1 {
            case  1 :
                mondo.text="Mondo 1"
                background.image = UIImage(named: "mondo1.jpeg")!
            case 2 :
                mondo.text="Mondo 2"
                background.image = UIImage(named: "mondo2.jpeg")!
            case 3 :
                mondo.text="Mondo 3"
                background.image = UIImage(named: "mondo3.png")!
            case 4 :
                mondo.text="Mondo 4"
                background.image = UIImage(named: "mondo4.jpeg")!
            case 5 | 21 | 22 | 23 | 24 | 25:
                mondo.text="Mondo 5"
                background.image = UIImage(named: "mondo5.jpeg")!
            default:
                mondo.text="Other"
            }
            
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
