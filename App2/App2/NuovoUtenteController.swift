//
//  NuovoUtenteController.swift
//  App2
//
//  Created by Marco Venere on 12/02/21.
//

import UIKit

class NuovoUtenteController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var pictureSwitch: UISwitch!
    @IBOutlet weak var speechSwitch: UISwitch!
    
   
    @IBAction func crea(_ sender: Any) {
    }
    
    var userProfile : UserProfile?
    
    @IBOutlet weak var avatarbutton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        // Do any additional setup after loading the view.
        userProfile = UserProfile.init(context: context)
        userProfile?.avatar=""
        appDelegate.saveContext()
        //userProfile!.setValue("default", forKey: "avatar")
        //userProfile.avatar = "default"
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        if userProfile?.avatar != "" {
            avatarbutton.setImage(UIImage(named: userProfile!.avatar!) , for: .normal)
        }
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        switch segue.identifier {
        case "showAvatar" :
            let dstView = segue.destination as! CollectionViewController
            dstView.user = userProfile
        default: print(#function)
            
        }


    }
    

}

