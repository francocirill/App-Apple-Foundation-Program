//
//  SelectWorldViewController.swift
//  App2
//
//  Created by Stefano D’Amato on 12/04/21.
//

import UIKit

class SelectWorldViewController: UIViewController {

    @IBOutlet weak var startsNumber: UILabel!
    @IBOutlet weak var name: UILabel!
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
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    @IBOutlet weak var label5: UILabel!
    
    var user : UserProfile!
    
    
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
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "sfondo_mondi.PNG.png")?.draw(in: self.view.bounds)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image)
        
        label1.layer.cornerRadius = 18
        label1.layer.borderWidth = 2
        label1.layer.masksToBounds = true
        label1.layer.borderColor = UIColor.white.cgColor
        
        label2.layer.cornerRadius = 18
        label2.layer.borderWidth = 2
        label2.layer.masksToBounds = true
        label2.layer.borderColor = UIColor.white.cgColor
        
        label3.layer.cornerRadius = 18
        label3.layer.borderWidth = 2
        label3.layer.masksToBounds = true
        label3.layer.borderColor = UIColor.white.cgColor
        
        label4.layer.cornerRadius = 18
        label4.layer.borderWidth = 2
        label4.layer.masksToBounds = true
        label4.layer.borderColor = UIColor.white.cgColor
        
        label5.layer.cornerRadius = 18
        label5.layer.borderWidth = 2
        label5.layer.masksToBounds = true
        label5.layer.borderColor = UIColor.white.cgColor
        
        
        if PersistenceManager.fetchData().count == 0 {let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "TutorialViewController")
            //self.newViewController?.isModalInPresentation = true
            self.navigationController?.pushViewController(newViewController, animated: true)
        }
        
        
        world1Image.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        world1Image.layer.shadowOffset = CGSize(width: 6.0, height: 6.0)
        world1Image.layer.shadowOpacity = 1.0
        world1Image.layer.shadowRadius = 2.0
        world1Image.layer.cornerRadius = 4.0
        world1Image.layer.masksToBounds = false
        
        world2Image.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        world2Image.layer.shadowOffset = CGSize(width: 6.0, height: 6.0)
        world2Image.layer.shadowOpacity = 1.0
        world2Image.layer.shadowRadius = 2.0
        world2Image.layer.cornerRadius = 4.0
        world2Image.layer.masksToBounds = false
        
        world3Image.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        world3Image.layer.shadowOffset = CGSize(width: 6.0, height: 6.0)
        world3Image.layer.shadowOpacity = 1.0
        world3Image.layer.shadowRadius = 2.0
        world3Image.layer.cornerRadius = 4.0
        world3Image.layer.masksToBounds = false
        
        world4Image.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        world4Image.layer.shadowOffset = CGSize(width: 6.0, height: 6.0)
        world4Image.layer.shadowOpacity = 1.0
        world4Image.layer.shadowRadius = 2.0
        world4Image.layer.cornerRadius = 4.0
        world4Image.layer.masksToBounds = false
        
        world5Image.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        world5Image.layer.shadowOffset = CGSize(width: 6.0, height: 6.0)
        world5Image.layer.shadowOpacity = 1.0
        world5Image.layer.shadowRadius = 2.0
        world5Image.layer.cornerRadius = 4.0
        world5Image.layer.masksToBounds = false
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isTranslucent = true
        
        navigationController?.setNavigationBarHidden(true, animated: animated)

        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "green3.jpg")!)
        
        print("VIEW WILL APPEAR")
        if PersistenceManager.fetchData().count != 0 {
            var user = PersistenceManager.fetchData()[0]
            startsNumber.text = String(user.points)
            avatar1.image = UIImage(named: user.avatar!)
            avatar2.image = UIImage(named: user.avatar!)
            avatar3.image = UIImage(named: user.avatar!)
            avatar4.image = UIImage(named: user.avatar!)
            avatar5.image = UIImage(named: user.avatar!)
            print(user.lastLevel+1)
            switch user.lastLevel+1 {
            case  1..<9:
                
                avatar2.isHidden = true
                world2Image.isEnabled = false
                avatar3.isHidden = true
                world3Image.isEnabled = false
                avatar4.isHidden = true
                world4Image.isEnabled = false
                avatar5.isHidden = true
                world5Image.isEnabled = false
                
            case  9..<17:
                avatar2.isHidden = false
                world2Image.isEnabled = true
                
                avatar1.isHidden = true
                avatar3.isHidden = true
                world3Image.isEnabled = false
                avatar4.isHidden = true
                world4Image.isEnabled = false
                avatar5.isHidden = true
                world5Image.isEnabled = false
            case  17..<25:
                avatar3.isHidden = false
                world3Image.isEnabled = true
                
                avatar1.isHidden = true
                avatar2.isHidden = true
                avatar4.isHidden = true
                world4Image.isEnabled = false
                avatar5.isHidden = true
                world5Image.isEnabled = false
            case  25..<33:
                avatar4.isHidden = false
                world4Image.isEnabled = true
                
                avatar1.isHidden = true
                avatar2.isHidden = true
                avatar3.isHidden = true
                avatar5.isHidden = true
                world5Image.isEnabled = false
            case  33..<41:
                avatar5.isHidden = false
                world5Image.isEnabled = true
                
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
            user = PersistenceManager.fetchData()[0]
            name.text = "\(user.name!)"
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
            let dstView = segue.destination as! LevelsTableViewController
            dstView.worldNumber = 1
        case "world2":
            let dstView = segue.destination as! LevelsTableViewController
            dstView.worldNumber = 2
        case "world3":
            let dstView = segue.destination as! LevelsTableViewController
            dstView.worldNumber = 3
        case "world4":
            let dstView = segue.destination as! LevelsTableViewController
            dstView.worldNumber = 4
        case "world5":
            let dstView = segue.destination as! LevelsTableViewController
            dstView.worldNumber = 5
        default:
            print(#function)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func unwind( _ seg: UIStoryboardSegue) {
    }
}
