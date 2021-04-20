//
//  LevelsTableViewController.swift
//  App2
//
//  Created by Giuseppe Pio D'Ambrosio on 16/04/21.
//

import UIKit

class LevelsTableViewController: UITableViewController {

    var worldNumber: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.separatorStyle = .none
        
        let bgImage = UIImageView()
        bgImage.image = UIImage(named: "green3.jpg")
        bgImage.contentMode = .scaleToFill
        self.tableView?.backgroundView = bgImage
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 10
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if(indexPath.row % 2 == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellOdd", for: indexPath) as! LevelsTableViewCell

            // Configure the cell...
            if PersistenceManager.fetchData().count != 0 {
                var user = PersistenceManager.fetchData()[0]
                            
                if(user.lastLevel+1 <= worldNumber*10){
                    if(indexPath.row == user.lastLevel%10+1){
                        cell.avatarImage.image = UIImage(named: user.avatar!)
                    }
                }
            }
            cell.levelImage.image = UIImage(named: "level\(((worldNumber-1)*10)+indexPath.row+1)")
            cell.levelLabel.text = "Livello \(((worldNumber-1)*10)+indexPath.row+1)"
        
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellEven", for: indexPath) as! LevelsTableViewCell

            // Configure the cell...
            if PersistenceManager.fetchData().count != 0 {
                var user = PersistenceManager.fetchData()[0]
                            
                if(user.lastLevel+1 <= worldNumber*10){
                    if(indexPath.row == user.lastLevel%10+1){
                        cell.avatarImage.image = UIImage(named: user.avatar!)
                    }
                }
            }
            cell.levelImage.image = UIImage(named: "level\(((worldNumber-1)*10)+indexPath.row+1)")
            cell.levelLabel.text = "Livello \(((worldNumber-1)*10)+indexPath.row+1)"
        
            return cell
        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

     //In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        switch segue.identifier{
        case "selectedLevel":
            if let currentIndex = tableView.indexPathForSelectedRow?.row{
                let level = currentIndex+1
                let dstView = segue.destination as! MondoViewController
                dstView.levelNumber = level
                dstView.worldNumber = worldNumber
            }
        default: print(#function)
        }
    }
    

}
