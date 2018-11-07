
//
//  LibraryCellTableViewCell.swift
//  iOS Video Game Library
//
//  Created by Carter West on 11/1/18.
//  Copyright © 2018 Carter West. All rights reserved.
//
import UIKit

class LibraryCellTableViewCell: UITableViewCell {
    
    //MARK: IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var availabilityView: UIView!
    
    
    //this function sets up the labels in our library cell
    func setup(game: Game) {
        
        titleLabel.text = game.title //titleLabel pulls straight from the title given to the game
        
        switch game.genre { //switch on all the genres of the enum, based on the string of the selected genre from the picker view
        case .action:
            genreLabel.text = "Action"
        case .horror:
            genreLabel.text = "Horror"
        case .arcade:
            genreLabel.text = "Arcade"
        case .fps:
            genreLabel.text = "FPS"
        case .rpg:
            genreLabel.text = "RPG"
        case .puzzle:
            genreLabel.text = "Puzzle"
        case .royale:
            genreLabel.text = "Battle Royale"
        }
        
        switch game.rating {
        case .kids:
            ratingLabel.text = "K"
        case .adultsOnly:
            ratingLabel.text = "AO"
        case .everyone:
            ratingLabel.text = "E"
        case .mature:
            ratingLabel.text = "M"
        case .tenPlus:
            ratingLabel.text = "10+"
        case .teen:
            ratingLabel.text = "T"
        default:
            ratingLabel.text = "T"
        }
        
        switch game.availability { //switch on availability. if its checked in, the background color will be green, and the date will no longer be hidden.
        case .checkedIn:
            
            dateLabel.isHidden = true
            availabilityView.backgroundColor = .green
            
        case .checkedOut(let date): //if its checked out, the background color will be red, the date label will be revealed, and the text of that label is formatted and setup.
            
            dateLabel.isHidden = false
            availabilityView.backgroundColor = .red
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            dateLabel.text = dateFormatter.string(from: date)
            
        }
    }
    
}
