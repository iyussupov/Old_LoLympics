//
//  Comment.swift
//  LoLympics
//
//  Created by Ingwar on 12/6/15.
//  Copyright © 2015 FXoffice. All rights reserved.
//

import Foundation
import Parse

class Comment {
    
    private var _author: PFUser?
    
    private var _text: String?
    
    private var _date: NSDate?

    
    var text: String? {
        return _text
    }
    
    var author: PFUser? {
        return _author
    }
    
    var date: NSDate? {
        return _date
    }
    
    init (text: String?, author:PFUser?, date: NSDate?) {
        self._text = text
        self._author = author
        self._date = date
    }
    
    init(date: NSDate, dictionary: PFObject) {
        
        self._date = date
        
        if let text = dictionary["text"] as? String {
            self._text = text
        }
        
        if let author = dictionary["author"] as? PFUser {
            self._author = author
        }
        
        
    }
}