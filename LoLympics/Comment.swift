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
    
    private var _avatar: PFFile?
    
    private var _author: String?
    
    private var _text: String?
    
    private var _date: NSDate?

    
    var text: String? {
        return _text
    }
    
    var avatar: PFFile? {
        return _avatar
    }
    
    var author: String? {
        return _author
    }
    
    var date: NSDate? {
        return _date
    }
    
    init (text: String?, avatar: PFFile?, author:String?, date: NSDate?) {
        self._text = text
        self._author = author
        self._avatar = avatar
        self._date = date
    }
    
    init(date: NSDate, dictionary: PFObject) {
        
        self._date = date
        
        if let text = dictionary["text"] as? String {
            self._text = text
        }
        
        if let author = dictionary["author"] as? String {
            self._author = author
        }
        
        if let avatar = dictionary["avatar"] as? PFFile {
            self._avatar = avatar
        }
        
        
    }

}