//
//  AddCategoryViewController.swift
//  Simple Accounts
//
//  Created by Steven Gibson on 01/04/2016.
//  Copyright © 2016 Steven Gibson. All rights reserved.
//

import UIKit

class AddCategoryViewController: UIViewController, UICollectionViewDataSource, UITextFieldDelegate {
    
    private let numberOfItemsPerRow = 6
    private let reuseID = "CategoryIconCell"
    private let unwindSegueID = "unwindFromAdd"
    private let imageResourceNames = ImageResourceLoader.sharedInstance
    
    //MARK: - Dependencies
    var mode: AddEditMode<TransactionCategory>!
    var categoryStore: CategoryStore!
    
    //MARK: - Outlets
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var iconCollectionView: UICollectionView!
    @IBOutlet weak var collectionHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var deletePreventionMessage: UILabel!
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    //MARK: - Actions
    
    @IBAction func cancelButtonPressed(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func saveButtonPressed(sender: UIBarButtonItem) {
        let name = nameTextField.unwrappedText.trim()
        let icon = imageResourceNames.pngImageNames[iconCollectionView.indexPathsForSelectedItems()!.first!.item]
        
        switch mode! {
        case .Add:
            if categoryStore.addCategory(TransactionCategoryData(name: name, icon: icon)) != nil {
                performSegueWithIdentifier(unwindSegueID, sender: self)
            } else {
                displayErrorDialog(name)
            }
        case .Edit(let category):
            category.name = name
            category.icon = icon
            if categoryStore.updateCategory(category) {
                performSegueWithIdentifier(unwindSegueID, sender: self)
            } else {
                displayErrorDialog(name)
            }
        }
    }
    
    @IBAction func deleteButtonPressed(sender: UIButton) {
        let actionSheet = UIAlertController(title: nil,
                                            message: nil,
                                            preferredStyle: .ActionSheet)
        actionSheet.addAction(UIAlertAction(title: "Delete", style: .Destructive, handler: { _ in
            //TODO: create categorystore.delete
            self.performSegueWithIdentifier(self.unwindSegueID, sender: self)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    private func displayErrorDialog(enteredName: String) {
        var createOrUpdateString = "create"
        var resetNameClosure: ((UIAlertAction) -> Void)? = nil
        if case let .Edit(category) = mode! {
            createOrUpdateString = "update"
            resetNameClosure = { _ in self.nameTextField.text = category.name }
        }
        let actionSheet = UIAlertController(title: "Information",
                                            message: "Cannot \(createOrUpdateString) category, a category called '\(enteredName)' already exists.",
                                            preferredStyle: .ActionSheet)
        actionSheet.addAction(UIAlertAction(title: "OK", style: .Default, handler: resetNameClosure))
        presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    //MARK: - TextField functions
    
    @IBAction func nameFieldChanged(sender: UITextField) {
        saveButton.enabled = sender.unwrappedText.trim().isNotEmpty
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //MARK: - CollectionView Data Source
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = iconCollectionView.dequeueReusableCellWithReuseIdentifier(reuseID, forIndexPath: indexPath) as! IconCollectionViewCell
        cell.setImage(UIImage(named: imageResourceNames.pngImageNames[indexPath.item])!)
        return cell
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageResourceNames.pngImageNames.count
        //TODO: display alternate 'creation' cell to create set of default categories if list is empty
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var selectedIconIndex = 0
        if case let .Edit(categoryToUpdate) = mode! {
            let canDeleteCategory = categoryToUpdate.transactions.isEmpty
            navigationBar.title = "Edit Category"
            deleteButton.hidden = false
            deleteButton.enabled = canDeleteCategory
            deletePreventionMessage.hidden = canDeleteCategory
            nameTextField.text = categoryToUpdate.name
            saveButton.enabled = true
            selectedIconIndex = imageResourceNames.pngImageNames.indexOf(categoryToUpdate.icon)!
        }
        iconCollectionView.allowsMultipleSelection = false
        iconCollectionView.selectItemAtIndexPath(NSIndexPath(forItem: selectedIconIndex, inSection: 0), animated: false, scrollPosition: .None)
    }
    
    override func viewDidLayoutSubviews() {
        collectionHeightConstraint.constant = iconCollectionView.contentSize.height
    }
    
}

//MARK: - Extensions

extension UITextField {
    var unwrappedText: String {
        return self.text ?? ""
    }
}






