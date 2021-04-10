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
            case  1..<11:
                mondo.text="Bosco delle T"
                background.image = UIImage(named: "mondo1.jpg")!
            case  11..<21:
                mondo.text="Isola delle R"
                background.image = UIImage(named: "mondo2.png")!
            case  21..<31:
                mondo.text="Precipizio delle S"
                background.image = UIImage(named: "mondo3.jpg")!
            case  31..<41:
                mondo.text="Abisso delle GN"
                background.image = UIImage(named: "mondo4.png")!
            case  41..<51:
                mondo.text="Foresta delle SC"
                background.image = UIImage(named: "mondo5.jpg")!
            default:
                mondo.text="Other"
            }
            
        }
        mondo.backgroundColor = UIColor(white: 1, alpha: 0.7)
        mondo.layer.masksToBounds = true
        mondo.layer.cornerRadius = 10
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
