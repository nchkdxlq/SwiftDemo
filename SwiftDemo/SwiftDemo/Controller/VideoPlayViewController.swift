//
//  VideoPlayViewController.swift
//  SwiftDemo
//
//  Created by nchkdxlq on 2018/3/18.
//  Copyright © 2018年 luoquan. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPlayViewController: EZBaseVC {

    private var playerItemContext = 0
    private var originNanBarHiddenStatus: Bool = false
    var playButton: UIButton!
    let currentTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.white
        label.textAlignment = .center
        return label
    }()
    
    let durationTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.white
        label.textAlignment = .center
        return label
    }()
    
    let progressSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0.0
        slider.maximumValue = 1.0
        slider.minimumTrackTintColor = UIColor.init(white: 0.8, alpha: 0.8)
        slider.maximumTrackTintColor = UIColor(r: 215, g: 215, b: 215)
        slider.thumbTintColor = UIColor.white
        return slider
    }()

    var refreshTimer: Timer?
    
    var asset: AVAsset!
    var playerItem: AVPlayerItem!
    var player: AVPlayer!

    var videoDuration: Int = 0
    
    let requiredAssetKeys = [
        "playable",
        "hasProtectedContent",
        "duration"
    ]
    
    /*
     1. 获取播放时间
     2. 帧率
     
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        
        let path = Bundle.main.path(forResource: "video", ofType: "mp4")!
        let url = URL(fileURLWithPath: path)
        
        asset = AVAsset(url: url)
        let duration = CMTimeGetSeconds(asset.duration)
        print("duration = \(duration)")
        let rate = asset.preferredRate
        print("preferredRate = \(rate)")
        let volume = asset.preferredVolume
        print("preferredVolume = \(volume)")
        let tracks = asset.tracks
        print(tracks)
        
        playerItem = AVPlayerItem(asset: asset)
        playerItem = AVPlayerItem(asset: asset, automaticallyLoadedAssetKeys: requiredAssetKeys)
        addObserver()
        
        player = AVPlayer(playerItem: playerItem)
        player.isMuted = false // 设置是否静音播放
        
        let playerLayer = AVPlayerLayer(player: player)
        view.layer.addSublayer(playerLayer)
        playerLayer.bounds = CGRect(x: 0,
                                    y: 0,
                                    width: UIScreen.width,
                                    height: UIScreen.height)
        playerLayer.position = CGPoint(x: UIScreen.width/2, y: UIScreen.height/2)
        
        setupUI()
        currentTimeLabel.text = "00:00"
        videoDuration = Int(CMTimeGetSeconds(playerItem.duration))
        durationTimeLabel.text = timeText(videoDuration)
        
        let playableKey = "playable"
        asset.loadValuesAsynchronously(forKeys: [playableKey]) { [weak self] in
            guard let strongSelf = self else { return }
            var error: NSError? = nil
            let status = strongSelf.asset.statusOfValue(forKey: playableKey, error: &error)
            if status == AVKeyValueStatus.loaded {
                DispatchQueue.main.async {
                    strongSelf.play()
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        originNanBarHiddenStatus = isNavigationBarHidden
        isNavigationBarHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
         super.viewWillDisappear(animated)
        isNavigationBarHidden = originNanBarHiddenStatus
    }
    
    private func timeText(_ seconds: Int) -> String {
        let min = String.init(format: "%02d", seconds / 60)
        let sec = String.init(format: "%02d", seconds % 60)
        return min + ":" + sec
    }
    
    private func play(atRate rate: Float = 1.0) {
        player.playImmediately(atRate: rate)
        playButton.isSelected = true
        setupRefreshTimer()
    }
    
    private func pause() {
        player.pause()
        playButton.isSelected = false
        invalidateTimer()
    }
    
    //MARK: - observer
    
    func addObserver() {
//        playerItem.addObserver(self,
//                               forKeyPath: #keyPath(AVPlayerItem.status),
//                               options: [.old, .new],
//                               context: &playerItemContext)
        
        let center = NotificationCenter.default
        let didPlayToEndTime = NSNotification.Name.AVPlayerItemDidPlayToEndTime
        center.addObserver(self,
                           selector: #selector(playItemDidEndHandle(_:)),
                           name: didPlayToEndTime,
                           object: nil)
        let didEnterBackground = NSNotification.Name.UIApplicationDidEnterBackground
        center.addObserver(self,
                           selector: #selector(enterBackgroundHandle(_:)),
                           name:didEnterBackground,
                           object: nil)
    
    }
    
    func removeObserver() {
        playerItem.removeObserver(self, forKeyPath: #keyPath(AVPlayerItem.status))
    }

    func setupUI() {
        
        let closeBtn = UIButton()
        view.addSubview(closeBtn)
        closeBtn.setTitle("关闭", for: .normal)
        closeBtn.sizeToFit()
        closeBtn.center = CGPoint(x: 40, y: 30)
        closeBtn.addTarget(self, action: #selector(closeHandle(_:)), for: .touchUpInside)
        
        let centerY = UIScreen.height - 40
        let playBtn = UIButton()
        view.addSubview(playBtn)
        playBtn.setTitle("播放", for: .normal)
        playBtn.setTitle("暂停", for: .selected)
        playBtn.sizeToFit()
        playBtn.center = CGPoint(x: 40, y: centerY)
        playBtn.addTarget(self, action: #selector(playHandle(_:)), for: .touchUpInside)
        playButton = playBtn
        
        view.addSubview(currentTimeLabel)
        view.addSubview(progressSlider)
        view.addSubview(durationTimeLabel)
        
        let width: CGFloat = 40
        currentTimeLabel.bounds = CGRect(x: 0, y: 0, width: width, height: 15)
        currentTimeLabel.center = CGPoint(x: playBtn.frame.maxX + 10.0 + width/2,
                                          y: centerY)
        
        durationTimeLabel.bounds = CGRect(x: 0, y: 0, width: width, height: 15)
        durationTimeLabel.center = CGPoint(x: UIScreen.width - 20.0 - width/2,
                                           y: centerY)
        
        let sliderWidth = durationTimeLabel.frame.minX - currentTimeLabel.frame.maxX - 20
        progressSlider.bounds = CGRect(x: 0, y: 0, width: sliderWidth, height: 10)
        let sliderCenterX = currentTimeLabel.frame.maxX + 10 + sliderWidth / 2
        progressSlider.center = CGPoint(x: sliderCenterX, y: centerY)
    }
    
    
    private func invalidateTimer() {
        if let timer = refreshTimer, timer.isValid {
            timer.invalidate()
        }
        refreshTimer = nil
    }
    
    private func setupRefreshTimer() {
        invalidateTimer()
        refreshTimer = Timer(timeInterval: 1.0/60.0,
                             target: self,
                             selector: #selector(refreshHandle(_:)),
                             userInfo: nil,
                             repeats: true)
        RunLoop.current.add(refreshTimer!, forMode: RunLoopMode.commonModes)
    }
    
    //MARK: - button action
    
    @objc private func playHandle(_ sender: UIButton) {
        if sender.isSelected {
            pause()
        } else {
            play()
        }
    }
    
    @objc private func closeHandle(_ sender: UIButton) {
        invalidateTimer()
        if let _ = presentedViewController {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    @objc private func playItemDidEndHandle(_ note: NSNotification) {
        player.seek(to: kCMTimeZero)
        playButton.isSelected = false
        invalidateTimer()
        currentTimeLabel.text = "00:00"
        progressSlider.value = 0.0
    }
    
    @objc private func enterBackgroundHandle(_ note: NSNotification) {
        pause()
    }
    
    @objc private func refreshHandle(_ timer: Timer) {
        let currentSec = Float(CMTimeGetSeconds(player.currentTime()))
        currentTimeLabel.text = timeText(Int(currentSec))
        progressSlider.value = currentSec / Float(videoDuration)
    }
    
    
    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {
        
        // Only handle observations for the playerItemContext
        guard context == &playerItemContext else {
            super.observeValue(forKeyPath: keyPath,
                               of: object,
                               change: change,
                               context: context)
            return
        }
        
        if keyPath == #keyPath(AVPlayerItem.status) {
            let status: AVPlayerItemStatus
            if let statusNumber = change?[.newKey] as? NSNumber {
                status = AVPlayerItemStatus(rawValue: statusNumber.intValue)!
            } else {
                status = .unknown
            }
            // Switch over status value
            switch status {
            case .readyToPlay:
            // Player item is ready to play.
                
                break
            case .failed: break
            // Player item failed. See error.
            case .unknown: break
                // Player item is not yet ready.
            }
        }
    }
    
    deinit {
//        removeObserver()
        invalidateTimer()
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
