Model Bulb {
    Bool state
    String imagePath
}

RuleContext BulbContext{
    Rule onBulbStateChanged listen (state from Bulb as bulb){
        if (bulb.state){
            bulb.imagePath = bulbOnImagePath
        }else{
            bulb.imagePath = bulbOffImagePath
        }
    }
}


Application {
    String bulbOnImagePath 
    String bulbOffImagePath
    
    String commandChannel
    String stateChannel
    
    Bulb b1
    Bulb b2
    Bulb b3
    
    Main m
    
    OnInit {
        bulbOnImagePath  = "https://i.imgur.com/OCHptxX.png"
        bulbOffImagePath = "https://i.imgur.com/kq7Yfmg.png"
        
        commandChannel = "command"
        stateChannel = "home"
        
        b1  = Bulb(state:false,imagePath:bulbOffImagePath)
        b2  = Bulb(state:false,imagePath:bulbOffImagePath)
        b3  = Bulb(state:false,imagePath:bulbOffImagePath)
        
        
        m = Main()
        m.light1 = b1.imagePath //Bulb(imagePath:bulbOffImagePath)
        m.light2 = b2.imagePath //Bulb(imagePath:bulbOffImagePath)
        m.light3 = b3.imagePath //Bulb(imagePath:bulbOffImagePath)
       
        broker.ui.push("Main",m)
        //lightControllerModule.initialize()
        
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
}

Entry Experience Main {

    String tempLbl value("Temperature value") as Label
    String humLbl value("Humidity value") as Label
    String ambientLbl value("Intensity light value") as Label
    
    String light1Lbl value("Ligth 1") as Label
    String light1 as Image
    Decision light1Btn action("MainContext.onLight1Pressed") label("ON/OFF")
    
    String light2Lbl value("Ligth 2") as Label
    String light2 as Image
    Decision light2Btn action("MainContext.onLight2Pressed") label("ON/OFF")
    
    String light3Lbl value("Ligth 3") as Label
    String light3 as Image
    Decision light3Btn action("MainContext.onLight3Pressed") label("ON/OFF")
    
    String logs value("logs") as Label
}

RuleContext MainContext {
    Rule onLight1Pressed{
        lightControllerModule.toggleBulb(1)
    }
    
    Rule onLight2Pressed{
        lightControllerModule.toggleBulb(2)
    }
    
    Rule onLight3Pressed{
        lightControllerModule.toggleBulb(3)
    }
}