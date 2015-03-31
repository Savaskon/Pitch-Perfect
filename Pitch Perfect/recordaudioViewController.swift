//
//  RecordAudioViewController.swift
//  Pitch Perfect
//
//  Created by Savas Konstadinidis on 3/10/15.
//  Copyright (c) 2015 Savas Konstadinidis. All rights reserved.
//

import UIKit
import AVFoundation


class RecordAudioViewController: UIViewController, AVAudioRecorderDelegate {
    
@IBOutlet var recordAudio: UIButton!
@IBOutlet var stopButton: UIButton!
@IBOutlet var myLabel: UILabel!
 
 
//Declared globally
var audioRecorder: AVAudioRecorder!
  
var recordedAudio: RecordedAudio!
  
override func viewDidLoad() {
  
  super.viewDidLoad()
    }

override func didReceiveMemoryWarning() {
  
super.didReceiveMemoryWarning()
    }
 
//Inside func for view will appear
override func viewWillAppear(animated: Bool) {
        
  stopButton.hidden = true
  recordAudio.enabled = true
  myLabel.text = "Tap to record"
    }

//Inside func for recording button
@IBAction func recbutton(sender: UIButton) {

let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]as String
  
let currentDateTime = NSDate()
  
let formatter = NSDateFormatter()
  
formatter.dateFormat = "ddMMyyyy-HHmmss"
let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
  
let pathArray = [dirPath, recordingName]
  
let filePath = NSURL.fileURLWithPathComponents(pathArray)
println(filePath)

//Declare session
var session = AVAudioSession.sharedInstance()
  
session.setCategory(AVAudioSessionCategoryRecord, error: nil)
audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
audioRecorder.delegate = self
audioRecorder.meteringEnabled = true
audioRecorder.prepareToRecord()
audioRecorder.record()
var Record = "record in progress"
  
  myLabel.text = Record
  myLabel.hidden = false
  stopButton.hidden = false
  recordAudio.enabled = false
    }
  
func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        
if flag {
 
recordedAudio = RecordedAudio (filePathUrl: recorder.url, title: recorder.url.lastPathComponent!)
self.performSegueWithIdentifier("stoprecording", sender: recordedAudio)
    } else {
            
println("recording was not successful")
  recordAudio.enabled = true
  stopButton.hidden = true
    }
        
}
    
override func prepareForSegue(segue:UIStoryboardSegue, sender: AnyObject?) {
        
if (segue.identifier == "stoprecording") {
        
let playSoundsVC: PlaySoundsViewController = segue.destinationViewController as PlaySoundsViewController
  
let data = sender as RecordedAudio
  
playSoundsVC.receiveAudio = data
    }
        
    }
//Iniside func for stopbutton
@IBAction func stopButton(sender: UIButton) {

var audioSession = AVAudioSession.sharedInstance()
  audioRecorder.stop()
audioSession.setActive(false, error: nil)
  myLabel.text = "Tap to Record"
  recordAudio.enabled = true
  stopButton.hidden = true
        
}
    
    
}

	