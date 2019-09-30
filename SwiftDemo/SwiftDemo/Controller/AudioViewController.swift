//
//  AudioViewController.swift
//  SwiftDemo_learn
//
//  Created by nchkdxlq on 2016/12/16.
//  Copyright © 2016年 nchkdxlq. All rights reserved.
//

import UIKit
import AVFoundation
import SnapKit

class AudioViewController: EZBaseVC {

    
    var audioPlayer: AVAudioPlayer?
    var audioRecorder: AVAudioRecorder?
    
    var playerButton: UIButton!
    var recordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setSubViews()
        
        // 开启近场感应监控
        UIDevice.current.isProximityMonitoringEnabled = true
        
        addObserver()
        setupSession(true)
    }
    
    //MARK: subViews
    private func setSubViews() {
        let recordBtn = UIButton()
        recordBtn.backgroundColor = UIColor.blue
        view.addSubview(recordBtn)
        recordBtn.snp.makeConstraints { (make) in
            make.top.equalTo(view).offset(100)
            make.leading.equalTo(view).offset(50)
        }
        recordBtn.setTitle("录制", for: .normal)
        recordBtn.setTitle("停止", for: .selected)
        recordBtn.addTarget(self, action: #selector(recordButtonAction(_:)), for: .touchUpInside)
        recordButton = recordBtn
        
        let playerBtn = UIButton()
        playerBtn.backgroundColor = UIColor.blue
        view.addSubview(playerBtn)
        playerBtn.snp.makeConstraints { (make) in
            make.top.equalTo(recordBtn)
            make.trailing.equalTo(view).offset(-50)
        }
        playerBtn.setTitle("播放", for: .normal)
        playerBtn.setTitle("停止", for: .selected)
        playerBtn.addTarget(self, action: #selector(playButtonAction(_:)), for: .touchUpInside)
        playerButton = playerBtn
    }
    
    
    @objc private func recordButtonAction(_ button: UIButton) {
        button.isSelected = !button.isSelected
        if button.isSelected {
            let audioSession = AVAudioSession.sharedInstance()
            
            func recorderHandle() {
                let path = NSTemporaryDirectory() + "\(Int(Date().timeIntervalSince1970))"
                let url = URL(fileURLWithPath: path)
                do {
                    let recorder = try AVAudioRecorder(url: url, settings: [:])
                    recorder.delegate = self
                    self.audioRecorder = recorder
                    recorder.prepareToRecord()
                    recorder.record()
                } catch {
                    print(error)
                }
            }
            
            if audioSession.recordPermission == .granted {
                recorderHandle()
            } else {
                AVAudioSession.sharedInstance().requestRecordPermission({ (result) in
                    if result {
                        recorderHandle()
                    } else {
                        print("拒接访问提示...")
                    }
                })
            }
    
        } else {
            audioRecorder?.stop()
        }
    }
    
    @objc private func playButtonAction(_ button: UIButton) {
        button.isSelected = !button.isSelected
        
        if button.isSelected {
            if let player = audioPlayer {
                player.play()
            } else {
                let fileName = "just_need_one_time.mp3"
                guard let path = Bundle.main.path(forResource: fileName, ofType: nil) else { return }
                let url = URL(fileURLWithPath: path)
                setupAudioPlayer(url)
            }
        } else {
            audioPlayer?.stop()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.endReceivingRemoteControlEvents()
        audioPlayer?.stop()
    }
    
    private func setupSession(_ active: Bool) {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            let activeFlag = AVAudioSession.SetActiveOptions.notifyOthersOnDeactivation
            try audioSession.setActive(active, options: activeFlag)
            if active {
                try audioSession.setCategory(AVAudioSession.Category.playback)
                try audioSession.setMode(AVAudioSession.Mode.default)
            }
        } catch {
            print(error)
        }
    }
    
    //MARK: - AudioPlayer
    fileprivate func setupAudioPlayer(_ url: URL) {
  
        do {
            self.audioPlayer?.stop()
            self.audioPlayer = nil
            let audioPlayer = try AVAudioPlayer(contentsOf: url)
            self.audioPlayer = audioPlayer
            audioPlayer.delegate = self
            audioPlayer.numberOfLoops = 0
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        } catch {
            print(error)
        }
    }
    
    private func addObserver() {
        
        let center = NotificationCenter.default
        center.addObserver(self,
                           selector: #selector(routeDidChangehandle(_:)),
                           name: AVAudioSession.routeChangeNotification,
                           object: nil)
        
        center.addObserver(self,
                           selector: #selector(proximityStateDidChangeHandle(_:)),
                           name: UIDevice.proximityStateDidChangeNotification,
                           object: nil)
    }
    
    @objc private func routeDidChangehandle(_ note: Notification) {
        guard let userInfo = note.userInfo,
            let route = userInfo[AVAudioSessionRouteChangePreviousRouteKey] as? AVAudioSessionRouteDescription else { return }
        let outputs = route.outputs
        guard let targetOutput = outputs.first else {
            return
        }
        if targetOutput.portType == AVAudioSession.Port.builtInSpeaker {
            audioPlayer?.play()
        } else if targetOutput.portType == AVAudioSession.Port.headphones {
            audioPlayer?.pause()
        }
        print("outPutType: " + targetOutput.portType.rawValue)
    }
    
    
    // MARK: -  靠近远离手机处理
    @objc private func proximityStateDidChangeHandle(_ note: Notification) {
        guard let output = AVAudioSession.sharedInstance().currentRoute.outputs.first else {
            print("no avelable output")
            return
        }
        
        let shareSession = AVAudioSession.sharedInstance()
        if output.portType == AVAudioSession.Port.builtInSpeaker {
            print("扬声器: \(UIDevice.current.proximityState == true ? "靠近" : "远离")")
            if UIDevice.current.proximityState {
                do {
                    try shareSession.setCategory(AVAudioSession.Category.playAndRecord)
                } catch {}
            }
            
        } else if output.portType == AVAudioSession.Port.headphones {
            
            print("耳机: \(UIDevice.current.proximityState == true ? "靠近" : "远离")")
            
        } else if output.portType == AVAudioSession.Port.builtInReceiver {
            print("听筒: \(UIDevice.current.proximityState == true ? "靠近" : "远离")")
            if !UIDevice.current.proximityState {
                do {
                    try shareSession.setCategory(AVAudioSession.Category.playback)
                } catch {}
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//MARK: - AVAudioPlayerDelegate
extension AudioViewController: AVAudioPlayerDelegate {
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print("audioPlayerDidFinishPlaying = \(flag)")
        audioPlayer = nil
    }
    
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        if let _error = error {
            print(_error)
        }
    }
}

//MARK: - AVAudioRecorderDelegate
extension AudioViewController: AVAudioRecorderDelegate {
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        audioRecorder = nil
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.setupAudioPlayer(recorder.url)
        }
    }
    
    func audioRecorderEncodeErrorDidOccur(_ recorder: AVAudioRecorder, error: Error?) {
        audioRecorder = nil
        if let _error = error {
            print(_error)
        }
    }
}
