//
//  PlayerDetailViewController.swift
//  Score Keeper App
//
//  Created by Cesar Fernandez on 4/16/24.
//

import UIKit

class PlayerDetailViewController: UIViewController {
    
    var player: Player?
    
    @IBOutlet weak var playerNameTextField: UITextField!
    @IBOutlet weak var currentScoreTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let player = player {
            navigationItem.title = "Player"
            playerNameTextField.text = player.player
            
            updateSaveButtonState()
        }
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "saveUnwind" else { return }
        
        let textField = playerNameTextField.text!
        let currentScore = currentScoreTextField.text
        
        if player != nil {
            player?.player = textField
            player?.score = Int(currentScore ?? "0") ?? 0
        } else {
            player = Player(player: textField, score: Int(currentScore ?? "0") ?? 0)
        }
    }
    
    func updateSaveButtonState() {
        let shouldEnableSaveButton = ((playerNameTextField.text?.isEmpty) != nil) || currentScoreTextField.text?.isEmpty == false
        saveButton.isEnabled = shouldEnableSaveButton
    }
    
}

