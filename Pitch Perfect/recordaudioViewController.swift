//
//  recordaudioViewController.swift
//  Pitch Perfect
//
//  Created by Savas Konstadinidis on 3/10/15.
//  Copyright (c) 2015 Savas Konstadinidis. All rights reserved.
//

import UIKit
import AVFoundation


class recordaudioViewController: UIViewController, AVAudioRecorderDelegate {
    @IBOutlet var recordaudio: UIButton!
    @IBOutlet var stopbutton: UIButton!
    @IBOutlet var mylabel: UILabel!
    @IBOutlet var tap: UILabel!
    var audioRecorder:AVAudioRecorder!
    var recordedAudio: RecordedAudio!
    override func viewDidLoad() {
        super.viewDidLoad()
        
            }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
    override func viewWillAppear(animated: Bool) {
        stopbutton.hidden = true
        recordaudio.enabled = true
    }

   
    @IBAction func recbutton(sender: UIButton) {
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        println(filePath)
        
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryRecord, error: nil)
        
        audioRecorder = AVAudioRecorder(URL: filePath, settings: nil, error: nil)
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        tap.hidden = true
        var record = "record in progress"
        mylabel.text = record
        mylabel.hidden = false
        stopbutton.hidden = false
        recordaudio.enabled = false

        
    }
  
     func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        if flag {
        recordedAudio = RecordedAudio()
        recordedAudio.filePathUrl = recorder.url
        recordedAudio.title = recorder.url.lastPathComponent
       self.performSegueWithIdentifier("stoprecording", sender: recordedAudio)
        } else {
        println("recording was not successful")
            recordaudio.enabled = true
            stopbutton.hidden = true }
        
    }
    override func prepareForSegue(segue:UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "stoprecording") {
            let playsoundsVC: playsoundsViewController = segue.destinationViewController as
            playsoundsViewController
            let data = sender as RecordedAudio
            playsoundsVC.receiveAudio = data
        }
        
    }
    @IBAction func stopbutton(sender: UIButton) {
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false, error: nil)
        
        mylabel.hidden = true
        recordaudio.enabled = true
        stopbutton.hidden = true
}
    

    
   
    
}

	