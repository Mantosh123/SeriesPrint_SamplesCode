import UIKit

var greeting = "Hello, playground"

//Print Series:
//1,A,2,B,3,C,4,D,5,E,6,F,7,G,8,H,9,I,10,J,11,K,12,L,13,M,14,N,15,O,16,P,17,Q,18,R,19,S,20,T,21,U,22,V,23,W,24,X,25,Y,26,Z,

let numberSemaphore = DispatchSemaphore(value: 1)
let alphabetSemaphore = DispatchSemaphore(value: 0)

let numberQueue = DispatchQueue(label: "com.mantosh.sampleCode")
let alphabetQueue = DispatchQueue(label: "com.mantosh.samplecodeAlpha")

func printNumber() {
    for index in 1...26 {
        numberSemaphore.wait()
        print(index, terminator: ",")
        alphabetSemaphore.signal()
    }
}
func printAlphabet() {
    for char in 0..<26 {
        alphabetSemaphore.wait()
        let char = Character(UnicodeScalar (65 + char)!)
        print(char, terminator: ",")
        numberSemaphore.signal()
    }
}
numberQueue.async {
 printNumber()
}

alphabetQueue.async {
    printAlphabet()
}

RunLoop.current.run(until: Date(timeIntervalSinceNow: 2))
