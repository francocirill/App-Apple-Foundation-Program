//
//  LivelloSuperatoViewController.swift
//  App2
//
//  Created by Marco Venere on 16/02/21.
//

import UIKit

class LivelloSuperatoViewController: UIViewController {
    @IBOutlet weak var stella2: UIImageView!
    @IBOutlet weak var stella3: UIImageView!
    var numero : Int = 0
    @IBAction func avanti(_ sender: Any) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "SpeechDetectionViewController") as! SpeechDetectionViewController
            let cont = newViewController
            cont.livello += 1
            //self.newViewController?.isModalInPresentation = true
            self.navigationController?.pushViewController(newViewController, animated: true)
        })
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.hidesBackButton = true;
        self.navigationController?.navigationItem.backBarButtonItem?.isEnabled = false;
        self.navigationController!.interactivePopGestureRecognizer!.isEnabled = false;

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.title = "Livello superato!"
        switch numero {
        case 3:
            stella3.image! = UIImage(named: "stella piena")!
            fallthrough
        case 2:
            stella2.image! = UIImage(named: "stella piena")!
        default:
            stella2.image! = UIImage(named: "stella_vuota")!
            stella3.image! = UIImage(named: "stella_vuota")!
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
