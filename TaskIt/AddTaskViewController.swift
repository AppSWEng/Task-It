//
//  AddTaskViewController.swift
//  TaskIt
//
//  Created by home on 02/11/2014.
//  Copyright (c) 2014 home. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {
    
    
    //Add a property that is named mainVC and is of type ViewController. We will use this to pass an instance of the main ViewController when we segue.
    var mainVC:ViewController!

    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var subtaskTextField: UITextField!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func cancelButtonTapped(sender: UIButton)
    {
        //we don't have a nav bar as we have selected the segue as present modally
        self.dismissViewControllerAnimated(true, completion: nil)
    }
  
    
    @IBAction func addTaskButtonTapped(sender: UIButton)
    {
        var task = TaskModel(
            task: self.taskTextField.text,
            subTask: self.subtaskTextField.text,
            date: self.dueDatePicker.date,
            completed : false
        )
        //self.mainVC.taskArray.append(task)
        self.mainVC.baseArray[0].append(task)
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
}
