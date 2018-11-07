
//
//  Library.swift
//  iOS Video Game Library
//
//  Created by Carter West on 10/29/18.
//  Copyright © 2018 Carter West. All rights reserved.
//
import Foundation

class Library {
    
    //we setup a shared instance of our library array for all our files to pull from
    static let sharedInstance = Library()
    
    //setup empty game array.
    var games = [Game]()
}
