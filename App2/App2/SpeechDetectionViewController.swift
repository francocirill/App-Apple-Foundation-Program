//
//  SpeechDetectionViewController.swift
//  App2
//
//  Created by Franco Cirillo on 15/02/21.
//

import UIKit
import Speech

class SpeechDetectionViewController: UIViewController, SFSpeechRecognizerDelegate{
    
    @IBOutlet weak var frase: UILabel!
    @IBOutlet weak var ripeti: UIButton!
    @IBAction func ripetiTapped(_ sender: UIButton) {
        self.recordAndRecognizeSpeech()
    }
    @IBOutlet weak var pronunciata: UILabel!
    
    //Processa lo stream audio
    let audioEngine = AVAudioEngine()
    //Riconosce le parole
    let speechRecognizer: SFSpeechRecognizer? = SFSpeechRecognizer()
    //Utile per cambiare lingua
//    let speechRecognizer: SFSpeechRecognizer(locale: Locale.init(identifier: "en-US"))
    //Riconoscimento in tempo reale
    let request = SFSpeechAudioBufferRecognitionRequest()
    //Gestire il riconoscimento
    var recognitionTask: SFSpeechRecognitionTask?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func recordAndRecognizeSpeech(){
        let node = audioEngine.inputNode //else { return }
        let recordingFormat = node.outputFormat(forBus: 0)
        node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
            self.request.append(buffer)
        }
        
        audioEngine.prepare()
        do{
            try audioEngine.start()
        }catch{
            return print(error)
        }
        
//        guard let myRecognizer = SFSpeechRecognizer() else {
//            return
//        }
        
        recognitionTask = speechRecognizer?.recognitionTask(with: request, resultHandler: { result, error in
            if let result = result{
                let bestString = result.bestTranscription.formattedString
                self.pronunciata.text = bestString
                
            } else if let error = error{
                print(error)
            }
        })
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
