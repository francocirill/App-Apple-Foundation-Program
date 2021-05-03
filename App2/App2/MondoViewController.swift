//
//  MondoViewController.swift
//  App2
//
//  Created by Stefano D’Amato on 07/04/21.
//

import UIKit

class MondoViewController: UIViewController {

    @IBOutlet weak var mondo: UILabel!
    var worldNumber : Int = 1
    var levelNumber : Int = 1
            
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isTranslucent = true
        
        switch worldNumber {
        case 1:
            mondo.text="Bosco delle T"
            UIGraphicsBeginImageContext(self.view.frame.size)
            UIImage(named: "mondo1.jpg")?.draw(in: self.view.bounds)
            let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
                UIGraphicsEndImageContext()
            self.view.backgroundColor = UIColor(patternImage: image)
            mondo.textColor = UIColor.white
        case 2:
            mondo.text="Isola delle R"
            UIGraphicsBeginImageContext(self.view.frame.size)
            UIImage(named: "mondo2.jpg")?.draw(in: self.view.bounds)
            let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
                UIGraphicsEndImageContext()
            self.view.backgroundColor = UIColor(patternImage: image)
            mondo.textColor = UIColor.white
        case 3:
            mondo.text="Precipizio delle S"
            UIGraphicsBeginImageContext(self.view.frame.size)
            UIImage(named: "mondo3.jpg")?.draw(in: self.view.bounds)
            let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
                UIGraphicsEndImageContext()
            self.view.backgroundColor = UIColor(patternImage: image)
            mondo.textColor = UIColor.red
        case 4:
            mondo.text="Abisso delle GN"
            UIGraphicsBeginImageContext(self.view.frame.size)
            UIImage(named: "mondo4.jpg")?.draw(in: self.view.bounds)
            let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
                UIGraphicsEndImageContext()
            self.view.backgroundColor = UIColor(patternImage: image)
            mondo.textColor = UIColor.white
        case 5:
            mondo.text="Foresta delle SC"
            UIGraphicsBeginImageContext(self.view.frame.size)
            UIImage(named: "mondo5.jpg")?.draw(in: self.view.bounds)
            let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
                UIGraphicsEndImageContext()
            self.view.backgroundColor = UIColor(patternImage: image)
            mondo.textColor = UIColor.red
        default:
            mondo.text="Other"
        }
        

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
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.navigationBar.isTranslucent = true
        if PersistenceManager.fetchData().count != 0 {
            
//            var user = PersistenceManager.fetchData()[0]
//            switch user.lastLevel+1 {
//            case  1..<11:
//                mondo.text="Bosco delle T"
//                self.view.backgroundColor = UIColor(patternImage: UIImage(named: "mondo1.jpg")!)
//            case  11..<21:
//                mondo.text="Isola delle R"
//                self.view.backgroundColor = UIColor(patternImage: UIImage(named: "mondo2.jpg")!)
//            case  21..<31:
//                mondo.text="Precipizio delle S"
//                self.view.backgroundColor = UIColor(patternImage: UIImage(named: "mondo3.jpg")!)
//            case  31..<41:
//                mondo.text="Abisso delle GN"
//                self.view.backgroundColor = UIColor(patternImage: UIImage(named: "mondo4.jpg")!)
//            case  41..<51:
//                mondo.text="Foresta delle SC"
//                self.view.backgroundColor = UIColor(patternImage: UIImage(named: "mondo5.jpg")!)
//            default:
//                mondo.text="Other"
//            }
            
        }
//        mondo.backgroundColor = UIColor(white: 1, alpha: 0.7)
//        mondo.layer.masksToBounds = true
//        mondo.layer.cornerRadius = 10
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation*/
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let dstView = segue.destination as! SpeechDetectionViewController
        dstView.worldNumber = worldNumber
        dstView.levelNumber = levelNumber
    }
    

}
