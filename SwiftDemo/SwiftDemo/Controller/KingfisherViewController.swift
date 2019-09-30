//
//  KingfisherViewController.swift
//  SwiftDemo_learn
//
//  Created by nchkdxlq on 2017/1/7.
//  Copyright © 2017年 nchkdxlq. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher


class ProgressView: UIView {
    
    private var indicatorView: UIActivityIndicatorView!
    private (set) var progressLable: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        
        indicatorView = UIActivityIndicatorView(style: .white)
        indicatorView.hidesWhenStopped = true
        addSubview(indicatorView)
        
        progressLable = UILabel()
        progressLable.backgroundColor = UIColor.clear
        addSubview(progressLable)
        progressLable.font = UIFont.systemFont(ofSize: 13)
        progressLable.textColor = UIColor.white
        
        indicatorView.snp.makeConstraints { (make) in
            make.center.equalTo(self)
        }
        
        progressLable.snp.makeConstraints { (make) in
            make.top.equalTo(indicatorView.snp.bottom).offset(2)
            make.centerX.equalTo(self)
        }
    }
    
    
    func startAnimating() {
        indicatorView.startAnimating()
    }
    
    func stopAnimating() {
        indicatorView.stopAnimating()
    }
    
    func setProgress(_ progress: Double) {
        progressLable.text = "\(Int(progress * 100))%"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}



private let image_url = "http://ww2.sinaimg.cn/mw690/006erAhmgw1fbh7p8mgpwj31kw2qmwyy.jpg"

private let image_url0 = "http://ww4.sinaimg.cn/mw690/d2f379bdgw1fay57fqkq6j20b40b475d.jpg"
private let image_url1 = "http://ww4.sinaimg.cn/mw690/d2f379bdgw1fay57h8msaj20b40b4ab7.jpg"
private let image_url2 = "http://ww3.sinaimg.cn/mw690/d2f379bdgw1fay57iivsaj20b40b4ab9.jpg"
private let image_url3 = "http://ww2.sinaimg.cn/mw690/d2f379bdgw1fay57nykfbj20b40b43zk.jpg"

/*
 http://ww4.sinaimg.cn/mw690/d2f379bdgw1fay57fqkq6j20b40b475d.jpg
 http://ww4.sinaimg.cn/mw690/d2f379bdgw1fay57h8msaj20b40b4ab7.jpg
 http://ww3.sinaimg.cn/mw690/d2f379bdgw1fay57iivsaj20b40b4ab9.jpg
 http://ww2.sinaimg.cn/mw690/d2f379bdgw1fay57nykfbj20b40b43zk.jpg
 http://ww2.sinaimg.cn/mw690/d2f379bdgw1fay57o5neyj20b40b43zv.jpg
 http://ww2.sinaimg.cn/mw690/d2f379bdgw1fay57m1dqsj20b40b4dgh.jpg
 
 */

class KingfisherViewController: EZBaseVC {

    
    var avatarGenerator: GroupAvatarGenerator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testKingfisher()
//        testGroupAvatar()
    }
    
    
    private func testKingfisher() {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.red
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.center.equalTo(view)
            make.size.equalTo(CGSize(width: 300, height: 300))
        }
        
        let testProgressView = ProgressView()
        imageView.addSubview(testProgressView)
        testProgressView.snp.makeConstraints { (make) in
            make.edges.equalTo(imageView)
        }
        let url = URL(string: image_url)
        let placeholder = UIImage(named: "Me")
        testProgressView.startAnimating()
        imageView.kf.setImage(with: url,
                              placeholder: placeholder,
                              options: [.forceRefresh],
                              progressBlock: { (current, total) in
                                let progress = Double(current) / Double(total)
                                testProgressView.setProgress(progress)
                                print("progress: \(progress)")
                                
        }) { (image, error, cachaType, url) in
            testProgressView.stopAnimating()
            testProgressView.removeFromSuperview()
            if let __image = image {
                print(__image)
            }
        }
    }
    
    
    private func testGroupAvatar() {
        
        let imageView = UIImageView()
        view.addSubview(imageView)
        imageView.backgroundColor = UIColor.red
        imageView.snp.makeConstraints { (make) in
            make.center.equalTo(view)
            make.size.equalTo(CGSize(width: 200, height: 200))
        }
        
        let defaultImage = UIImage(named: "Me")!
        let image0: Any = URL(string: image_url0) ?? defaultImage
        let image1: Any = URL(string: image_url1) ?? defaultImage
        let image2: Any = URL(string: image_url2) ?? defaultImage
        let image3: Any = URL(string: image_url3) ?? defaultImage
        
        let urls = [image0, image1, image2, image3]
        
        imageView.image = defaultImage
        avatarGenerator = GroupAvatarGenerator(urls, completion: { (image) in
            imageView.image = image
        })
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
