//
//  SpeechDetectionViewController.swift
//  App2
//
//  Created by Franco Cirillo on 15/02/21.
//

import UIKit
import Speech
import AVFoundation

class SpeechDetectionViewController: UIViewController, SFSpeechRecognizerDelegate{
    //Processa lo stream audio
    @IBOutlet weak var navigation: UINavigationItem!
    let audioEngine = AVAudioEngine()
    //Riconosce le parole
    //let speechRecognizer: SFSpeechRecognizer? = SFSpeechRecognizer()
    //Utile per cambiare lingua
    @IBOutlet weak var microphone: UIButton!
    let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "it-IT"))
    //Riconoscimento in tempo reale
    var request = SFSpeechAudioBufferRecognitionRequest()
    var isRecording = false
    //Gestire il riconoscimento
    var recognitionTask: SFSpeechRecognitionTask?
    @IBOutlet weak var frase: UILabel!
    @IBOutlet weak var ripeti: UIButton!
    @IBAction func ripetiTapped(_ sender: UIButton) {
        DispatchQueue.main.async {
            self.speak(self.frase.text ?? "errore")
        }
    }
    var newViewController : UIViewController?
    
    var tentativi = 0
    var livello = 1
    @IBAction func pronuncia(_ sender: Any) {
        if isRecording {

                request.endAudio() // Added line to mark end of recording
                audioEngine.stop()

              let node = audioEngine.inputNode
              node.removeTap(onBus: 0)
              //  }
                recognitionTask?.cancel()

                isRecording = false
                //startButton.backgroundColor = UIColor.gray

            } else {

                self.recordAndRecognizeSpeech()
                isRecording = true
               // startButton.backgroundColor = UIColor.red
            }
    }
    @IBOutlet weak var pronunciata: UILabel!
    
    

    //text to speech
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.hidesBackButton = true;
        self.navigationController?.navigationItem.backBarButtonItem?.isEnabled = false;
        self.navigationController!.interactivePopGestureRecognizer!.isEnabled = false;

//        microphone.isUserInteractionEnabled = true
//        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SpeechDetectionViewController.addPulse))
//        tapGestureRecognizer.numberOfTouchesRequired = 1
//        microphone.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    @objc func addPulse(){
        let pulse = Pulsing(numberOfPulses: 1, radius: 110, position: microphone.center)
        pulse.animationDuration = 0.8
        pulse.backgroundColor = UIColor(named: "Color3")?.cgColor
        
        self.view.layer.insertSublayer(pulse, below: microphone.layer)
    }
    
    func speak(_ msg : String) {
        let utterance = AVSpeechUtterance(string: msg)
       

        utterance.voice = AVSpeechSynthesisVoice(language: "it-IT")
        //utterance.rate = 0.1 velocità di espressione
        
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigation!.title = "Livello \(livello)"
        
        frase.text = NSLocalizedString("level\(livello)", comment: "")
    
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
        }catch{
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
                                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                    self.newViewController = storyBoard.instantiateViewController(withIdentifier: "LivelloSuperatoViewController") as! LivelloSuperatoViewController
                                    //self.newViewController?.isModalInPresentation = true
                                    self.navigationController?.pushViewController(self.newViewController!, animated: true)
                                    let cont = self.newViewController as! LivelloSuperatoViewController
                                    switch self.tentativi {
                                    case 1:
                                        cont.numero = 3
                                    case 2, 3:
                                        cont.numero = 2
                                    default:
                                        cont.numero = 1
                                    }
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
                    } else if let error = error {
                        print(error)
                    }
                }
                }
            })
        
    }

}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        print("Tentativi \(tentativi)")
        if let controller = newViewController {
            let cont = controller as! LivelloSuperatoViewController
            switch tentativi {
            case 1:
                cont.numero = 3
            case 2, 3:
                cont.numero = 2
            default:
                cont.numero = 1
            }
        }/*
        switch segue.identifier {
        case "showAvatar" :
            let dstView = segue.destination as! CollectionViewController
            dstView.user = userProfile
        default: print(#function)
            
        }

    }
    

 }*/*/
