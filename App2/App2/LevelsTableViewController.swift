//
//  LevelsTableViewController.swift
//  App2
//
//  Created by Giuseppe Pio D'Ambrosio on 16/04/21.
//


import UIKit

class LevelsTableViewController: UITableViewController, UIGestureRecognizerDelegate {

    
    var worldNumber: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //navigationController?.setNavigationBarHidden(true, animated: true)
        
        
        //navigationController?.navigationBar.isTranslucent = false
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        let insets = UIEdgeInsets(top: -80, left: 0, bottom: 20, right: 0)
        self.tableView.contentInset = insets
        
        var backImage = UIImage(named: "indietrook")
        backImage = resizeImage(image: backImage!, newWidth: 40)
        self.navigationController?.navigationBar.backIndicatorImage = backImage
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backImage
        self.navigationController?.navigationBar.tintColor = UIColor.white;

        
        self.tableView.separatorStyle = .none
        
        self.tableView.transform = CGAffineTransform(rotationAngle: -(CGFloat)(Double.pi))
        
        
        let bgImage = UIImageView()
        bgImage.image = UIImage(named: "greenscreen")
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
        return 8
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        
        if(indexPath.row % 2 == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellOdd", for: indexPath) as! LevelsTableViewCell

            // Configure the cell...
            
            cell.levelImage.image = UIImage(named: "level\(((worldNumber-1)*8)+indexPath.row+1)")
            cell.levelLabel.text = "Livello \(((worldNumber-1)*8)+indexPath.row+1)"
            
            
            if PersistenceManager.fetchData().count != 0 {
                var user = PersistenceManager.fetchData()[0]
                
                        
                if(user.lastLevel+1 <= worldNumber*8){
                    if(indexPath.row == user.lastLevel%8){
                        cell.avatarImage.image = UIImage(named: user.avatar!)
                    }
                    if(user.lastLevel%8 < indexPath.row){
                        cell.isUserInteractionEnabled = false
                        cell.levelImage.isHidden = true
                        cell.levelLabel.alpha = 0.5
                    }
                }
                
                
                switch StarsManager.fetchData()[0].value(forKey: "level\(indexPath.row+1+(worldNumber-1)*8)") as! Int16 {
                case 0:
                    cell.star1.isHidden = true
                    cell.star2.isHidden = true
                    cell.star3.isHidden = true
                case 1:
                    cell.star2.isHidden = true
                    cell.star3.isHidden = true
                case 2:
                    cell.star3.isHidden = true
                default:
                    print(#function)
                }
                
                
                /*switch indexPath.row {
                case 0:
                    switch StarsManager.fetchData()[0].level1 {
                    case 0:
                        cell.star1.isHidden = true
                        cell.star2.isHidden = true
                        cell.star3.isHidden = true
                    case 1:
                        cell.star2.isHidden = true
                        cell.star3.isHidden = true
                    case 2:
                        cell.star3.isHidden = true
                    default:
                        print(#function)
                    }
                case 2:
                    switch StarsManager.fetchData()[0].level3 {
                    case 0:
                        cell.star1.isHidden = true
                        cell.star2.isHidden = true
                        cell.star3.isHidden = true
                    case 1:
                        cell.star2.isHidden = true
                        cell.star3.isHidden = true
                    case 2:
                        cell.star3.isHidden = true
                    default:
                        print(#function)
                    }
                case 4:
                    switch StarsManager.fetchData()[0].level5 {
                    case 0:
                        cell.star1.isHidden = true
                        cell.star2.isHidden = true
                        cell.star3.isHidden = true
                    case 1:
                        cell.star2.isHidden = true
                        cell.star3.isHidden = true
                    case 2:
                        cell.star3.isHidden = true
                    default:
                        print(#function)
                    }
                case 6:
                    switch StarsManager.fetchData()[0].level7 {
                    case 0:
                        cell.star1.isHidden = true
                        cell.star2.isHidden = true
                        cell.star3.isHidden = true
                    case 1:
                        cell.star2.isHidden = true
                        cell.star3.isHidden = true
                    case 2:
                        cell.star3.isHidden = true
                    default:
                        print(#function)
                    }
                case 8:
                    switch StarsManager.fetchData()[0].level9 {
                    case 0:
                        cell.star1.isHidden = true
                        cell.star2.isHidden = true
                        cell.star3.isHidden = true
                    case 1:
                        cell.star2.isHidden = true
                        cell.star3.isHidden = true
                    case 2:
                        cell.star3.isHidden = true
                    default:
                        print(#function)
                    }
                default:
                    print(#function)
                }*/
            }
            
            if(indexPath.row == 0){
                let backImage = UIImageView()
                backImage.image = UIImage(named: "level1cell")
                cell.backgroundView = backImage
            }
            else{
                let backImage = UIImageView()
                backImage.image = UIImage(named: "livellidispari")
                cell.backgroundView = backImage
            }
            
            
            cell.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
        
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellEven", for: indexPath) as! LevelsTableViewCell

            // Configure the cell...
            
            cell.levelImage.image = UIImage(named: "level\(((worldNumber-1)*8)+indexPath.row+1)")
            cell.levelLabel.text = "Livello \(((worldNumber-1)*8)+indexPath.row+1)"
            
            if PersistenceManager.fetchData().count != 0 {
                var user = PersistenceManager.fetchData()[0]
                
                            
                if(user.lastLevel+1 <= worldNumber*8){
                    if(indexPath.row == user.lastLevel%8){
                        cell.avatarImage.image = UIImage(named: user.avatar!)
                    }
                    if(user.lastLevel%8 < indexPath.row){
                        cell.isUserInteractionEnabled = false
                        cell.levelImage.isHidden = true
                        cell.levelLabel.alpha = 0.5
                    }
                }
            }
            
            switch StarsManager.fetchData()[0].value(forKey: "level\(indexPath.row+1+(worldNumber-1)*8)") as! Int16 {
            case 0:
                cell.star1.isHidden = true
                cell.star2.isHidden = true
                cell.star3.isHidden = true
            case 1:
                cell.star2.isHidden = true
                cell.star3.isHidden = true
            case 2:
                cell.star3.isHidden = true
            default:
                print(#function)
            }
            
            /*switch indexPath.row {
            case 1:
                switch StarsManager.fetchData()[0].level2 {
                case 0:
                    cell.star1.isHidden = true
                    cell.star2.isHidden = true
                    cell.star3.isHidden = true
                case 1:
                    cell.star2.isHidden = true
                    cell.star3.isHidden = true
                case 2:
                    cell.star3.isHidden = true
                default:
                    print(#function)
                }
            case 3:
                switch StarsManager.fetchData()[0].level4 {
                case 0:
                    cell.star1.isHidden = true
                    cell.star2.isHidden = true
                    cell.star3.isHidden = true
                case 1:
                    cell.star2.isHidden = true
                    cell.star3.isHidden = true
                case 2:
                    cell.star3.isHidden = true
                default:
                    print(#function)
                }
            case 5:
                switch StarsManager.fetchData()[0].level6 {
                case 0:
                    cell.star1.isHidden = true
                    cell.star2.isHidden = true
                    cell.star3.isHidden = true
                case 1:
                    cell.star2.isHidden = true
                    cell.star3.isHidden = true
                case 2:
                    cell.star3.isHidden = true
                default:
                    print(#function)
                }
            case 7:
                switch StarsManager.fetchData()[0].level8 {
                case 0:
                    cell.star1.isHidden = true
                    cell.star2.isHidden = true
                    cell.star3.isHidden = true
                case 1:
                    cell.star2.isHidden = true
                    cell.star3.isHidden = true
                case 2:
                    cell.star3.isHidden = true
                default:
                    print(#function)
                }
            case 9:
                switch StarsManager.fetchData()[0].level10 {
                case 0:
                    cell.star1.isHidden = true
                    cell.star2.isHidden = true
                    cell.star3.isHidden = true
                case 1:
                    cell.star2.isHidden = true
                    cell.star3.isHidden = true
                case 2:
                    cell.star3.isHidden = true
                default:
                    print(#function)
                }
            default:
                print(#function)
            }*/
                
        
            if(indexPath.row == 7){
                let backImage = UIImageView()
                backImage.image = UIImage(named: "level10cell")
                cell.backgroundView = backImage
            }
            else{
                let backImage = UIImageView()
                backImage.image = UIImage(named: "livellipari")
                cell.backgroundView = backImage
            }
            
            cell.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
            
            return cell
        }
    }
    
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage? {

        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
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
