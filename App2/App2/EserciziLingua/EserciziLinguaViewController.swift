//
//  EserciziLinguaViewController.swift
//  App2
//
//  Created by Franco Cirillo on 20/03/21.
//

import UIKit

class EserciziLinguaViewController: UITableViewController {

    var listaEsercizi = [String]()
    var n:Int=0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        caricamento()
    }
    func caricamento()
    {
        //carica tutte le categorie in un array
        n = Int(NSLocalizedString("numeroEsercizi", comment: "")) ?? 0
        
        for i in 0...(n-1){
            listaEsercizi.append(NSLocalizedString("esercizio\(i+1)", comment: ""))
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return listaEsercizi.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eserciziLinguaCell", for: indexPath) as! EserciziViewCell

        let esercizio=listaEsercizi[indexPath.row]
        cell.esercizio.text=esercizio
        cell.numero.text=String(indexPath.row+1)

        cell.sfondo.layer.shadowColor = UIColor.black.cgColor
        cell.sfondo.layer.shadowOpacity = 1
        cell.sfondo.layer.shadowOffset = .zero
        cell.sfondo.layer.shadowRadius = 20
        return cell
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

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        switch segue.identifier {
        case "esercizio":
            if let currentIndex=tableView.indexPathForSelectedRow?.row{
               
               let dstview=segue.destination as! EsercizioController
               let esercizio=listaEsercizi[currentIndex]
               dstview.esercizio=esercizio
            }
           
        default:
            print(#function)
        }
    }
    

}
