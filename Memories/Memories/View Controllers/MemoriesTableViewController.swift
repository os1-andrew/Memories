//
//  MemoriesTableViewController.swift
//  Memories
//
//  Created by Andrew Liao on 8/1/18.
//  Copyright © 2018 Andrew Liao. All rights reserved.
//

import UIKit

class MemoriesTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        memoryController.loadFromPersistentStore()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memoryController.memories.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemoryCell", for: indexPath)
        let title = memoryController.memories[indexPath.row].title
        let imageData =  memoryController.memories[indexPath.row].imageData
        
        cell.imageView?.image = UIImage(data: imageData)
        cell.textLabel?.text = title
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            let memory = memoryController.memories[indexPath.row]
            memoryController.delete(memory: memory)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? MemoryDetailViewController else {return}
       
        if segue.identifier == "ShowMemoryDetail"{
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            detailVC.memoryController = memoryController
            detailVC.memory = memoryController.memories[indexPath.row]
        }
        if segue.identifier == "AddMemory"{
            detailVC.memoryController = memoryController
        }
    }

    let memoryController = MemoryController()
    

}
