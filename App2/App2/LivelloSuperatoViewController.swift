//
//  LivelloSuperatoViewController.swift
//  App2
//
//  Created by Marco Venere on 16/02/21.
//

import UIKit
import AVFoundation

class LivelloSuperatoViewController: UIViewController {
    @IBOutlet weak var stella2: UIImageView!
    @IBOutlet weak var stella3: UIImageView!
    
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var avatarImage: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    var player: AVAudioPlayer?
    var numero : Int = 0
    var user : UserProfile!
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
        user = PersistenceManager.fetchData()[0]
        avatarImage.setImage(UIImage(named: user.avatar!), for: .normal)
        nameLabel.text = "\(user.name!)!"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.navigationController?.title = "Livello superato!"
        switch numero {
        case 3:
            stella3.image! = UIImage(named: "stella piena")!
            stella2.image! = UIImage(named: "stella piena")!
            tipLabel.text = "Ottimo lavoro!"
        case 2:
            stella2.image! = UIImage(named: "stella piena")!
            tipLabel.text = "Ci sei quasi!"
        default:
            stella2.image! = UIImage(named: "stella_vuota")!
            stella3.image! = UIImage(named: "stella_vuota")!
            tipLabel.text = "Metticela tutta!"
        }
        guard let url = Bundle.main.url(forResource: "mixkit-game-level-completed-2059", withExtension: "wav") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            self.player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)

            /* iOS 10 and earlier require the following line:
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

            guard let player = self.player else { return }

            player.play()

        } catch let error {
            print(error.localizedDescription)
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
