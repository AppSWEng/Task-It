//
//  Date.swift
//  TaskIt
//
//  Created by home on 02/11/2014.
//  Copyright (c) 2014 home. All rights reserved.
//

import Foundation

class Date
{
    //#: This will allow our parameter name to show up when we use this function.
    class func from(#year:Int, month:Int, day:Int) -> NSDate
    {
        
        //NSDateComponents encapsulates the components of a date in an extendable, object-oriented manner. NSDate is broken up into year, month, day, and we can even go further into minutes, hours, and seconds
        var components = NSDateComponents()
        components.year = year
        components.month = month
        components.day = day
        
        var gregorianCalendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)
        var date = gregorianCalendar?.dateFromComponents(components)
        
        return date!
    }
    
    
    class func toString(#date:NSDate) -> String
    {
        //In this function we will start by creating a constant that will be an instance of NSDateFormatter.
        //NSDateFormatter instances allow us to convert a NSDate into a String
        let dateStringFormatter = NSDateFormatter()
        
        
        //we need to set the dateFormat property so the date formatter knows how we would like to the date displayed as a String. We will use "yyyy-MM-dd".
        dateStringFormatter.dateFormat = "yyyy-MM-dd"
        
        //Finally, we call the function stringFromDate on our NSDateFormatter instance and pass in the date parameter as the parameter to this function. This creates a String from our NSDate parameter.
        let dateString = dateStringFormatter.stringFromDate(date)
        
        return dateString
    }
}





