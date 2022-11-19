//
//  RotationViewController.swift
//  SwiftDemo
//
//  Created by cookie.luo on 2022/11/19.
//  Copyright © 2022 luoquan. All rights reserved.
//

import UIKit

class RotationViewController: EZBaseVC {
    
    var forceLandscape = false
    var rotateFollowSystem = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubViews()
        addPresentButton()
        addRotateButton()
        addRotateEnableButton()
        addDeviceCurrentOrientation()
    }
    
    private func setupSubViews() {
        let orangeView = UIView()
        orangeView.backgroundColor = .orange
        view.addSubview(orangeView)
        
        let greenView = UIView()
        greenView.backgroundColor = .green
        view.addSubview(greenView)
        
        [orangeView, greenView].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        NSLayoutConstraint.activate([
            orangeView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            orangeView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            orangeView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            orangeView.heightAnchor.constraint(equalToConstant: 100),
        ])
        
        NSLayoutConstraint.activate([
            greenView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            greenView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            greenView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            greenView.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
    
    // MARK: - 横竖屏切换时系统方法

    /// 需要横竖屏切换，必须返回true, 告知系统该页面支持横竖屏. (iOS16系统不再调用)
    override var shouldAutorotate: Bool {
        print("Roration", "shouldAutorotate")
        return true
    }
    
    /// 返回当前控制器支持的页面方向，可支持多个页面方向
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        print("Roration", "supportedInterfaceOrientations")
        if rotateFollowSystem {
            return .all
        } else {
            return forceLandscape ? .landscapeLeft : .portrait
        }
        // ⚠️如果是当前控制器是被present弹出的，强制横竖屏切换时，⚠️
        // 只能设置首次返回集合中的类型，设置不在集合中的类型会闪退, 这一个和push出的控制器不一致
    }
    
    /// 当控制器是present出来时页面初始方向
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        print("Roration", "preferredInterfaceOrientationForPresentation")
        return .portrait
    }
    
    /// 页面即将发生横竖屏切换时调用, 需要调用supper
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        print("Roration", "viewWillTransition size = ", size)
    }
}


extension RotationViewController {
    
    private func addPresentButton() {
        let button = UIButton()
        button.setTitle("Present", for: .normal)
        button.backgroundColor = .lightGray
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -80),
        ])
        button.addTarget(self, action: #selector(presentAction(_:)), for: .touchDown)
    }
    
    @objc(presentAction:)
    private func presentAction(_ button: UIButton) {
        let vc = RotationViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
}



// MARK: - 强制横竖屏

extension RotationViewController {
    
    private func addRotateButton() {
        let button = UIButton()
        button.setTitle("切换至横屏", for: .normal)
        button.backgroundColor = .blue
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -30),
        ])
        button.addTarget(self, action: #selector(rotateAction(_:)), for: .touchDown)
    }
    
    @objc(rotateAction:)
    private func rotateAction(_ button: UIButton) {
        print("Roration", "rotateAction begin")
        forceLandscape = !forceLandscape
        if #available(iOS 16.0, *) {
            setNeedsUpdateOfSupportedInterfaceOrientations()
            guard let scence = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
                return
            }
            let orientation: UIInterfaceOrientationMask = forceLandscape ? .landscapeLeft : .portrait
            let geometryPreferences = UIWindowScene.GeometryPreferences.iOS(interfaceOrientations: orientation)
            scence.requestGeometryUpdate(geometryPreferences)
        } else {
            let orientation: UIDeviceOrientation = forceLandscape ? .landscapeLeft : .portrait
            UIDevice.current.setValue(NSNumber(value: orientation.rawValue), forKey: "orientation")
        }
        button.setTitle(forceLandscape ? "切换至竖屏" : "切换至横屏", for: .normal)
        print("Roration", "rotateAction end")
    }
    
}

// MARK: - 跟随系统旋屏

extension RotationViewController {
    
    private func addRotateEnableButton() {
        let button = UIButton()
        button.setTitle("跟随系统", for: .normal)
        button.backgroundColor = .blue
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 30),
        ])
        button.addTarget(self, action: #selector(rotateFollowSystemAction(_:)), for: .touchDown)
    }
    
    @objc(rotateFollowSystemAction:)
    private func rotateFollowSystemAction(_ button: UIButton) {
        rotateFollowSystem = !rotateFollowSystem
        if #available(iOS 16.0, *) {
            setNeedsUpdateOfSupportedInterfaceOrientations()
        } else {
            // Fallback on earlier versions
        }
        button.setTitle(rotateFollowSystem ? "自行控制" : "跟随系统", for: .normal)
    }
}

// MARK: - 获取设备方向
extension RotationViewController {
    
    private func addDeviceCurrentOrientation() {
        let button = UIButton()
        button.setTitle("获取设备当前方向", for: .normal)
        button.backgroundColor = .blue
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 90),
        ])
        button.addTarget(self, action: #selector(deviceCurrentOrientationAction(_:)), for: .touchDown)
    }
    
    @objc(deviceCurrentOrientationAction:)
    private func deviceCurrentOrientationAction(_ button: UIButton) {
        button.setTitle("获取设备当前方向: \(UIDevice.current.orientation.description)", for: .normal)
    }
}


extension UIDeviceOrientation : CustomStringConvertible {
    
    public var description: String {
        switch self {
        case .portrait:
            return "portrait"
        case .portraitUpsideDown:
            return "portraitUpsideDown"
        case .landscapeLeft:
            return "landscapeLeft"
        case .landscapeRight:
            return "landscapeRight"
        case .faceUp:
            return "faceUp"
        case .faceDown:
            return "faceDown"
        default :
            return "unknown"
        }
    }
}
