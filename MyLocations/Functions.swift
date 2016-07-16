//
//  Functions.swift
//  MyLocations
//
//  Created by Antonio Alves on 1/31/16.
//  Copyright © 2016 Antonio Alves. All rights reserved.
//

import Foundation
import Dispatch

func afterDelay(_ seconds: Double, closure:() -> Void) {
    let when = DispatchTime.now() + Double(Int64(seconds * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
    DispatchQueue.main.after(when: when, execute: closure)
}
let applicationDocumentsDirectory: String = {
    let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    return paths[0]
}()
