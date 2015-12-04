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
    
    private var _featuredImg: String?
    
    private var _title: String?
    
    private var _excerpt: String?
    
    private var _category: String?
    
    private var _date: String?
    
    private var _imageDesc: String?
    
    private var _postKey: String!
    
    var title: String? {
        return _title
    }
    
    var excerpt: String? {
        return _excerpt
    }
    
    var featuredImg: String? {
        return _featuredImg
    }
    
    var category: String? {
        return _category
    }
    
    var date: String? {
        return _date
    }
    
    var imageDesc: String? {
        return _imageDesc
    }
    
    init (title: String?, excerpt: String?, featuredImg: String?, category: String?, date: String?, imageDesc:String?) {
        self._title = title
        self._excerpt = excerpt
        self._category = category
        self._featuredImg = featuredImg
        self._date = date
        self._imageDesc = imageDesc
    }
    
    init(postKey: String, dictionary: PFObject) {
        self._postKey = postKey
        
        if let title = dictionary["title"] as? String {
            self._title = title
        }
        
        if let excerpt = dictionary["excerpt"] as? String {
            self._excerpt = excerpt
        }
        
        if let category = dictionary["category"] as? String {
            self._category = category
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}