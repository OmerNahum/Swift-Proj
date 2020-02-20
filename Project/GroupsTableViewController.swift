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
        
        
        ModelEvents.GroupDataEvent.observe {
            self.reloadData();
        }
        reloadData();
        
        
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
        
        
        cell.imageCell.image = UIImage(named: "avatar")
        if group.image != ""{
            cell.imageCell.kf.setImage(with: URL(string: group.image));
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
    }
    
    
    
    
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
