/*
 * anemopen
 *
 * Copyright 2013 Barnaby <b@Zi.iS>
 * License: GPLv2
 */

#include <Wire.h>
#include <HMC5883L.h>

#define HALL_PIN 2
#define SEN_LED_PIN 11
#define SEN_C 12
#define SEN_E 13
#define PULLUP HIGH
#define OPEN LOW

HMC5883L compass;
float heading = 0;
unsigned long nextread = 0;

void setup() {
  pinMode(HALL_PIN, INPUT);
  digitalWrite(HALL_PIN, PULLUP);
  
  pinMode(SEN_LED_PIN, OUTPUT);
  analogWrite(SEN_LED_PIN, 255);
  pinMode(SEN_C, OUTPUT);
  digitalWrite(SEN_C, HIGH);
  pinMode(SEN_E, INPUT);
  digitalWrite(SEN_E, OPEN);

  Serial.begin(115200);
  Wire.begin();
  compass = HMC5883L();    
  compass.SetScale(1.3);
  compass.SetMeasurementMode(Measurement_Continuous);
}

void loop() {
  if(millis() > nextread) {
    nextread = millis() + 66; //15kHz
  
    MagnetometerScaled scaled = compass.ReadScaledAxis();
    heading = atan2(scaled.YAxis, scaled.XAxis);
    heading += -0.024725498; //declinationAngle
    if(heading < 0) {
      heading += 2*PI;
    }
    if(heading > 2*PI) {
      heading -= 2*PI;
    }
    heading = heading * 180/M_PI;
  }
  
  Serial.print(heading);
  Serial.print("\t");
  Serial.print(digitalRead(SEN_E));
  Serial.print("\n");
  delay(100);
}
