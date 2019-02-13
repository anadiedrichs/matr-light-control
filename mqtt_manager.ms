Model Command{
    String command
    Integer relayIdx
}

Model BulbStates{
    Bool bulb1State
    Bool bulb2State
    Bool bulb3State
}

Module lightControllerModule{
    
    void initialize(){
        broker.async.initialize()
        broker.async.connect()
        broker.async.subscribe(stateChannel,@function(lightControllerModule.onStateChanged))
    }
    
    void onStateChanged(BulbStates bulbSt){
        m.light1.state = bulbSt.bulb1State
        m.light2.state = bulbSt.bulb2State
        m.light3.state = bulbSt.bulb3State
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