//
//  SpeechDetectionViewController.swift
//  App2
//
//  Created by Franco Cirillo on 15/02/21.
//

import UIKit
import Speech
import AVFoundation
import HealthKit

class SpeechDetectionViewController: UIViewController, SFSpeechRecognizerDelegate{
    //Processa lo stream audio
  
    let healthStore = HKHealthStore()
    
    var worldNumber : Int = 1
    var levelNumber : Int = 1
    
    var player: AVAudioPlayer?
    
    @IBAction func backHome2(_ sender: UIButton) {
        performSegue(withIdentifier: "backHomeFromLevel", sender: self)
    }
    /*@IBAction func backHome(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "backHomeFromLevel", sender: self)
    }*/
    @IBOutlet weak var navigation: UINavigationItem!
    let audioEngine = AVAudioEngine()
    //Riconosce le parole
    //let speechRecognizer: SFSpeechRecognizer? = SFSpeechRecognizer()
    //Utile per cambiare lingua
    @IBOutlet weak var microphone: UIButton!
    let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "it-IT"))
    //Riconoscimento in tempo reale
    var user : UserProfile! = nil
    var request = SFSpeechAudioBufferRecognitionRequest()
    var isRecording = false
    //Gestire il riconoscimento
    var recognitionTask: SFSpeechRecognitionTask?
    @IBOutlet weak var frase: UILabel!
    @IBOutlet weak var ripetiLabel: UILabel!
    @IBOutlet weak var ripeti: UIButton!
    @IBOutlet weak var image: UIImageView!
    @IBAction func ripetiTapped(_ sender: UIButton) {
        DispatchQueue.main.async {
            self.speak(self.frase.text ?? "errore")
        }
    }
    var newViewController : UIViewController?
    
    var tentativi = 0
    var livello : Int!
    @IBAction func pronuncia(_ sender: Any) {
        if isRecording {

                request.endAudio() // Added line to mark end of recording
                audioEngine.stop()

              let node = audioEngine.inputNode
              node.removeTap(onBus: 0)
              //  }
                recognitionTask?.cancel()
            
            microphone.setImage(UIImage(named: "mic_spento"), for: .normal)
                isRecording = false
                //startButton.backgroundColor = UIColor.gray

            } else {
                self.pronunciata.textColor = UIColor(named: "Color1")
                var audioSession = AVAudioSession.sharedInstance();
                do {
                    try audioSession.setCategory (AVAudioSession.Category.playAndRecord, options: AVAudioSession.CategoryOptions.mixWithOthers);
                    try  audioSession.setActive (true);
                
                }
                catch let error as NSError {
                    return print(error)
                }
                self.recordAndRecognizeSpeech()
                isRecording = true
                microphone.setImage(UIImage(named: "mic_acceso"), for: .normal)
               // startButton.backgroundColor = UIColor.red
            }
    }
    
    
    
    @IBOutlet weak var ripetiButton: UIButton!
    
    //text to speech
    @IBOutlet weak var pronunciata: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.navigationItem.hidesBackButton = true
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        
        }
        catch let error as NSError {
            return print(error)
        }
        
        pronunciata.layer.cornerRadius = 18
        pronunciata.layer.borderWidth = 2
        pronunciata.layer.masksToBounds = true
        pronunciata.layer.borderColor = UIColor.white.cgColor
        
        image.layer.shadowColor = UIColor.black.cgColor
        image.layer.shadowOpacity = 0.8
        image.layer.shadowRadius = 13.0
        image.clipsToBounds = false
        image.layer.masksToBounds = false
        
        microphone.layer.shadowColor = UIColor.black.cgColor
        microphone.layer.shadowOpacity = 0.8
        microphone.layer.shadowRadius = 13.0
        microphone.clipsToBounds = false
        microphone.layer.masksToBounds = false
        
        authorizeHealthkit()
//        microphone.isUserInteractionEnabled = true
//        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SpeechDetectionViewController.addPulse))
//        tapGestureRecognizer.numberOfTouchesRequired = 1
//        microphone.addGestureRecognizer(tapGestureRecognizer)
           
    }
    @objc func pulseRipetiButton() {
        if PersistenceManager.fetchData()[0].outLoud {
            let pulse = Pulsing(numberOfPulses: 2, radius: 50, position: ripetiButton.center)
            pulse.animationDuration = 0.8
            pulse.backgroundColor = UIColor(named: "Color5")?.cgColor
            
            self.view.layer.insertSublayer(pulse, below: ripetiButton.layer)
        }
    }
    
    @objc func addPulse(){
        let pulse = Pulsing(numberOfPulses: 1, radius: 110, position: microphone.center)
        pulse.animationDuration = 0.8
        pulse.backgroundColor = UIColor(named: "Color3")?.cgColor
        
        self.view.layer.insertSublayer(pulse, below: microphone.layer)
        //ff
    }
    
    func speak(_ msg : String) {
//        let audioSession = AVAudioSession.sharedInstance()
//        do {
//
//                try audioSession.setCategory(.playAndRecord, options: .defaultToSpeaker)
//                  try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
//        }catch let error as NSError{
//            return print(error)
//        }
        let utterance = AVSpeechUtterance(string: msg)
       

        utterance.voice = AVSpeechSynthesisVoice(language: "it-IT")
        utterance.volume = 1.0
        //utterance.rate = 0.1 velocità di espressione
        
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        
        livello = levelNumber + (worldNumber-1)*8
        user = PersistenceManager.fetchData()[0]
        image.isHidden = !user.showPics
        ripetiButton.isHidden = !user.outLoud
        self.navigation!.title = "Livello \(livello!)"
        self.image.image = UIImage(named: "level\(livello!)")
        frase.text = NSLocalizedString("level\(livello!)", comment: "")
    
        Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(self.pulseRipetiButton), userInfo: nil, repeats: true)
        
        switch worldNumber {
        case 1:
            UIGraphicsBeginImageContext(self.view.frame.size)
            UIImage(named: "mondo1.jpg")?.draw(in: self.view.bounds)
            let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
                UIGraphicsEndImageContext()
            self.view.backgroundColor = UIColor(patternImage: image).withAlphaComponent(0.85)
            frase.textColor = UIColor.white
            ripetiLabel.textColor = UIColor.white
        case 2:
            UIGraphicsBeginImageContext(self.view.frame.size)
            UIImage(named: "mondo2.jpg")?.draw(in: self.view.bounds)
            let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
                UIGraphicsEndImageContext()
            self.view.backgroundColor = UIColor(patternImage: image).withAlphaComponent(0.85)
            frase.textColor = UIColor.white
            ripetiLabel.textColor = UIColor.white
        case 3:
            UIGraphicsBeginImageContext(self.view.frame.size)
            UIImage(named: "mondo3.jpg")?.draw(in: self.view.bounds)
            let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
                UIGraphicsEndImageContext()
            self.view.backgroundColor = UIColor(patternImage: image).withAlphaComponent(0.85)
            frase.textColor = UIColor.red
            ripetiLabel.textColor = UIColor.red
        case 4:
            UIGraphicsBeginImageContext(self.view.frame.size)
            UIImage(named: "mondo4.jpg")?.draw(in: self.view.bounds)
            let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
                UIGraphicsEndImageContext()
            self.view.backgroundColor = UIColor(patternImage: image).withAlphaComponent(0.85)
            frase.textColor = UIColor.white
            ripetiLabel.textColor = UIColor.white
        case 5:
            UIGraphicsBeginImageContext(self.view.frame.size)
            UIImage(named: "mondo5.jpg")?.draw(in: self.view.bounds)
            let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
                UIGraphicsEndImageContext()
            self.view.backgroundColor = UIColor(patternImage: image).withAlphaComponent(0.85)
            frase.textColor = UIColor.red
            ripetiLabel.textColor = UIColor.red
        default:
            self.view.backgroundColor = UIColor.white
        }

         

    }
    
    override func viewDidAppear(_ animated: Bool) {
        speak(frase.text!)
    }
    
    func recordAndRecognizeSpeech(){
        
        let node = audioEngine.inputNode //else { return }
        let recordingFormat = node.outputFormat(forBus: 0)
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
            self.request.append(buffer)
        }
        audioEngine.prepare()

//        guard let myRecognizer = SFSpeechRecognizer() else {
//            return
//        }
        request = SFSpeechAudioBufferRecognitionRequest()
        
        do{
                try audioEngine.start()
        }catch {
            return print(error)
        }
        
        
        /*recognitionTask = speechRecognizer?.recognitionTask(with: request, resultHandler: { (result, error) in
                var isFinal = false

            
            self.pronunciata.text = (result?.transcriptions[0].segments[0].substring)!.lowercased()
            print(self.num)
            if (result?.transcriptions[0].segments.count)! == 1 {
                
                audioEngine.stop()
                DispatchQueue.main.async { [unowned self] in
                        guard let task = recognitionTask else {
                            fatalError("Error")
                        }
                        task.cancel()
                        task.finish()
                    }
                self.num = 0
                
                if self.frase.text?.lowercased() == self.pronunciata.text {
                    DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5), execute: {
                            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                           let newViewController = storyBoard.instantiateViewController(withIdentifier: "LivelloSuperatoViewController") as! LivelloSuperatoViewController
                           self.present(newViewController, animated: true, completion: nil)
                        })
                    }
                    
//                if let result = result, result.isFinal {
//                    print("Result: \(result.bestTranscription.formattedString)")
//                    isFinal = result.isFinal
//                    //per passare a schermata risultato
//                    if self.frase.text == self.pronunciata.text {
//                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
//                            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                            let newViewController = storyBoard.instantiateViewController(withIdentifier: "LivelloSuperatoViewController") as! LivelloSuperatoViewController
//                            self.present(newViewController, animated: true, completion: nil)
//                        })
//                    }
//                }
//
//                if error != nil || isFinal {
                   // self.recognitionRequest = nil
//                    self.recognitionTask = nil
                }
        })*/
//        let audioSession = AVAudioSession.sharedInstance()
//        do {
//
//                try audioSession.setCategory(.playAndRecord, options: .defaultToSpeaker)
//                  try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
//        }catch let error as NSError{
//            return print(error)
//        }
        recognitionTask = speechRecognizer?.recognitionTask(with: request, resultHandler: { (result, error) in
                if result != nil { // check to see if result is empty (i.e. no speech found)
                    if let result = result {
                        self.addPulse()
                        self.pronunciata.text = (result.transcriptions[0].segments[0].substring).lowercased()
                        //print(self.num)
                        
                        if (result.transcriptions[0].segments.count) == 1 {
                            self.tentativi += 1
                           // print(String(result.transcriptions[0].segments[0].confidence * 100) + "%" )
                            
                            self.audioEngine.stop()
                            DispatchQueue.main.async { [unowned self] in
                                    guard let task = recognitionTask else {
                                        fatalError("Error")
                                    }
                                    task.cancel()
                                    task.finish()
                                }
                            //self.num = 0
                            
                            if self.frase.text?.lowercased() == self.pronunciata.text {
                                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: { [self] in
                                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                    /*self.newViewController = storyBoard.instantiateViewController(withIdentifier: "LivelloSuperatoViewController") as! LivelloSuperatoViewController*/
                                    
                                    let new = storyboard?.instantiateViewController(withIdentifier: "LivelloSuperatoViewController") as! LivelloSuperatoViewController
                                    
                                    new.levelNumber = self.levelNumber + (self.worldNumber-1)*8
                                    //self.newViewController?.isModalInPresentation = true
                                    if(PersistenceManager.fetchData()[0].lastLevel+1 == ((self.worldNumber-1)*8)+self.levelNumber){
                                        PersistenceManager.fetchData()[0].lastLevel += 1
                                    }
                                    let cont = new as! LivelloSuperatoViewController
                                    switch self.tentativi {
                                    case 1:
                                        cont.numero = 3
                                        switch StarsManager.fetchData()[0].value(forKey: "level\(self.levelNumber+(self.worldNumber-1)*8)") as! Int16{
                                        case 0:
                                            PersistenceManager.fetchData()[0].points += 3
                                        case 1:
                                            PersistenceManager.fetchData()[0].points += 2
                                        case 2:
                                            PersistenceManager.fetchData()[0].points += 1
                                        default:
                                            print(#function)
                                        }
                                        StarsManager.fetchData()[0].setValue(3, forKeyPath: "level\(self.levelNumber+(self.worldNumber-1)*8)")
                                        
//                                        switch self.levelNumber-1 {
//                                        case 0:
//                                            cont.numero = 3
//                                            PersistenceManager.fetchData()[0].points +=  3
//                                            StarsManager.fetchData()[0].level1 = 3
//                                        case 1:
//                                            cont.numero = 3
//                                            PersistenceManager.fetchData()[0].points +=  3
//                                            StarsManager.fetchData()[0].level2 = 3
//                                        case 2:
//                                            cont.numero = 3
//                                            PersistenceManager.fetchData()[0].points +=  3
//                                            StarsManager.fetchData()[0].level3 = 3
//                                        case 3:
//                                            cont.numero = 3
//                                            PersistenceManager.fetchData()[0].points +=  3
//                                            StarsManager.fetchData()[0].level4 = 3
//                                        case 4:
//                                            cont.numero = 3
//                                            PersistenceManager.fetchData()[0].points +=  3
//                                            StarsManager.fetchData()[0].level5 = 3
//                                        case 5:
//                                            cont.numero = 3
//                                            PersistenceManager.fetchData()[0].points +=  3
//                                            StarsManager.fetchData()[0].level6 = 3
//                                        case 6:
//                                            cont.numero = 3
//                                            PersistenceManager.fetchData()[0].points +=  3
//                                            StarsManager.fetchData()[0].level7 = 3
//                                        case 7:
//                                            cont.numero = 3
//                                            PersistenceManager.fetchData()[0].points +=  3
//                                            StarsManager.fetchData()[0].level8 = 3
//                                        case 8:
//                                            cont.numero = 3
//                                            PersistenceManager.fetchData()[0].points +=  3
//                                            StarsManager.fetchData()[0].level9 = 3
//                                        case 9:
//                                            cont.numero = 3
//                                            PersistenceManager.fetchData()[0].points +=  3
//                                            StarsManager.fetchData()[0].level10 = 3
//                                        default:
//                                            print(#function)
//                                        }
                                        
                                    case 2, 3:
                                        cont.numero = 2
                                        switch StarsManager.fetchData()[0].value(forKey: "level\(self.levelNumber+(self.worldNumber-1)*8)") as! Int16{
                                        case 0:
                                            PersistenceManager.fetchData()[0].points += 2
                                            StarsManager.fetchData()[0].setValue(2, forKeyPath: "level\(self.levelNumber+(self.worldNumber-1)*8)")
                                        case 1:
                                            PersistenceManager.fetchData()[0].points += 1
                                            StarsManager.fetchData()[0].setValue(2, forKeyPath: "level\(self.levelNumber+(self.worldNumber-1)*8)")
                                        default:
                                            print(#function)
                                        }
                                        
//                                        switch self.levelNumber-1 {
//                                        case 0:
//                                            cont.numero = 2
//                                            PersistenceManager.fetchData()[0].points +=  2
//                                            StarsManager.fetchData()[0].setValue(2, forKeyPath: "level\(1)")
//                                        case 1:
//                                            cont.numero = 2
//                                            PersistenceManager.fetchData()[0].points +=  2
//                                            StarsManager.fetchData()[0].level2 = 2
//                                        case 2:
//                                            cont.numero = 2
//                                            PersistenceManager.fetchData()[0].points +=  2
//                                            StarsManager.fetchData()[0].level3 = 2
//                                        case 3:
//                                            cont.numero = 2
//                                            PersistenceManager.fetchData()[0].points +=  2
//                                            StarsManager.fetchData()[0].level4 = 2
//                                        case 4:
//                                            cont.numero = 2
//                                            PersistenceManager.fetchData()[0].points +=  2
//                                            StarsManager.fetchData()[0].level5 = 2
//                                        case 5:
//                                            cont.numero = 2
//                                            PersistenceManager.fetchData()[0].points +=  2
//                                            StarsManager.fetchData()[0].level6 = 2
//                                        case 6:
//                                            cont.numero = 2
//                                            PersistenceManager.fetchData()[0].points +=  2
//                                            StarsManager.fetchData()[0].level7 = 2
//                                        case 7:
//                                            cont.numero = 2
//                                            PersistenceManager.fetchData()[0].points +=  2
//                                            StarsManager.fetchData()[0].level8 = 2
//                                        case 8:
//                                            cont.numero = 2
//                                            PersistenceManager.fetchData()[0].points +=  2
//                                            StarsManager.fetchData()[0].level9 = 2
//                                        case 9:
//                                            cont.numero = 2
//                                            PersistenceManager.fetchData()[0].points +=  2
//                                            StarsManager.fetchData()[0].level10 = 2
//                                        default:
//                                            print(#function)
//                                        }
                                    default:
                                        cont.numero = 1
                                        switch StarsManager.fetchData()[0].value(forKey: "level\(self.levelNumber+(self.worldNumber-1)*8)") as! Int16{
                                        case 0:
                                            PersistenceManager.fetchData()[0].points += 1
                                            StarsManager.fetchData()[0].setValue(1, forKeyPath: "level\(self.levelNumber+(self.worldNumber-1)*8)")
                                        default:
                                            print(#function)
                                        }
//                                        switch self.levelNumber-1 {
//                                        case 0:
//                                            cont.numero = 1
//                                            PersistenceManager.fetchData()[0].points +=  1
//                                            StarsManager.fetchData()[0].level1 = 1
//                                        case 1:
//                                            cont.numero = 1
//                                            PersistenceManager.fetchData()[0].points +=  1
//                                            StarsManager.fetchData()[0].level2 = 1
//                                        case 2:
//                                            cont.numero = 1
//                                            PersistenceManager.fetchData()[0].points +=  1
//                                            StarsManager.fetchData()[0].level3 = 1
//                                        case 3:
//                                            cont.numero = 1
//                                            PersistenceManager.fetchData()[0].points +=  1
//                                            StarsManager.fetchData()[0].level4 = 1
//                                        case 4:
//                                            cont.numero = 1
//                                            PersistenceManager.fetchData()[0].points +=  1
//                                            StarsManager.fetchData()[0].level5 = 1
//                                        case 5:
//                                            cont.numero = 1
//                                            PersistenceManager.fetchData()[0].points +=  1
//                                            StarsManager.fetchData()[0].level6 = 1
//                                        case 6:
//                                            cont.numero = 1
//                                            PersistenceManager.fetchData()[0].points +=  1
//                                            StarsManager.fetchData()[0].level7 = 1
//                                        case 7:
//                                            cont.numero = 1
//                                            PersistenceManager.fetchData()[0].points +=  1
//                                            StarsManager.fetchData()[0].level8 = 1
//                                        case 8:
//                                            cont.numero = 1
//                                            PersistenceManager.fetchData()[0].points +=  1
//                                            StarsManager.fetchData()[0].level9 = 1
//                                        case 9:
//                                            cont.numero = 1
//                                            PersistenceManager.fetchData()[0].points +=  1
//                                            StarsManager.fetchData()[0].level10 = 1
//                                        default:
//                                            print(#function)
//                                        }
                                    }
                                    PersistenceManager.saveContext()
                                    StarsManager.saveContext()
                                    self.navigationController?.pushViewController(new, animated: true)
                                    })
                            } else {
                                self.pronunciata.textColor = UIColor.red
                                let animation = CABasicAnimation(keyPath: "position")
                                animation.duration = 0.1
                                animation.repeatCount = 5
                                animation.autoreverses = true
                                animation.fromValue = NSValue(cgPoint: CGPoint(x: self.pronunciata.center.x-10, y: self.pronunciata.center.y))
                                animation.toValue = NSValue(cgPoint: CGPoint(x: self.pronunciata.center.x+10, y: self.pronunciata.center.y))
//                                let audioSession = AVAudioSession.sharedInstance()
//                                do {
//
//                                        try audioSession.setCategory(.playAndRecord, options: .defaultToSpeaker)
//                                          try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
//                                }catch let error as NSError{
//                                    return print(error)
//                                }
                                self.pronunciata.layer.add(animation, forKey: "position")
                                guard let url = Bundle.main.url(forResource: "zapsplat_multimedia_game_sound_wooden_bright_mallet_style_negative_tone_001_62381", withExtension: "mp3") else { return }

                                do {
                                    try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                                    try AVAudioSession.sharedInstance().setActive(true)

                                    /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
                                    self.player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

                                    /* iOS 10 and earlier require the following line:
                                    player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */

                                    guard let player = self.player else { return }

                                    player.play()

                                } catch let error {
                                    print(error.localizedDescription)
                                }
                            }
                                
            //                if let result = result, result.isFinal {
            //                    print("Result: \(result.bestTranscription.formattedString)")
            //                    isFinal = result.isFinal
            //                    //per passare a schermata risultato
            //                    if self.frase.text == self.pronunciata.text {
            //                        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            //                            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            //                            let newViewController = storyBoard.instantiateViewController(withIdentifier: "LivelloSuperatoViewController") as! LivelloSuperatoViewController
            //                            self.present(newViewController, animated: true, completion: nil)
            //                        })
            //                    }
            //                }
            //
                    } else if let error = error {
                        print(error)
                    }
                }
                }
            })
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "sendLevel" :
            let dstView = segue.destination as! LivelloSuperatoViewController
            dstView.levelNumber = (worldNumber-1)*8+levelNumber
            
        default: print(#function)
            
        }
    }
    
    func authorizeHealthkit(){
        let read = Set([HKObjectType.quantityType(forIdentifier: .heartRate)!])
        let share = Set([HKObjectType.quantityType(forIdentifier: .heartRate)!])
        healthStore.requestAuthorization(toShare: share, read: read) { (chk, error) in
            if(chk){
                print("ok")
                self.latestHeartRate()
            }
                
        }
    }
    
    func latestHeartRate(){
        
        guard let sampleType = HKObjectType.quantityType(forIdentifier: .heartRate) else{
            return
        }
        
        let startDate = Calendar.current.date(byAdding: .month, value: -1, to: Date())
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: .strictEndDate)
        
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        
        let query = HKSampleQuery(sampleType: sampleType, predicate: predicate, limit: Int(HKObjectQueryNoLimit), sortDescriptors: [sortDescriptor]) { (sample, result, error) in
            guard error == nil else{
                return
            }
            let data = result![0] as! HKQuantitySample
            let unit = HKUnit(from: "count/min")
            let latestHr = data.quantity.doubleValue(for: unit)
            print("Lastest Hr\(latestHr) BPM")
            
            let dateFormator = DateFormatter()
            
            dateFormator.dateFormat = "dd/MM/yyyy hh:mm s"
            
            let StartDate = dateFormator.string(from: data.startDate)
            
            let EndDate = dateFormator.string(from: data.endDate)
            
            print("StartDate \(StartDate) : EndDate \(EndDate)")
            
        }
        
        healthStore.execute(query)
    }

}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        switch segue.identifier {
        case "sendLevel" :
            let dstView = segue.destination as! LivelloSuperatoViewController
            dstView.levelNumber =
        default: print(#function)
            
        }

    }*/
    


