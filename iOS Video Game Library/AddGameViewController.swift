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
        self.genrePickerView.dataSource = self
        self.genrePickerView.delegate = self
    }

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
        let title = titleTextField.text, !title.isEmpty
            else {
            let errorAlert = UIAlertController(title: "Error", message: "Please enter text into every text field to successfully enter a game", preferredStyle: .alert)
            let errorAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default)
            errorAlert.addAction(errorAction)
            self.present(errorAlert, animated: true, completion: nil)
            return
        }
        let newGame = Game(title: title, description: descriptionTextField.text!, genre: getGenreInput(selectedGenre), rating: getRatingInput(ratingSegmentedController.selectedSegmentIndex))
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



extension AddGameViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genres.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genres[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedGenre = genres[row]
    }
    
}

