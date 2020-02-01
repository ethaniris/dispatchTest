//
//  ViewController.swift
//  dispatchTest
//
//  Created by Ethan on 2020/1/9.
//  Copyright © 2020 playplay. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //用group沒有enter() / leave() group notify不會在最後, 前方一樣會不按照順序
        //用group用了enter() / leave() group notify會在最後, 但前方一樣不會按照順序
        //用group用了enter() / leave() / wait() group notify會在最後, 前方按照順序
        
        let numbers = ["1","2","3","4"]
        let letters = ["a","b","c","d"]
        let stars = ["@","#","$","%"]
        
        let task1 = DispatchQueue(label: "addNum")
        let task2 = DispatchQueue(label: "addLetter")
        let task3 = DispatchQueue(label:"addStars")
        
        //let semaphore = DispatchSemaphore(value: 0)
        let group = DispatchGroup()
        
        var outputString = ""
        
        group.enter()
        task1.async(group: group, qos: .default, flags: .init()) {
           //print("1-start")
            for n in numbers {
                outputString.append(n)
            }
            
            //print("1-end")
          //  semaphore.signal()
            
            
            group.leave()
        }
        group.wait()
        
        group.enter()
        //semaphore.wait()
        task2.async(group: group, qos: .default, flags: .init()) {
            //print("2-start")
           
            for l in letters {
                outputString.append(l)
            }
            //print("2-end")
            
            group.leave()
            
          //  semaphore.signal()
        }
        
        group.wait()
        group.enter()
        //semaphore.wait()
        
        task3.async(group: group, qos: .default, flags: .init()) {
            //print("3-start")
           
            for s in stars {
                outputString.append(s)
            }
            //print("3-end")
            group.leave()
            //semaphore.signal()
        }
        

        //semaphore.wait()
        group.notify(queue: .main) {
            //print("4-start")
//print(outputString)
        }
        
        
        myFunction("Hello World") { (string) in
     //       print(string)
        }
        
        let num = [1,2,3,4,5]
//        let doubleNum = num.map { (int) -> Int in
//            return int * 2
//        }
        
        let doubleNum = num.map{$0 * 2}
        //print(doubleNum)

        //reduce()那是一個初始賦予值
//        let reduceNum = num.reduce(100) { (a, b) -> Int in
//
//            return a + b
//        }
        let reduceNum = num.reduce(400){$0 + $1}
        //print(reduceNum)
        
        //flatMap會排除nil值
        
        let chainNumbers = [1,nil,2,nil,3]
        let doubleChainNumbers = chainNumbers.compactMap{$0}.filter{$0 > 1}.reduce(0){$0 + $1}
        //print(doubleChainNumbers)
        
        var string1 = "good"
        var string2 = "bad"
        swapAnything(&string1, &string2)
        //print(string1)
        
        
        
        let serialQueue = DispatchQueue(label: "con", qos: .userInitiated, attributes: .concurrent, autoreleaseFrequency: .workItem, target: nil)

        serialQueue.async(flags:.barrier) {
            print("1")
            print(Thread.isMainThread)
        }
        serialQueue.async(flags:.barrier) {
             print("2")
             print(Thread.isMainThread)
         }
        serialQueue.async(flags:.barrier) {
             print("3")
             print(Thread.isMainThread)
         }
        serialQueue.async(flags:.barrier) {
             print("4")
             print(Thread.isMainThread)
         }
        
    }
    
    func myFunction(_ stringParameter: String, closureParameter: (String) -> ()) {
        closureParameter(stringParameter)
    }
    
    
    
    func swapAnything<T>(_ a:inout T, _ b:inout T){
        let tempB = b
        b = a
        a = tempB
    }

}



protocol Animal{
    func makeSound()
    func move()
}





struct Tiger:Animal{
    func makeSound() {
        
    }
    
    func move() {

    }
    
    
    
}

