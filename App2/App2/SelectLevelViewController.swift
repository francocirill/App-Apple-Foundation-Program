//
//  SelectLevelViewController.swift
//  App2
//
//  Created by Stefano D’Amato on 12/04/21.
//

import UIKit

class SelectLevelViewController: UIViewController {

    var worldNumber : Int!
    @IBOutlet weak var avatar1: UIImageView!
    @IBOutlet weak var avatar2: UIImageView!
    @IBOutlet weak var avatar3: UIImageView!
    @IBOutlet weak var avatar4: UIImageView!
    @IBOutlet weak var avatar5: UIImageView!
    @IBOutlet weak var level1Image: UIButton!
    @IBOutlet weak var level2Image: UIButton!
    @IBOutlet weak var level3Image: UIButton!
    @IBOutlet weak var level4Image: UIButton!
    @IBOutlet weak var level5Image: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIGraphicsBeginImageContext(self.view.frame.size)
        UIImage(named: "green3.jpg")?.draw(in: self.view.bounds)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
        self.view.backgroundColor = UIColor(patternImage: image)
        switch worldNumber {
        case 1:
            level1Image.setTitle("Livello 1", for: .normal)
            level2Image.setTitle("Livello 2", for: .normal)
            level3Image.setTitle("Livello 3", for: .normal)
            level4Image.setTitle("Livello 4", for: .normal)
            level5Image.setTitle("Livello 5", for: .normal)
        case 2:
            level1Image.setTitle("Livello 6", for: .normal)
            level2Image.setTitle("Livello 7", for: .normal)
            level3Image.setTitle("Livello 8", for: .normal)
            level4Image.setTitle("Livello 9", for: .normal)
            level5Image.setTitle("Livello 10", for: .normal)
        case 3:
            level1Image.setTitle("Livello 11", for: .normal)
            level2Image.setTitle("Livello 12", for: .normal)
            level3Image.setTitle("Livello 13", for: .normal)
            level4Image.setTitle("Livello 14", for: .normal)
            level5Image.setTitle("Livello 15", for: .normal)
        case 4:
            level1Image.setTitle("Livello 16", for: .normal)
            level2Image.setTitle("Livello 17", for: .normal)
            level3Image.setTitle("Livello 18", for: .normal)
            level4Image.setTitle("Livello 19", for: .normal)
            level5Image.setTitle("Livello 20", for: .normal)
        case 5:
            level1Image.setTitle("Livello 21", for: .normal)
            level2Image.setTitle("Livello 22", for: .normal)
            level3Image.setTitle("Livello 23", for: .normal)
            level4Image.setTitle("Livello 24", for: .normal)
            level5Image.setTitle("Livello 25", for: .normal)
        default:
            print(#function)
        }
        
        if PersistenceManager.fetchData().count != 0 {
            var user = PersistenceManager.fetchData()[0]
            print("select level last level: \(user.lastLevel)")
            print("select level world choosed: \(worldNumber)")
            avatar1.image = UIImage(named: user.avatar!)
            avatar2.image = UIImage(named: user.avatar!)
            avatar3.image = UIImage(named: user.avatar!)
            avatar4.image = UIImage(named: user.avatar!)
            avatar5.image = UIImage(named: user.avatar!)
            switch (user.lastLevel+1)%5 {
            case  1:
                if(user.lastLevel+1 > worldNumber*5){
                    avatar1.isHidden = true
                }
                avatar2.isHidden = true
                avatar3.isHidden = true
                avatar4.isHidden = true
                avatar5.isHidden = true
            case  2:
                if(user.lastLevel+1 > worldNumber*5){
                    avatar2.isHidden = true
                }
                avatar1.isHidden = true
                avatar3.isHidden = true
                avatar4.isHidden = true
                avatar5.isHidden = true
            case  3:
                if(user.lastLevel+1 > worldNumber*5){
                    avatar3.isHidden = true
                }
                avatar1.isHidden = true
                avatar2.isHidden = true
                avatar4.isHidden = true
                avatar5.isHidden = true
            case  4:
                if(user.lastLevel+1 > worldNumber*10){
                    avatar4.isHidden = true
                }
                avatar1.isHidden = true
                avatar2.isHidden = true
                avatar3.isHidden = true
                avatar5.isHidden = true
            case  0:
                if(user.lastLevel+1 > worldNumber*10){
                    avatar5.isHidden = true
                }
                avatar1.isHidden = true
                avatar2.isHidden = true
                avatar3.isHidden = true
                avatar4.isHidden = true
            default:
                print(#function)
            }
            
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation*/
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        switch segue.identifier {
        case "level1":
            let dstView = segue.destination as! MondoViewController
            dstView.worldNumber = worldNumber
            dstView.levelNumber = 1 + (worldNumber-1)*5
        case "level2":
            let dstView = segue.destination as! MondoViewController
            dstView.worldNumber = worldNumber
            dstView.levelNumber = 2 + (worldNumber-1)*5
        case "level3":
            let dstView = segue.destination as! MondoViewController
            dstView.worldNumber = worldNumber
            dstView.levelNumber = 3 + (worldNumber-1)*5
        case "level4":
            let dstView = segue.destination as! MondoViewController
            dstView.worldNumber = worldNumber
            dstView.levelNumber = 4 + (worldNumber-1)*5
        case "level5":
            let dstView = segue.destination as! MondoViewController
            dstView.worldNumber = worldNumber
            dstView.levelNumber = 5 + (worldNumber-1)*5
        default:
            print("error")
        }
    }

    

}
