//
//  ViewController.swift
//  Sportapplication
//
//  Created by administrator on 11/01/2022.
//

import UIKit

class PlayersViewController: UITableViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let saveContext = (UIApplication.shared.delegate as! AppDelegate).saveContext
    
    var sport:Sport!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sport.players?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        if let player = sport.players?[indexPath.row] as? Player {
            cell.textLabel?.text = "\(player.name ?? "") - \(player.age ?? "") - \(player.height ?? "")"
        }
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let player = sport.players?[indexPath.row] as! Player
        playerAlert(title:"Edit Player",message:"Enter New Details",player:player)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let player = sport.players?[indexPath.row] as! Player
        sport.removeFromPlayers(player)
        saveContext()
        tableView.reloadData()
    }
    
    @IBAction func addPlayer(){
        playerAlert(title:"Add Player",message:"Enter Player Details",player:nil)
    }
    
    func playerAlert(title:String,message:String,player:Player?){
        let alert = UIAlertController(title: "Add Player", message: "Enter Player Details:", preferredStyle: .alert)
        
        alert.addTextField {
            (textField) in
            textField.text = player?.name
            textField.placeholder = "Player Name"
        }
        
        alert.addTextField {
            (textField) in
            textField.text = player?.age
            textField.placeholder = "Player Age"
        }
        
        alert.addTextField {
            (textField) in
            textField.text = player?.height
            textField.placeholder = "Player Height"
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let playerName = alert?.textFields![0].text
            let playerAge = alert?.textFields![1].text
            let playerHeight = alert?.textFields![2].text
            
            if let player = player{
                player.name = playerName
                player.age = playerAge
                player.height = playerHeight
                player.sport = self.sport
            }else{
                let player = Player(context: self.context)
                player.name = playerName
                player.age = playerAge
                player.height = playerHeight
                player.sport = self.sport
            }
            
            
            self.saveContext()
            self.tableView.reloadData()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {
            _ in
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}
