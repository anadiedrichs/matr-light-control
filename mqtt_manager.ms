Model Command{
    String command
    Integer relayIdx
}

Model Info{
    Bool bulb1State
    Bool bulb2State
    Bool bulb3State
    Double temp
    Double hum
    Double lux
}

Module lightControllerModule{
    
    void initialize(){
        
        try{
            broker.async.initialize()
        }catch(e){
            broker.ui.showAlert("Exception in initialize: "+e.name(), "Description: " + e.reason())
        }    
         
        try{
            broker.async.connect()
        }catch(e){
            broker.ui.showAlert("Exception in connect: "+e.name(), "Description: " + e.reason())
        }   
        
        try{
            broker.async.subscribe(stateChannel,@function(lightControllerModule.onStateChanged))
        }catch(e){
            broker.ui.showAlert("Exception in suscribe: "+e.name(), "Description: " + e.reason())
        }   
        
        
    }
    
    void onStateChanged(Info bulbSt){
    
        broker.ui.showAlert("DEBUG", "onStateChanged")
    
        b1.state =  bulbSt.bulb1State
        b2.state = bulbSt.bulb2State
        b3.state = bulbSt.bulb3State
        
        m.light1 = b1.imagePath
        m.light2 = b2.imagePath
        m.light3 = b3.imagePath
    }
    
     void checkBulbState(){
        Command command = Command(command:"GET-STATE")
        broker.async.publish(commandChannel,command)
    }
    
    void toggleBulb(Integer idx){
        Command command = Command(command:"TOGGLE-RELAY",relayIdx:idx)
        broker.async.publish(commandChannel,command)
    }
}