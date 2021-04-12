//
//  SelectWorldViewController.swift
//  App2
//
//  Created by Stefano D’Amato on 12/04/21.
//

import UIKit

class SelectWorldViewController: UIViewController {

    @IBOutlet weak var startsNumber: UILabel!
    @IBOutlet weak var avatar5: UIImageView!
    @IBOutlet weak var avatar4: UIImageView!
    @IBOutlet weak var avatar3: UIImageView!
    @IBOutlet weak var avatar2: UIImageView!
    @IBOutlet weak var avatar1: UIImageView!
    @IBOutlet weak var world5Image: UIButton!
    @IBOutlet weak var world4Image: UIButton!
    @IBOutlet weak var world3Image: UIButton!
    @IBOutlet weak var world2Image: UIButton!
    @IBOutlet weak var world1Image: UIButton!
    
    @IBAction func wolrd1(_ sender: Any) {
    }
    
    @IBAction func wolrd2(_ sender: Any) {
    }
    @IBAction func world3(_ sender: Any) {
    }
    @IBAction func world4(_ sender: Any) {
    }
    @IBAction func world5(_ sender: Any) {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "space.jpeg")!)
        if PersistenceManager.fetchData().count != 0 {
            var user = PersistenceManager.fetchData()[0]
            print(user.lastLevel)
            startsNumber.text = String(user.points)
            avatar1.image = UIImage(named: user.avatar!)
            avatar2.image = UIImage(named: user.avatar!)
            avatar3.image = UIImage(named: user.avatar!)
            avatar4.image = UIImage(named: user.avatar!)
            avatar5.image = UIImage(named: user.avatar!)
            switch user.lastLevel+1 {
            case  1..<11:
                avatar2.isHidden = true
                avatar3.isHidden = true
                avatar4.isHidden = true
                avatar5.isHidden = true
                
            case  11..<21:
                avatar1.isHidden = true
                avatar3.isHidden = true
                avatar4.isHidden = true
                avatar5.isHidden = true
            case  21..<31:
                avatar1.isHidden = true
                avatar2.isHidden = true
                avatar4.isHidden = true
                avatar5.isHidden = true
            case  31..<41:
                avatar1.isHidden = true
                avatar2.isHidden = true
                avatar3.isHidden = true
                avatar5.isHidden = true
            case  41..<51:
                avatar1.isHidden = true
                avatar2.isHidden = true
                avatar3.isHidden = true
                avatar4.isHidden = true
            default:
                avatar1.isHidden = true
                avatar2.isHidden = true
                avatar3.isHidden = true
                avatar4.isHidden = true
                avatar5.isHidden = true
            }
            
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
 */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        switch segue.identifier {
        case "world1":
            let dstView = segue.destination as! SelectLevelViewController
            dstView.worldNumber = 1
        case "world2":
            let dstView = segue.destination as! SelectLevelViewController
            dstView.worldNumber = 2
        case "world3":
            let dstView = segue.destination as! SelectLevelViewController
            dstView.worldNumber = 3
        case "world4":
            let dstView = segue.destination as! SelectLevelViewController
            dstView.worldNumber = 4
        case "world5":
            let dstView = segue.destination as! SelectLevelViewController
            dstView.worldNumber = 5
        default:
            print(#function)
        }
    }
    

}
