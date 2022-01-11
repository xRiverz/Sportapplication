//
//  SportsViewController.swift
//  Sportapplication
//
//  Created by administrator on 11/01/2022.
//

import UIKit

class SportsViewController: UITableViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let saveContext = (UIApplication.shared.delegate as! AppDelegate).saveContext
    let imageVC = UIImagePickerController()
    
    var sports : [Sport] = []
    var selectedSport : Sport!
    
    func fetchSports() {
        do{
            sports = try context.fetch(Sport.fetchRequest())
        }catch{
            print(error)
        }
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchSports()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sports.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sportCell", for: indexPath) as! SportViewCell
        
        let sport = sports[indexPath.row]
        cell.configure(sport.name, sport.image)
        
        cell.cellDelegate = self
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let item = sports[indexPath.row]
        context.delete(item)
        saveContext()
        fetchSports()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! SportViewCell
        performSegue(withIdentifier: "PlayersVC", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let playerVC = segue.destination as! PlayersViewController
        let indexPath = sender as! IndexPath
        let sport = sports[indexPath.row]
        playerVC.title = sport.name?.capitalized
        playerVC.sport = sport
    }
    
    @IBAction func addSport(_ sender:UIBarButtonItem){
        sportAlert(title: "Add Sport", message: "Enter Sport Name", sport: nil)
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        sportAlert(title:"Edit Sport",message:"Enter New Sport Name",sport:sports[indexPath.row])
    }
    
    func sportAlert(title:String,message:String,sport:Sport?){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addTextField {
            (textField) in
            textField.text = sport?.name
            textField.placeholder = "Sport Name eg.. BasketBall"
        }
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            let sportName = alert.textFields![0].text
            
            if let sport = sport {
                sport.name = sportName
            }else {
                let sport = Sport(context: self.context)
                sport.name = sportName
            }
            
            self.saveContext()
            self.fetchSports()
            
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {
            _ in
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}

extension SportsViewController : CellDelegate {
    func changeImage(_ cell: SportViewCell) {
        let selectedSportI = tableView.indexPath(for: cell)?.row ?? 0
        selectedSport = sports[selectedSportI]
        imageVC.delegate = self
        present(imageVC, animated: true, completion: nil)
        
    }
}

extension SportsViewController : UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.originalImage] as? UIImage {
            selectedSport.image = image.pngData()
            saveContext()
        }
        self.fetchSports()
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}
