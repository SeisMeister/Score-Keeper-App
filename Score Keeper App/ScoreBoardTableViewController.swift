//
//  ScoreBoardTableViewController.swift
//  Score Keeper App
//
//  Created by Cesar Fernandez on 4/15/24.
//

import UIKit

class ScoreBoardTableViewController: UITableViewController, PlayerCellDelegate {
    func didUpdateScore(sender: PlayerCell) {
        if let indexPath = tableView.indexPath(for: sender) {
            players[indexPath.row].score = Int(sender.stepperButton.value)
            updateSortTable()
            Player.savePlayers(players)
        }
    }
    
    var players = [Player]()
        
    override func viewDidLoad() {
        super.viewDidLoad()

        if let savedPlayers = Player.loadPlayers() {
            players = savedPlayers
        } else {
            players = Player.loadSamplePlayers()
        }
        
        players.sort(by: >)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath) as! PlayerCell
        
        let player = players[indexPath.row]
        
        cell.delegate = self
        cell.playerLabel.text = player.player
        cell.scoreLabel.text = String(player.score)
        cell.stepperButton.value = Double(player.score)
        
        return cell
    }
    
    func updateSortTable() {
        players.sort(by: >)
        tableView.reloadData()
    }
    
    
    @IBAction func unwindToScoreBoard(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveUnwind" else { return }
        let sourceViewController = segue.source as! PlayerDetailViewController
        
        if let player = sourceViewController.player {
            if let indexOfExistingPlayer = players.firstIndex(of: player) {
                players[indexOfExistingPlayer] = player
                tableView.reloadRows(at: [IndexPath(row: indexOfExistingPlayer, section: 0)], with: .automatic)
            } else {
                let newIndexPath = IndexPath(row: players.count, section: 0)
                players.append(player)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        }
        updateSortTable()
        Player.savePlayers(players)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    

    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            players.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            Player.savePlayers(players)
        }
    }
    
}

