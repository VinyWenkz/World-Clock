//
//  Utils.swift
//  World Clock
//
//  Created by DGBendicion on 7/23/15.
//  Copyright (c) 2015 DGBendicion. All rights reserved.
//

import Foundation

class Utils {
    
    static func stripFilenameExtension(filename: String) -> String {
        let pathExtention = filename.pathExtension
        return filename.stringByDeletingPathExtension
    }
}
