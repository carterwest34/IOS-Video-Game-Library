//
//  Game.swift
//  iOS Video Game Library
//
//  Created by Carter West on 10/29/18.
//  Copyright © 2018 Carter West. All rights reserved.
//

import Foundation

class Game {
    
    var title: String
    var description: String
    var dueDate: Date?
    
    enum Genre {
        case action
        case horror
        case rpg
        case arcade
        case royale
        case fps
        case puzzle
    }
    
    enum Rating {
        case everyone
        case teen
        case mature
        case kids
        case adultsOnly
        case tenPlus
        case ratingPending
        case earlyChildhood
    }
    
    enum Availability {
        case checkedIn
        case checkedOut(dueDate: Date)
    }
    
    let genre: Genre
    let rating: Rating
    var availability: Availability
    
    init(title: String, description: String, genre: Genre, rating: Rating) {
        
        self.title = title
        self.description = description
        self.genre = genre
        self.rating = rating
        self.availability = .checkedIn
        
    }
    
   
    
}
