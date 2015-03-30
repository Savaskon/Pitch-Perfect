//
//  playsoundsViewController.swift
//  Pitch Perfect
//
//  Created by Savas Konstadinidis on 3/14/15.
//  Copyright (c) 2015 Savas Konstadinidis. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
//Declared Globally
var session = AVAudioSession.sharedInstance()!
var audioPlayer: AVAudioPlayer!
  
var receiveAudio: RecordedAudio!
  
var audioEngine: AVAudioEngine!
  
var audioFile: AVAudioFile!

//Inside func Stopbutton
@IBAction func stopbutton(sender: UIButton) {
        
  audioPlayer.stop()
  audioPlayer.currentTime = 0
  audioEngine.stop()
    }
 
//Inside func slowplay button
@IBAction func slowplay(sender: UIButton) {

  audioPlayer.enableRate = true
  audioPlayer.rate = 0.5
  audioPlayer.play()
  audioEngine.stop()
  audioEngine.reset()
  audioPlayer.currentTime = 0.0
    }
  
//Inside func fastplay button
@IBAction func fastplay(sender: UIButton) {
        
  audioPlayer.enableRate = true
  audioPlayer.rate = 2
  audioPlayer.play()
  audioEngine.stop()
  audioEngine.reset()
  audioPlayer.currentTime = 0.0
      }
    
//Inside func chimpplay button
@IBAction func chimplay(sender: UIButton) {
  
  playAudioWithVariablePitch(1000)
    }
    
//New function
func playAudioWithVariablePitch(pitch: Float){
  audioPlayer.stop()
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

//Inside function for darthvader button
@IBAction func darthvader(sender: UIButton) {
        
playAudioWithVariablePitch(-700) }
    
func PlayAudioWithVariablePitch(pitch: Float){
  
  audioPlayer.stop()
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
  audioPlayer = AVAudioPlayer(contentsOfURL: receiveAudio.filePathUrl, error: nil)
  audioPlayer.enableRate = true
  audioEngine = AVAudioEngine()
  audioFile = AVAudioFile(forReading: receiveAudio.filePathUrl, error: nil)
  session.setCategory(AVAudioSessionCategoryPlayback, error: nil)
    }

override func didReceiveMemoryWarning() {
  
  super.didReceiveMemoryWarning()
       
    }
  
    
}
	