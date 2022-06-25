//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Илья Шаповалов on 25.06.2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {
    
    //MARK: - Private properties
    private var categoryArray = [CategoryList]()
    private let K = Constant()
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.categoryCellIdentifier, for: indexPath)
        cell.textLabel?.text = categoryArray[indexPath.row].name
        return cell
    }
    
    //MARK: - Table view Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Data manipulation methods
    private func saveCategorioes() {
        do {
            try context.save()
        } catch {
            print("Error saving context, \(error)")
        }
        tableView.reloadData()
    }
    
    private func loadCategories(with request: NSFetchRequest<CategoryList> = CategoryList.fetchRequest()) {
        do {
            categoryArray = try context.fetch(request)
        } catch {
            print("Error fetching data from context, \(error)")
        }
        tableView.reloadData()
    }
    
    //MARK: - Add new category
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alertController = UIAlertController(title: "Add new category", message: nil, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Add list", style: .default) { [self] action in
            let newList = CategoryList(context: context)
            newList.name = textField.text
            categoryArray.append(newList)
            saveCategorioes()
        }
        
        alertController.addTextField { alertTextfield in
            alertTextfield.placeholder = "Create new category list"
            textField = alertTextfield
        }
        
        alertController.addAction(alertAction)
        present(alertController, animated: true)
    }
    
}