//
//  Message.swift
//  conciergebeta
//
//  Created by Max Suvorov on 29.10.16.
//  Copyright © 2016 Max Suvorov. All rights reserved.
//

import Foundation


struct Message {
    var text: String?
    var author: String?
    var date: String?
    var readByReceiver: Bool?
    
    init(dictionary: NSDictionary) {
        /* For cases when JSON is loaded... */
    }
    
    init(text: String) {
        self.text = text
    }
}
