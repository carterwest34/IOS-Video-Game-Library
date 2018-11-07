//
//  AddGameViewController.swift
//  iOS Video Game Library
//
//  Created by Carter West on 10/29/18.
//  Copyright © 2018 Carter West. All rights reserved.
//
import UIKit

class AddGameViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //setup data source and delegate for the picker view.
        self.genrePickerView.dataSource = self
        self.genrePickerView.delegate = self
    }
    
    //give selected genre a default value of action, since that is the row picked by default.
    var selectedGenre: String = "Action"
    let genres = ["Action", "Horror", "RPG", "Royale", "FPS", "Puzzle"]
    
    //MARK: IBOutlets
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var genrePickerView: UIPickerView!
    @IBOutlet weak var ratingSegmentedController: UISegmentedControl!
    
    //MARK: IBActions
    @IBAction func addGameButtonPressed(_ sender: Any) {
        guard
            let title = titleTextField.text, !title.isEmpty //validation to make sure the user entered something into the title text field.
            else { //if the text field is empty...
                let errorAlert = UIAlertController(title: "Error", message: "Please enter text into the title text field to successfully enter a game", preferredStyle: .alert)
                let errorAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) //this alert action will have no function. it will just didmiss the alert when pressed
                errorAlert.addAction(errorAction)
                self.present(errorAlert, animated: true, completion: nil)
                return
        }
        
        //setup new game constant to be appended to the library
        let newGame = Game(title: title, description: descriptionTextField.text!, genre: getGenreInput(selectedGenre), rating: getRatingInput(ratingSegmentedController.selectedSegmentIndex))
        //this alert notifies the user that their game has been added successfully, as well as segue the user back to the library screen after pressing the alert action.
        let addAlert = UIAlertController(title: "Game Added!", message: "You have added \(String(describing: titleTextField.text!))", preferredStyle: .alert)
        let addAction = UIAlertAction(title: "Thanks", style: .default)
        {UIAlertAction in
            Library.sharedInstance.games.append(newGame)
            self.navigationController?.popViewController(animated: true)
        }
        addAlert.addAction(addAction)
        self.present(addAlert, animated: true, completion: nil)
    }
    
    //MARK: Functions
    
    //this function will switch on index, which is a string. it returns a .(genre) that goes with a given string that will also be passed in to the addGame constant.
    func getGenreInput(_ index: String) -> Game.Genre {
        switch index {
        case "Action":
            return .action
        case "Arcade":
            return .arcade
        case "FPS":
            return .fps
        case "Puzzle":
            return .puzzle
        case "Royale":
            return .royale
        case "Horror":
            return .horror
        case "RPG":
            return .rpg
        default:
            return .action
        }
    }
    
    //this function switches on an integer index, which corresponds with the index of the segmented controller. this value returns a rating to be passed into the newGame constant.
    func getRatingInput(_ index: Int) -> Game.Rating {
        switch index {
        case 0:
            return .teen
        case 1:
            return .mature
        case 2:
            return .everyone
        case 3:
            return .adultsOnly
        case 4:
            return .tenPlus
        case 5:
            return .ratingPending
        case 6:
            return .earlyChildhood
        case 7:
            return .kids
        default:
            return .teen
        }
    }
}



extension AddGameViewController: UIPickerViewDelegate, UIPickerViewDataSource { //extension that separates the picker view from the rest of the class
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 //only 1 group of genres were picking from
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genres.count //the number of rows should be the number of genres we have in our genre array
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genres[row] //the name for each row should be the name of the genre at the index of row in the genre array
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedGenre = genres[row] //gives a selected genre to pass into our newGame constant.
    }
    
}
