//
//  GroupsTableViewController.swift
//  Project
//
//  Created by admin on 26/12/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import Kingfisher

class GroupsTableViewController: UITableViewController {

    var data = [Group]()
    override func viewDidLoad() {
        super.viewDidLoad()
        //data = Model.instance.getAllGroups()
        
        ModelEvents.GroupDataEvent.observe {
            self.reloadData();
        }
        reloadData();
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
   
        
    }
    
    func reloadData(){
        Model.instance.getAllGroups {(_data: [Group]?) in
            if (_data != nil){
                self.data = _data!
                self.tableView.reloadData()
            }
        }
    }
    @IBAction func favButton(_ sender: Any) {
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: GroupViewCell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as! GroupViewCell

        let group = data[indexPath.row]
        cell.groupName.text = group.name
//        if(group.image == ""){
//            //cell.imageCell.image = UIImage(named: "avatar");
//        }else {
//            cell.imageCell.kf.setImage(with: URL(string: group.image ?? <#default value#>));
//    }
        cell.imageCell.image = UIImage(named: "avatar")
        if group.image != ""{
            cell.imageCell.kf.setImage(with: URL(string: group.image));
        }
          return cell
    }
     override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        return 100
    }
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ChatGroupSegue"){
            let vc: ChatViewController = segue.destination as! ChatViewController
            vc.group = selected
            
        }
    }
    
    
    var selected:Group?
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selected = data[indexPath.row]
        performSegue(withIdentifier: "ChatGroupSegue", sender: self)
    }

}
