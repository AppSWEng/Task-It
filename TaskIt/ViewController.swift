//
//  ViewController.swift
//  TaskIt
//
//  Created by home on 01/11/2014.
//  Copyright (c) 2014 home. All rights reserved.
//

import UIKit


class ViewController: UIViewController , UITableViewDataSource , UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!

    //var taskArray:[TaskModel] = []
    
    //Our tasks are held in an array, but we want to hold completed tasks in another array. Instead of having disjointed arrays floating around our project, we can create one base array that has two arrays as it's objects. This is also known as a multidimensional array. so our multidimentional array will consist of complelete tasks and uncompleted tasks
    var baseArray:[[TaskModel]] = []

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let date1 = Date.from(year: 2014, month: 11, day: 02)
        let date2 = Date.from(year: 2014, month: 10, day: 01)
        let date3 = Date.from(year: 2014, month: 9, day: 15)
        
        let task1 = TaskModel(task: "Study French", subTask: "Verb", date: date1 , completed: false)
        let task2 = TaskModel(task: "Eat Dinner", subTask: "burgers", date: date2 , completed: false)
        let taskArray = [task1,task2,TaskModel(task: "Gym", subTask: "Leg day", date: date3, completed: false)]
        
        var completedArray = [TaskModel(task: "Code", subTask: "Task Project", date: date2, completed: true)]
        
        baseArray = [taskArray , completedArray]
        
        //We can now call the reloadData function on our tableView. This will refresh our TableView and recal the UITableViewDataSource functions.
        self.tableView.reloadData()
        
    }
    
    //We are overriding the viewDidAppear function, which will be called each time the view is presented on the screen. This is different then viewDidLoad which is only called the first time a given ViewController (in this case, the main ViewController) is created.
    //
    override func viewDidAppear(animated: Bool)
    {
        //Next, we call the viewDidAppear function on the keyword super, which implements the viewDidAppear functionality from the main ViewController's super classes implementation of viewDidAppear.
        //super.functionName in this case super.viewDidAppear calls to the super class (in this case UIViewController) and finds its' implementation of viewDidAppear. It first implements UIViewController's implementation of viewDidAppear which does some setup for us before we add our own code to it. Not adding it would skip the super classes implementation.
        //viewDidAppear is called everytime the viewcontroller is presented on the screen. ViewDidLoad is called only the first time it is presented on the screen. Therefore when we want functionality to occur each time the view is presented on the screen (someone presses the back button on a future vc to represent this VC) then we use viewDidAppear.
        super.viewDidAppear(animated)
        
        //embedded function
//        func sortByDate ( taskOne: TaskModel, taskTwo:TaskModel) -> Bool
//        {
//        taskOne and taskTwo are the parameters for the function. When using sorted it automatically iterates over the array and passes in the instances to compare them. The function does this handling behind the scenes so we don't need to worry about it.
//            return taskOne.date.timeIntervalSince1970 < taskTwo.date.timeIntervalSince1970
//        }
//        taskArray = taskArray.sorted(sortByDate)
        
        
        //we can user clouser instead of the above function
        baseArray[0] = baseArray[0].sorted(
            {
            ( taskOne: TaskModel, taskTwo:TaskModel) -> Bool in
            //comparision logic here
              return taskOne.date.timeIntervalSince1970 < taskTwo.date.timeIntervalSince1970
 
           }
        )
        
        
        //Finally, we call the function reloadData on the the tableView. This function causes the tableView to recall it's dataSource functions and repopulate the tableView with the updated array.
        self.tableView.reloadData()
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        
        //We will use an if statement to ensure that the proper transition is occurring since multiple Segues can occur from the ViewController. Therefore, we use the identifier property of our segue to confirm that it is the same name.
        if segue.identifier == "ShowTaskDetail"
        {
            //We then can access the instance of the TaskDetailViewController that will be shortly presented on the screen by accessing the destinationViewController property of the segue.
            let detailVC:TaskDetailViewController = segue.destinationViewController as TaskDetailViewController
            
            //In order to figure out which Task was selected we use the function indexPathForSelectedRow to determine which NSIndexPath was selected in the tableView
            let indexPath = self.tableView.indexPathForSelectedRow()
            
            //We can then use the row property of the NSIndexPath instance to detemine which row was tapped.With this information, we can then index into the taskArray and access the appropriate Task.
            let thisTask = baseArray[indexPath!.section][indexPath!.row]
            
            //Finally, we can set the TaskDetailViewController's detailTaskModel property to be the appropriate Task. Now the TaskDetailViewController will have access to a Task when it accesses the detailTaskModel property.
            detailVC.detailTaskModel = thisTask
            
            detailVC.mainVC = self
        }
        else if segue.identifier == "showTaskAdd"
        {
            //Even though we created a property for our ViewController (i.e. var mainVC:ViewController!), we didn’t say exactly which instance of the ViewController we want 
            //Remember, classes represent objects, they are not referencing specific objects unless you make them. So, we need to pass our ViewController instance to the AddTaskVC in our segue.
            
            //Start by creating a constant that points to the destinationViewController, which is the AddTaskViewController that will be presented on the screen.
            //We explicitly state that this will be an instance of the AddTaskViewController, since the segue does not know which kind of ViewController we will be presenting.
            let addTaskVC:AddTaskViewController = segue.destinationViewController as AddTaskViewController
            
            //With this constant in hand, we can set the mainVC property of the AddTaskViewController to be the current ViewController. We use the keyword self to access the current ViewController.
            addTaskVC.mainVC = self
        }
    }
    
    @IBAction func addButtonTapped(sender: UIBarButtonItem)
    {
        self.performSegueWithIdentifier("showTaskAdd", sender: self)
    }
    
    
    //UITableView datasource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return baseArray.count
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
     //section= 0 (taskarray) or =1 (completed tasks)
     return baseArray[section].count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        //The function cellForRowAtIndexPath determines which cell should be used in our UITableView. To make this function work, we must create an instance of a UITableViewCell. We'll use our custom UITableViewCell class we created.
    
        //Now that we've created the variable instance, we use the keyword as and we can then specify that it is a TaskCell instance. We need to do this because the compiler doesn't know that the tableView Cell instance is a TaskCell instance. Usually XCode is smart enough to figure these things out, but sometimes we need to help it by telling it which class it should be.
        var cell: TaskCell = tableView.dequeueReusableCellWithIdentifier("myCell") as TaskCell
        
        //we use indexpath.row to make selecting the elements in the array dynamically according to the curent row
        //IndexPath has a property row which specifys the row being populated. In this case, we have 3 rows in our TableView, so the function cellForRowAtIndexPath will be called 3 times. Each time it is called, the value of row will increase by 1 starting at 0. Therefore, we can access each instance in our Array start at index 0.
        let thisTask = baseArray[indexPath.section][indexPath.row]
        
        cell.taskLabel.text = thisTask.task
        cell.descriptionLabel.text = thisTask.subTask
        cell.dateLabel.text = Date.toString(date: thisTask.date)
        
        
        return cell
    }
    
    
    
    //UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
      println(indexPath.row)
        
      performSegueWithIdentifier("ShowTaskDetail", sender: self)
        
    }
    
    //set the height of the header for each section
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 25
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0
        {
            return "To do"
        }
        else
        {
            return "Completed"
        }
    }
    

    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
    
//        let thisTask = baseArray[indexPath.section][indexPath.row]
//        
//        if indexPath.section == 0
//        {
//        
//        var newTask = TaskModel(task: thisTask.task, subTask: thisTask.subTask, date: thisTask.date, completed: true)
//        baseArray[1].append(newTask)
//        }
//        else
//        {
//            var newTask = TaskModel(task: thisTask.task, subTask: thisTask.subTask, date: thisTask.date, completed: false)
//            baseArray[0].append(newTask)
//        }
//        baseArray[indexPath.section].removeAtIndex(indexPath.row)
//        tableView.reloadData()
        
    }

    
    //custome buttons
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]?
    {
        let thisTask = self.baseArray[indexPath.section][indexPath.row]
        var newTask = TaskModel(task: thisTask.task, subTask: thisTask.subTask, date: thisTask.date, completed: !thisTask.completed)
        
        var completeAction:UITableViewRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Complete", handler:
            {
            (tvra:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
            self.baseArray[indexPath.section].removeAtIndex(indexPath.row)
            self.baseArray[1].append(newTask)
            self.tableView.reloadData()
           }
        )
        completeAction.backgroundColor = UIColor.blueColor()
       
        
        var uncompleteAction:UITableViewRowAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Uncomplete", handler: { (tvra:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
            
            self.baseArray[indexPath.section].removeAtIndex(indexPath.row)
            self.baseArray[0].append(newTask)
            self.tableView.reloadData()
        })
        
        uncompleteAction.backgroundColor = UIColor.redColor();
        
        if indexPath.section == 0
        {
            return [completeAction]
        } else {
            return [uncompleteAction]
        }
        
    }
    
  


}

