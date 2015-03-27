//
//  playsoundsViewController.swift
//  Pitch Perfect
//
//  Created by Savas Konstadinidis on 3/14/15.
//  Copyright (c) 2015 Savas Konstadinidis. All rights reserved.
//

import UIKit
import AVFoundation

class playsoundsViewController: UIViewController {
    var session = AVAudioSession.sharedInstance()!
    
    var audioplayer: AVAudioPlayer!
    var receiveAudio: RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
 

    @IBAction func stopbutton(sender: UIButton) {
        audioplayer.stop()
        audioplayer.currentTime = 0
        audioEngine.stop()
    }

    @IBAction func slowplay(sender: UIButton) {
        audioplayer.enableRate = true
        audioplayer.rate = 0.5
        audioplayer.play()
        audioEngine.stop()
        audioEngine.reset()
       
      
    }
    
    @IBAction func fastplay(sender: UIButton) {
        audioplayer.enableRate = true
        audioplayer.rate = 2
        audioplayer.play()
        audioEngine.stop()
        audioEngine.reset()
        
    }
    
    
    
    @IBAction func chimplay(sender: UIButton) {
        
        playAudioWithVariablePitch(1000) }
        func playAudioWithVariablePitch(pitch: Float){
            audioplayer.stop()
            audioEngine.stop()
            audioEngine.reset()
            
            var audioPlayerNode = AVAudioPlayerNode()
            audioEngine.attachNode(audioPlayerNode)
            
            var changePitchEffect = AVAudioUnitTimePitch()
            changePitchEffect.pitch = pitch
            audioEngine.attachNode(changePitchEffect)
            
            audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
            audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
            
            audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
            audioEngine.startAndReturnError(nil)
            
            audioPlayerNode.play()
        
    }
    

    @IBAction func darthvader(sender: UIButton) {
        
    playAudioWithVariablePitch(-700) }
    func PlayAudioWithVariablePitch(pitch: Float){
        audioplayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        audioPlayerNode.play()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        audioplayer = AVAudioPlayer(contentsOfURL: receiveAudio.filePathUrl, error: nil)
        audioplayer.enableRate = true
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receiveAudio.filePathUrl, error: nil)
        session.setCategory(AVAudioSessionCategoryPlayback, error: nil)
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    

    
}
	