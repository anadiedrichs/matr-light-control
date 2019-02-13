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
    
    Main m
    OnInit {
        bulbOnImagePath  = "https://i.imgur.com/OCHptxX.png"
        bulbOffImagePath = "https://i.imgur.com/kq7Yfmg.png"
        
        commandChannel = "raspberryCommand2"
        stateChannel = "raspberryState2"
        
        m = Main()
        m.light1 = Bulb(imagePath:bulbOffImagePath)
        m.light2 = Bulb(imagePath:bulbOffImagePath)
        m.light3 = Bulb(imagePath:bulbOffImagePath)
        
        broker.ui.push("Main",m)
        lightControllerModule.initialize()
    }
}

Entry Experience Main {
    String light1Lbl value("Ligth 1") as Label
    Bulb light1 as Image
    Decision light1Btn action("MainContext.onLight1Pressed") label("ON/OFF")
    
    String light2Lbl value("Ligth 2") as Label
    Bulb light2 as Image
    Decision light2Btn action("MainContext.onLight2Pressed") label("ON/OFF")
    
    String light3Lbl value("Ligth 3") as Label
    Bulb light3 as Image
    Decision light3Btn action("MainContext.onLight3Pressed") label("ON/OFF")
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