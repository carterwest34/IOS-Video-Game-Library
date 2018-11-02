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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    if library.games.count == 0 {
        
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        tableView.tableFooterView = UIView()
        
    }
        
        tableView.reloadData()

    }
    
    @IBAction func addGameFromLibrary(_ sender: Any) {
        performSegue(withIdentifier: "AddGameSegue", sender: self)
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
            tableView.reloadData()
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

extension LibraryViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let text = "Empty Library"
        
        let attributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18.0), NSAttributedString.Key.foregroundColor: UIColor.darkGray]
        
        return NSAttributedString(string: text, attributes: attributes)
    
    }
   
    func description(forEmptyDataSet scrollView: UIScrollView?) -> NSAttributedString? {
        let text = "There are no games in your video game library."
        
        var paragraph = NSMutableParagraphStyle()
        paragraph.lineBreakMode = .byWordWrapping
        paragraph.alignment = .center
        
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14.0), NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.paragraphStyle: paragraph]
        
        return NSAttributedString(string: text, attributes: attributes)
    }
    
    func buttonTitle(forEmptyDataSet scrollView: UIScrollView?, for state: UIControl.State) -> NSAttributedString? {
        let attributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 17.0)]
        
        return NSAttributedString(string: "Add Game", attributes: attributes)
        
    }
    
    func emptyDataSet(_ scrollView: UIScrollView?, didTap button: UIButton?) {
        performSegue(withIdentifier: "AddGameSegue", sender: self)
    }
    


}

