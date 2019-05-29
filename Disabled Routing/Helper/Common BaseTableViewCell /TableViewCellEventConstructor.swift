
//Notes:- TableViewCellEventConstructor class is used for constructing the events for table view cell handling.

class TableViewCellEventConstructor {
    
    fileprivate var eventDict: [String: ()->Void] = [:]
    
    /**
     This method is used for registering error code 
     
     - parameter eventCode: Code of event
     
     - parameter method:   method object corresponding to event
     */
    
    func registerEvent(_ eventCode: String, method: @escaping () -> Void){
        
        //Mapping messages corresponding to specific code
        self.eventDict[eventCode] = method
    }
    
    /**
     This method is used for sending specific error message corresponding to error code
     
     - parameter eventCode: eventCode corresponding to specific event
     
     - returns: Returning event Method
     */
    
    func getEventCallbackForCode(_ eventCode: String) -> ()->Void
    {
        //This line check whether event is resolvable or not
        
        if isEventCallbackResolvable(eventCode){
            
            return eventDict[eventCode]!
        }
        else{
            return {()->Void in return}
        }
    }
    
    /**
     This method is used for checking whether event is already added or not in event Dictionary
     
     - parameter code: Event Code
     
     - returns: Returning True or false
     */
    
    fileprivate func isEventCallbackResolvable(_ code: String) -> Bool
    {
        guard let _ = eventDict[code] else {
            return false
        }
        return true
    }
    
}

