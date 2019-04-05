Model Command{ //TODO REVISAR ESTE FORMATO Y QUE PASAR (si nro led, o estado led, etc)
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
            broker.async.connect()
            broker.async.subscribe(stateChannel,@function(lightControllerModule.onStateChanged))
        }catch(e){
            broker.ui.showAlert("Exception : "+e.name(), "Description: " + e.reason())
        }   
        
        
    }
    
    void onStateChanged(Info bulbSt){
    
 //       broker.ui.showAlert("DEBUG", bulbSt.bulb1State.toString())
//        broker.ui.showAlert("DEBUG", bulbSt.bulb2State.toString())
//        broker.ui.showAlert("DEBUG", bulbSt.bulb3State.toString())
//        broker.ui.showAlert("DEBUG", bulbSt.temp.toString())
//        broker.ui.showAlert("DEBUG", bulbSt.hum.toString())
//        broker.ui.showAlert("DEBUG", bulbSt.lux.toString())
        if(bulbSt!=null  ){
        
            b1.state =  bulbSt.bulb1State
            b2.state = bulbSt.bulb2State
            b3.state = bulbSt.bulb3State
            
            m.light1 = b1.imagePath
            m.light2 = b2.imagePath
            m.light3 = b3.imagePath
            
            m.tempLbl = bulbSt.temp.toString() + " °C" 
            m.humLbl = bulbSt.hum.toString() + " %"
            m.ambientLbl = bulbSt.lux.toString() + " lx"
            m.date = Date()
        
        }else {
            //error al conectar o reconectar un dispositivo.
            //broker.ui.showAlert("DEBUG", "bulbSt es null")
        }
    }
    
     void checkBulbState(){
        Command command = Command(command:"GET-STATE") 
        broker.async.publish(commandChannel,command)
    }
    
    void toggleBulb(Integer idx){
        Command command = Command(command:"TOGGLE-RELAY",relayIdx:idx) 
        broker.async.publish(commandChannel,command)
        //broker.ui.showAlert("DEBUG", idx.toString())
        
    }
}