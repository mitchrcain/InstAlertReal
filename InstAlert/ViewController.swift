//
//  ViewController.swift
//  InstAlert
//
//  Created by Mitchell Cain on 1/17/19.
//  Copyright © 2019 Mitchell Cain. All rights reserved.
//

import UIKit
import CoreLocation
import AVFoundation


class ViewController: UITableViewController, CLLocationManagerDelegate, AVAudioPlayerDelegate, AVAudioRecorderDelegate {
    
    @IBOutlet weak var alertButton: UIBarButtonItem!
    @IBOutlet weak var tracking: UIBarButtonItem!
    @IBOutlet weak var settingsBtn: UIBarButtonItem!
    @IBOutlet weak var recordButton: UIBarButtonItem!
    var locationManager: CLLocationManager!
    let fm = FileManager.default
    let path = Bundle.main.resourcePath!
    var profilePictures = ["profileImage1.jpg", "profileImage2.jpg", "profileImage3.jpg"]
    var usernameList = ["Karol Jennings", "Amari Suarez", "Todd Cornish"]
    var postImages = ["postImage1.jpg", "postImage2.jpg", "postImage3.jpg"]
    var recordSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setting up location access and tracking
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        recordButton.tintColor = UIColor.red as UIColor
        
        switch AVCaptureDevice.authorizationStatus(for: .audio) {
            //Permission for audio recording
            case.authorized:
                return
            
            case.notDetermined:
                AVCaptureDevice.requestAccess(for: .audio) { granted in
                    if granted {
                       return                    }
            }
            
            case.denied:
                AVCaptureDevice.requestAccess(for: .audio) { granted in
                    if granted {
                        return
                    }
            }
            
            case.restricted:
                return
        }
        
        
        
    }
    
    func getDocumentsDirectory() -> URL {
        // Build directory for audio files
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            // authorized location status when app is in use; update current location
            locationManager.startUpdatingLocation()
            // implement additional logic if needed...
        }
        // implement logic for other status values if needed...
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Formatting photo feed
        return 3
    }
    
    @IBAction func alertMessage(_ sender: UIBarButtonItem) {
        
        // Button press triggers alert message, running shortcut installed externally
        
        if let shortcut = URL(string: "shortcuts://x-callback-url/run-shortcut?name=InstAlert%20Test&x-success=instalert://") {
            UIApplication.shared.open(shortcut, options: [:], completionHandler: nil)
        }
    }

    @IBAction func recordAudio(_ sender: UIBarButtonItem) {
        
        // recordButton press triggers audio recording
        // Need to create access point to recordings later, don't forget
        if recordButton.tintColor == UIColor.red {
            recordSession = AVAudioSession.sharedInstance()
            do {
                try recordSession.setCategory(.playAndRecord, mode: .default)
                try recordSession.setActive(true)
            } catch {
                // failed to record!
            }
            
            let audioFilename = getDocumentsDirectory().appendingPathComponent("testRecording.m4a")
            
            let settings = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 12000,
                AVNumberOfChannelsKey: 1,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]
            
            do {
                audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
                audioRecorder.delegate = self
                audioRecorder.record()
                
                recordButton.tintColor = UIColor.green
            } catch {
                audioRecorder.stop()
                audioRecorder = nil
            }
        } else if recordButton.tintColor == UIColor.green {
            audioRecorder.stop()
            audioRecorder = nil
            
            recordButton.tintColor = UIColor.red
        } else {
            return
        }
        
        
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            audioRecorder.stop()
            audioRecorder = nil
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // formatting photo feed
        let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostCell
        cell.postImage.image = UIImage(named: postImages[indexPath.row])
        cell.profileImageView.image = UIImage(named: profilePictures[indexPath.row])
        cell.username.text = usernameList[indexPath.row]
        if (indexPath.row)%2 == 1 {
            cell.commentButton.image = UIImage(named: "commentFull")
        }
        return cell
    }
    
    //Tomorrow create recording function and save audio files
    


}

