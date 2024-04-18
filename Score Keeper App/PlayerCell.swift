//
//  PlayerCell.swift
//  Score Keeper App
//
//  Created by Cesar Fernandez on 4/15/24.
//

import UIKit

protocol PlayerCellDelegate: AnyObject {
    func didUpdateScore(sender: PlayerCell)
}

class PlayerCell: UITableViewCell {
    
    @IBOutlet weak var playerLabel: UILabel!
    @IBOutlet weak var stepperButton: UIStepper!
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    weak var delegate: PlayerCellDelegate?
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        delegate?.didUpdateScore(sender: self)
    }
    
}

