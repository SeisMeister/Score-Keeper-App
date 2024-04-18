//
//  Player.swift
//  Score Keeper App
//
//  Created by Cesar Fernandez on 4/15/24.
//

import Foundation


struct Player: Comparable, Codable {
    
    var id = UUID()
    var player: String
    var score: Int
    
    static let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL = documentsDirectory.appendingPathComponent("players").appendingPathExtension("plist")
    
    static func ==(lhs: Player, rhs: Player) -> Bool {
        return lhs.id == rhs.id
    }
    
    static func < (lhs: Player, rhs: Player) -> Bool {
        lhs.score < rhs.score
    }
    
    static func loadPlayers() -> [Player]? {
        guard let codedPlayers = try? Data(contentsOf: archiveURL) else { return nil }
        
        let propertyListDecoder = PropertyListDecoder()
        return try? propertyListDecoder.decode(Array<Player>.self, from: codedPlayers)
    }
    
    static func savePlayers(_ players: [Player]) {
        let propertyListEncoder = PropertyListEncoder()
        let codedPlayers = try? propertyListEncoder.encode(players)
        try? codedPlayers?.write(to: archiveURL, options: .noFileProtection)
    }
    
    static func loadSamplePlayers() -> [Player] {
        let player1 = Player(player: "Player One", score: 12)
        let player2 = Player(player: "Player Two", score: 45)
        let player3 = Player(player: "Player Three", score: 99)
        
        return [player1, player2, player3]
        
    }
}
