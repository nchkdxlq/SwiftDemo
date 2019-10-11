//
//  CombineViewController.swift
//  RxSwiftDemo
//
//  Created by Knox on 2019/10/11.
//  Copyright © 2019 luoquan. All rights reserved.
//

import UIKit
import Combine



class CombineViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Combine"
        
        
//        test_empty()
//        test_just()
//        test_sequence()
        test_map()
        test_scan()
        test_reduce()
        test_compactMap()
        test_flatMap()
        test_removeDuplicates()
    }
    
    
    
    func test_empty() {
        check("Empty") {
            Empty<Int, SampleError>()
        }
    }
    
    
    func test_just() {
        check("Just") {
            Just(1)
        }
    }
    
    
    func test_sequence() {
        check("Sequence") {
//            Publishers.Sequence<[Int], Never>(sequence: [1, 2, 3])
            [1, 2, 3].publisher
        }
    }
    
    
    func test_map() {
        check("Map") {
            [1, 2, 3].publisher.map { $0 * 2 }
        }
    }
    
    func test_scan() {
        check("Scan") {
            [1, 2, 3, 4, 5].publisher.scan(0, +)
        }
    }
    
    
    func test_reduce() {
        check("Reduce") {
            [1, 2, 3, 4, 5].publisher.reduce(0, +)
        }
    }
    
    
    /*
     compactMap 比较简单，它的作用是将 map 结果中那些 nil 的元素去除掉，
     这个操作通常会 “压缩” 结果，让其中的元素数减少
     */
    func test_compactMap() {
        check("CompactMap") {
            ["1", "2", "3", "Cat", "5"].publisher.compactMap { Int($0) }
        }
        
        check("Compact Map by Filter") {
            ["1", "2", "3", "Cat", "5"].publisher.map { Int($0) }.filter { $0 != nil}.map { $0! }
        }
    }
    
    /*
        `map`和`compactMap`的闭包返回的是单个的Output的值。而`flatMap`的变形闭包里需要返回的是一个新的`Publisher`.
        也就是说, `flatMap`会涉及到两个`Publisher`, 一个是flatMap操作本身的Publisher, 一个是flatMap所接受的变形闭包
        中返回的内存Publisher。flatMap将外层Publisher发出的事件中的值传递给内存的Publisher, 然后汇总内层的Publisher
        给出的事件输出, 作为最终的变形后的结果
     */
    func test_flatMap() {
        
        check("Flat Map 1") {
            [[1, 2, 3], ["a", "b", "c"]]
                .publisher
                .flatMap {
                    return $0.publisher
                }
        }
        
        check("Flat Map 2") {
            ["A", "B", "C"].publisher.flatMap { letter in
                [1, 2, 3].publisher.map { "\(letter)\($0)" }
            }
        }
    }
    
    
    func test_removeDuplicates() {
        check("Remove Deplicates") {
            ["S", "Sw", "Sw", "Sw", "Swi", "Swif", "Swift", "Swift", "Swif"]
                .publisher
                .removeDuplicates()
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
