//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var itemArray = [Item]()
    let constants = Constant()
    let defaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item(title: "Find Mike", done: false)
        let newItem1 = Item(title: "Buy bread", done: false)
        let newItem2 = Item(title: "Be sweety pie", done: false)
        itemArray.append(newItem)
        itemArray.append(newItem1)
        itemArray.append(newItem2)
        guard let items = defaults.array(forKey: constants.userDefaultKeyForItemArray) as? [Item] else { return }
        itemArray = items
        
    }
//MARK: - tableView data source methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: constants.cellIdentifier, for: indexPath)
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    //MARK: - tableView delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Add new items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alertController = UIAlertController(title: "Add new item", message: "", preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "Add item", style: .default) { [self] action in
            //what will happen once the user clicks the "Add item" button on UIAlert
            let newItem = Item(title: textField.text!)
            itemArray.append(newItem)
            defaults.set(itemArray, forKey: constants.userDefaultKeyForItemArray)
            tableView.reloadData()
        }
        
        alertController.addTextField { alertTextField in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
        }
        
        alertController.addAction(alertAction)
        present(alertController, animated: true)
    }
    
}



