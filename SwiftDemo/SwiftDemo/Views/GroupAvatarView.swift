//
//  GroupAvatarView.swift
//  SwiftDemo_learn
//
//  Created by nchkdxlq on 2017/1/8.
//  Copyright © 2017年 nchkdxlq. All rights reserved.
//

import UIKit
import Kingfisher

private let kPadding: CGFloat = 5.0


fileprivate class GeneratorManager {
    private var generators = [GroupAvatarGenerator]()
    static var manager = GeneratorManager()
    private init() { }
    
    func addGenerator(_ genetator: GroupAvatarGenerator) {
        generators.append(genetator)
    }
    
    func removeGenerator(_ genetator: GroupAvatarGenerator) {
        if let index = generators.firstIndex(of: genetator) {
            generators.remove(at: index)
        }
    }
}

class GroupAvatarGenerator: Equatable {
    
    private var imageTasks = [DownloadTask]()
    private var images = [Any]()
    private let completion: (UIImage?) -> ()
    private let size: CGSize
    private let itemSize: CGSize
    
    init(_ images: [Any],
         size: CGSize = CGSize(width: 200, height: 200),
         completion: @escaping ((UIImage?) -> ()))
    {
        self.images = images
        self.completion = completion
        self.size = size
        self.itemSize = CGSize(width: (size.width-kPadding)/2.0, height: (size.height-kPadding)/2.0)
        
        GeneratorManager.manager.addGenerator(self)
        generaterImage()
    }
    
    func cancel() {
        imageTasks.forEach { (item) in
            item.cancel()
        }
        GeneratorManager.manager.removeGenerator(self)
    }
    
    
    private func itemRect(for index: Int) -> CGRect {
        
        if images.count == 2 {
            let Y = (size.height - itemSize.height) / 2.0
            if index == 0 {
                return CGRect(x: 0, y: Y , width: itemSize.height, height: itemSize.height)
            } else {
                return CGRect(x: size.width-itemSize.width , y: Y, width: itemSize.height, height: itemSize.height)
            }
        } else if images.count == 3 {
            let X = (size.width - itemSize.width) / 2.0
            if index == 0 {
                return CGRect(x: X, y: 0 , width: itemSize.height, height: itemSize.height)
            } else if index == 1 {
                return CGRect(x: 0, y: size.height-itemSize.height, width: itemSize.height, height: itemSize.height)
            } else {
                return CGRect(x: size.width-itemSize.width, y: size.height-itemSize.height, width: itemSize.height, height: itemSize.height)
            }
        } else {
            if index == 0 {
                return CGRect(x: 0, y: 0, width: itemSize.height, height: itemSize.height)
            } else if index == 1 {
                return CGRect(x: size.width-itemSize.width, y: 0, width: itemSize.height, height: itemSize.height)
            } else if index == 2 {
                return CGRect(x: 0, y: size.height-itemSize.height, width: itemSize.height, height: itemSize.height)
            } else {
                return CGRect(x: size.width-itemSize.width, y: size.height-itemSize.height, width: itemSize.height, height: itemSize.height)
            }
        }
    }
    
    private func generaterImage() {
        
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        guard let context = UIGraphicsGetCurrentContext() else {
            completion(nil); return
        }
        
        let group = DispatchGroup()
        
        func drawImage(_ image: UIImage, at index: Int) {
            context.saveGState()
            let rect = itemRect(for: index)
            context.addEllipse(in: rect)
            context.clip()
            image.draw(in: rect)
            context.restoreGState()
        }
        
        for (index, item) in self.images.enumerated() {
            group.enter()
            if let url = item as? URL {
                let task = KingfisherManager.shared.retrieveImage(with: url) { (result) in
                    switch result {
                    case .failure(let error):
                        print(error)
                        break
                    case .success(let imageResult):
                        drawImage(imageResult.image, at: index)
                        break
                    }
                    group.leave()
                }!
                imageTasks.append(task)
            } else if let image = item as? UIImage {
                drawImage(image, at: index)
                group.leave()
            }
        }
        
        group.notify(queue: DispatchQueue.main) {
            let image =  UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            self.completion(image)
            GeneratorManager.manager.removeGenerator(self)
        }
    }
}


func ==(left: GroupAvatarGenerator, right: GroupAvatarGenerator) -> Bool {
    return true
}
