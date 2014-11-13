//
//  TaskDetailViewController.swift
//  TaskIt
//
//  Created by home on 02/11/2014.
//  Copyright (c) 2014 home. All rights reserved.
//

import UIKit

class TaskDetailViewController: UIViewController {
    
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var subtaskTextField: UITextField!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    
    
    //we need to create a property in the TaskDetailViewController that will allow us to pass a Task to it.
    var detailTaskModel:TaskModel!
    
    var mainVC: ViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        println(self.detailTaskModel.task)
        taskTextField.text = detailTaskModel.task
        subtaskTextField.text = detailTaskModel.subTask
        dueDatePicker.date = detailTaskModel.date
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func cancelButtonTapped(sender: UIBarButtonItem)
    {
        //We must use popViewController because we used a show segue which adds a ViewController onto the ViewController stack. Adding the parameter as true makes the dismissal have a nice transition.
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    
    @IBAction func doneBarButtonItemPressed(sender: UIBarButtonItem)
    {
        var task = TaskModel(task: taskTextField.text, subTask: subtaskTextField.text, date: dueDatePicker.date , completed:false)
        
        mainVC.baseArray[0][mainVC.tableView.indexPathForSelectedRow()!.row] = task
//        mainVC.taskArray[mainVC.tableView.indexPathForSelectedRow()!.row] = task
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    

}
