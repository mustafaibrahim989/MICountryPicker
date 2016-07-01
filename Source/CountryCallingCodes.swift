//
//  CountryCallingCodes.swift
//  MICountryPicker
//
//  Created by Mustafa Ibrahim on 6/30/16.
//  Copyright © 2016 Mustafa Ibrahim. All rights reserved.
//

import Foundation

let CallingCodes = { () -> [[String: String]] in
    guard let path = NSBundle.mainBundle().pathForResource("CallingCodes", ofType: "plist") else { return [] }
    return NSArray(contentsOfFile: path) as! [[String: String]]
}()
