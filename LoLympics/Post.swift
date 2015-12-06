//
//  File.swift
//  LoLympics
//
//  Created by Dev1 on 12/4/15.
//  Copyright © 2015 FXoffice. All rights reserved.
//

import Foundation
import Parse

class Post {
    
    private var _featuredImg: PFFile?
    
    private var _title: String?
    
    private var _excerpt: String?
    
    private var _content: String?
    
    private var _category: String?
    
    private var _date: NSDate?
    
    private var _imageDesc: String?
    
    private var _postKey: String!
    
    var title: String? {
        return _title
    }
    
    var excerpt: String? {
        return _excerpt
    }
    
    var content: String? {
        return _content
    }
    
    var featuredImg: PFFile? {
        return _featuredImg
    }
    
    var category: String? {
        return _category
    }
    
    var date: NSDate? {
        return _date
    }
    
    var imageDesc: String? {
        return _imageDesc
    }
    
    var postKey: String? {
        return _postKey
    }
    
    init (title: String?, excerpt: String?, content: String?, featuredImg: PFFile?, category: String?, date: NSDate?, imageDesc:String?) {
        self._title = title
        self._excerpt = excerpt
        self._content = content
        self._category = category
        self._featuredImg = featuredImg
        self._date = date
        self._imageDesc = imageDesc
    }
    
    init(postKey: String, date: NSDate, dictionary: PFObject) {
        
        self._postKey = postKey
        self._date = date
        
        if let title = dictionary["title"] as? String {
            self._title = title
        }
        
        if let excerpt = dictionary["excerpt"] as? String {
            self._excerpt = excerpt
        }
        
        if let content = dictionary["content"] as? String {
            self._content = content
        }
        
        if let category = dictionary["category"] as? String {
            self._category = category
        }
        
        if let imageDesc = dictionary["imageDesc"] as? String {
            self._imageDesc = imageDesc
        }
        
        if let featuredImg = dictionary["featuredImage"] as? PFFile {
            self._featuredImg = featuredImg
        }
        

    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}