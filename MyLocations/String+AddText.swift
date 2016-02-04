//
//  String+AddText.swift
//  MyLocations
//
//  Created by Antonio Alves on 2/3/16.
//  Copyright © 2016 Antonio Alves. All rights reserved.
//

import Foundation

extension String {
    mutating func addText(text:String?, withSeparator separator:String = "") {
        if let text = text {
            if !isEmpty {
                self += separator
            }
            self += text
        }
    }
}