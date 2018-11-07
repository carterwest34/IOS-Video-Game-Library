//
//  Game.swift
//  iOS Video Game Library
//
//  Created by Carter West on 10/29/18.
//  Copyright © 2018 Carter West. All rights reserved.
//
import Foundation

class Game { //setup our game class where the only variables will be our title, description, and dueDtae. We will have 2 enumerations of genre and rating for our picker view and segmented controller to pull from respectively, and an enum for availability, which will only have 2 cases, checked in and checked out.
    
    var title: String
    var description: String
    var dueDate: Date? //This variable will be an optional, since there will not always be a due date, like in the case that its checked in.
    
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
    
    //setup variables and constants ready to be passed in for initializing.
    
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
