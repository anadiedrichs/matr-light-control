# matr-light-control
Matr light control template &amp; example of use for MQTT

## Channel home

Connect your device to the following server: a2sq3y7mdrjtom.iot.us-east-1.amazonaws.com:8883

To subscribe or publish in this channel, use the following MQTT topic: 3e873641

JSON 

{"bulb1State":0,"bulb2State":1,"bulb3State":1,"temp":30,"hum":60,"lux":60}

### Example of publication with mosquitto client

mosquitto_pub -h a2sq3y7mdrjtom.iot.us-east-1.amazonaws.com -p 8883 -t 3e873641 --cert testDevice.certificate.pem --key testDevice.private-key.txt --cafile rootCA.pem -m '{"bulb1State":"true","bulb2State":"true","bulb3State":"true","temp":30,"hum":60,"lux":60}' -d


## Channel command

Connect your device to the following server: a2sq3y7mdrjtom.iot.us-east-1.amazonaws.com:8883

To subscribe or publish in this channel, use the following MQTT topic: a152175c

### Example of suscription with mosquitto client

mosquitto_sub -h a2sq3y7mdrjtom.iot.us-east-1.amazonaws.com -p 8883 -t a152175c --cert testDevice.certificate.pem --key testDevice.private-key.txt --cafile rootCA.pem -d



