//
//  ProtocolViewController.swift
//  SwiftDemo_learn
//
//  Created by nchkdxlq on 2018/2/3.
//  Copyright © 2018年 nchkdxlq. All rights reserved.
//

import UIKit

struct Student_t {
    var age: Int;
    var name: String;
}


extension Student_t: Equatable {
    
}

extension Student_t: CustomDebugStringConvertible {
    var debugDescription: String {
        return "age = \(age), name = \(name)\n"
    }
}

// MARK: - Comparable Protocol
extension Student_t: Comparable {
    
    static func <(lhs: Student_t, rhs: Student_t) -> Bool {
        return lhs.age > rhs.age
    }
    
    static func ==(lhs: Student_t, rhs: Student_t) -> Bool {
        return lhs.age == rhs.age
    }
}


// MARK: -

class ProtocolViewController: EZBaseVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        sortedStudent_1()
        sortedStudent_2()
    }

    
    func sortedStudent_1() {
        let stu1 = Student_t(age: 21, name: "a")
        let stu2 = Student_t(age: 15, name: "b")
        let stu3 = Student_t(age: 12, name: "c")
        let stu4 = Student_t(age: 10, name: "d")
        let stuArr = [stu1, stu2, stu3, stu4]
        print(">>>>>>>>>>> befor sorted <<<<<<<<<<<")
        print(stuArr)
//        let sorted = stuArr.sorted() //升序
        let sorted = stuArr.sorted(by: >) //降序
        print(">>>>>>>>>>> after sorted <<<<<<<<<<<")
        print(sorted)
    }
    
    func sortedStudent_2() {
        let stu1 = Student_t(age: 21, name: "a")
        let stu2 = Student_t(age: 15, name: "b")
        let stu3 = Student_t(age: 12, name: "c")
        let stu4 = Student_t(age: 10, name: "d")
        var stuArr = [stu1, stu2, stu3, stu4]
        print(">>>>>>>>>>> befor sorted <<<<<<<<<<<")
        print(stuArr)
        stuArr.sort()
//        stuArr.sort(by: >)
        print(">>>>>>>>>>> after sorted <<<<<<<<<<<")
        print(stuArr)
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
