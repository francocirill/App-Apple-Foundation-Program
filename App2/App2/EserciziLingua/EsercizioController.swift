//
//  EsercizioController.swift
//  App2
//
//  Created by Franco Cirillo on 20/03/21.
//

import UIKit

class EsercizioController: UIViewController {
    
    var esercizio:String=""
    var secondsRemaining:Int=6

    @IBOutlet var nomeEsercizio: UILabel!
    @IBOutlet weak var descrizione: UILabel!
    @IBOutlet weak var immagine: UIImageView!
    @IBOutlet weak var tempo: UILabel!
    @IBOutlet weak var timer: UIButton!
    @IBAction func avviaTimer(_ sender: UIButton) {
        timer.isHidden=true
        self.tempo.text=("\(self.secondsRemaining) secondi")
        secondsRemaining-=1
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (Timer) in
                if self.secondsRemaining > 0 {
                    self.tempo.text=("\(self.secondsRemaining) secondi")
                    self.secondsRemaining -= 1
                } else {
                    Timer.invalidate()
                    self.tempo.text=("Hai terminato")
                    //aggiorna statistiche
                }
            }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        nomeEsercizio.text=esercizio
//        descrizione.text="L’esercizio prevede di toccare il naso con la punta della lingua. È una cosa che non tutti riescono a fare, ma l’importante è che comunque la lingua sia tesa il più possibile verso il naso."
        descrizione.text = NSLocalizedString("\(esercizio)", comment: "")
        descrizione.sizeToFit()
        immagine.image=UIImage(named: esercizio)
        
        
        
        
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
