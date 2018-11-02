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
    
    func setup(game: Game) {
        
        titleLabel.text = game.title
        
        switch game.genre {
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
        default:
            genreLabel.text = "Action"
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
        
        switch game.availability {
        case .checkedIn:
            dateLabel.isHidden = true
            availabilityView.backgroundColor = .green
        case .checkedOut(let date):
            availabilityView.isHidden = false
            availabilityView.backgroundColor = .red
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            dateLabel.text = dateFormatter.string(from: date)
        }
    }
    
}
