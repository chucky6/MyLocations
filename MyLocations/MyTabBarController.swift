//
//  MyTabBarController.swift
//  MyLocations
//
//  Created by Antonio Alves on 2/3/16.
//  Copyright © 2016 Antonio Alves. All rights reserved.
//

import UIKit

class MyTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override func childViewControllerForStatusBarStyle() -> UIViewController? {
        return nil
    }

}
