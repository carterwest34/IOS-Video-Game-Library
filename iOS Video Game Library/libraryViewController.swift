//
//  libraryViewController.swift
//  iOS Video Game Library
//
//  Created by Carter West on 10/29/18.
//  Copyright © 2018 Carter West. All rights reserved.
//

import UIKit

class LibraryViewController: UIViewController {
    
    //MARK IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    
    let library = Library.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        library.games.append(Game(title: "Red Dead Redemption 2", description: "10/10", genre: .action, rating: .mature))
        
        library.games.append(Game(title: "Fallout 76", description: "Spicy", genre: .action, rating: .mature))
        
        library.games.append(Game(title: "Black Ops 4", description: "Zombies is good", genre: .action, rating: .mature))
        
        tableView.reloadData()
    }
    
    func checkOut(at indexPath: IndexPath) {
        let game = self.library.games[indexPath.row]
        
        let calendar = Calendar(identifier: .gregorian)
        let dueDate = calendar.date(byAdding: .day, value: 7, to: Date())!
        
        game.availability = .checkedOut(dueDate: dueDate)
        (tableView.cellForRow(at: indexPath) as! LibraryCellTableViewCell).setup(game: game)
    }
    
    func checkIn(at indexPath: IndexPath) {
        let game = self.library.games[indexPath.row]
        game.availability = .checkedIn
        (tableView.cellForRow(at: indexPath) as! LibraryCellTableViewCell).setup(game: game)
    }
    
}

extension LibraryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return library.games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! LibraryCellTableViewCell
        
        let game = library.games[indexPath.row]
        
        cell.setup(game: game)
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { _, indexPath in
            Library.sharedInstance.games.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        let game = library.games[indexPath.row]
        
        // If the game is checked out, we create and return the check in action.
        // If the game is checked in, we create and return the check out action.
        
        switch game.availability {
        case .checkedIn:
            let checkOutAction = UITableViewRowAction(style: .normal, title: "Check Out") { _, indexPath in
                
                self.checkOut(at: indexPath)
                
            }
            
            return [checkOutAction, deleteAction]
            
        case .checkedOut:
            let checkInAction = UITableViewRowAction(style: .normal, title: "Check In") { _, indexPath in
                self.checkIn(at: indexPath)
            }
            
            return [checkInAction, deleteAction]
            
        }
    }
        
      
    
    //create check out the check out and check in functions
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        tableView.reloadData()
    }
    
}

