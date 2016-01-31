//
//  Functions.swift
//  MyLocations
//
//  Created by Antonio Alves on 1/31/16.
//  Copyright © 2016 Antonio Alves. All rights reserved.
//

import Foundation
import Dispatch

func afterDelay(seconds: Double, closure:() -> ()) {
    let when = dispatch_time(DISPATCH_TIME_NOW, Int64(seconds * Double(NSEC_PER_SEC)))
    dispatch_after(when, dispatch_get_main_queue(), closure)
}