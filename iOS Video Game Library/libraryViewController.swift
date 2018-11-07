//
//  libraryViewController.swift
//  iOS Video Game Library
//
//  Created by Carter West on 10/29/18.
//  Copyright © 2018 Carter West. All rights reserved.
//
import UIKit
import DZNEmptyDataSet

class LibraryViewController: UIViewController {
    
    //MARK IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    
    let library = Library.sharedInstance
    
    override func viewDidLoad() { //We want to set up the empty view delegate, data source, and get rid of the lines in the table view only if there are no games in our library.
        super.viewDidLoad()
        
        if library.games.count == 0 {
            
            tableView.emptyDataSetSource = self
            tableView.emptyDataSetDelegate = self
            tableView.tableFooterView = UIView()
            
        }
        
        //reload data after we setup the empty view for viewing.
        tableView.reloadData()
        
    }
  
    //sugue to add game view controller from the bar button item in the top right
    @IBAction func addGameFromLibrary(_ sender: Any) {
        performSegue(withIdentifier: "AddGameSegue", sender: self)
    }
    
    //setup dueDate to be 7 days from the present, set the availability to .checkedOut, and change the view through the setup function.
    func checkOut(at indexPath: IndexPath) {
        let game = self.library.games[indexPath.row]
        let calendar = Calendar(identifier: .gregorian)
        let dueDate = calendar.date(byAdding: .day, value: 7, to: Date())!
        
        game.availability = .checkedOut(dueDate: dueDate)
        (tableView.cellForRow(at: indexPath) as! LibraryCellTableViewCell).setup(game: game)
    }
    
    //setup game, set the availabiltiy to checkedIn, and change thee viee through our setup function.
    func checkIn(at indexPath: IndexPath) {
        let game = self.library.games[indexPath.row]
        game.availability = .checkedIn
        (tableView.cellForRow(at: indexPath) as! LibraryCellTableViewCell).setup(game: game)
    }
    
}

extension LibraryViewController: UITableViewDelegate, UITableViewDataSource {
    
    //we want as many rows in our library as there are games in it.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return library.games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //make sure to deque reusable cell so that the cells can be used an indefinite amount of times setup the cell, then return it.
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! LibraryCellTableViewCell
        
        let game = library.games[indexPath.row]
        
        cell.setup(game: game)
        
        return cell
        
    }
    
    //sets up a new tab in our view, name it delete. This will delete the corresponding row.
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { _, indexPath in
            Library.sharedInstance.games.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.reloadData()
        }
        
        let game = library.games[indexPath.row]
        
        //switch on availability. If the game associated with the current row is checked out, the view will say check in, and visa versa.
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
    
    
    
    //overrides viewDidAppear to physically show the new game being appended to the library.
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        tableView.reloadData()
    }
    
}

extension LibraryViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    //setup text for empty view title
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let text = "Empty Library"
        
        let attributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18.0), NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        
        return NSAttributedString(string: text, attributes: attributes)
        
    }
    
    //setup text for empty view description
    func description(forEmptyDataSet scrollView: UIScrollView?) -> NSAttributedString? {
        let text = "There are no games in your video game library."
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineBreakMode = .byWordWrapping
        paragraph.alignment = .center
        
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14.0), NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.paragraphStyle: paragraph]
        
        return NSAttributedString(string: text, attributes: attributes)
    }
    
    //setup text for empty library button title
    func buttonTitle(forEmptyDataSet scrollView: UIScrollView?, for state: UIControl.State) -> NSAttributedString? {
        let attributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17.0)]
        
        return NSAttributedString(string: "Add Game", attributes: attributes)
        
    }
    
    //add segue function to the add game view controller from the add game button
    func emptyDataSet(_ scrollView: UIScrollView?, didTap button: UIButton?) {
        performSegue(withIdentifier: "AddGameSegue", sender: self)
    }
    
    
    
}

