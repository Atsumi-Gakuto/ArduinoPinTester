import processing.serial.*;
import cc.arduino.*;
Arduino arduino;

boolean errorOccured = false;
int selectedPin = 0;
boolean[] digitalOut = new boolean[14];
int[] analogOut = new int[14];
boolean[] pmwOut = new boolean[14];

/* --- Properties start --- */

String serialPort = "COM3"; //Arduino serial port.
String fontFile = "CourierNewPSMT-48.vlw"; //Font file name.

/* --- Properties end --- */

void setup() {
	if (serialPort == "") {
		println("Error: \"serialPort\" is not specified.");
		errorOccured = true;
		return;
	}
	try {
		arduino = new Arduino(this, serialPort, 57600);
	}
	catch(Exception exception) {
		println("Error: An error occurred while connecting to Arduino.");
		errorOccured = true;
		return;
	}
	for(int i = 0; i < 14; i++) {
		digitalOut[i] = false;
		analogOut[i] = 0;
		pmwOut[i] = false;
	}
	size(350, 715);
	textFont(loadFont(fontFile));
}

void draw() {
	if(errorOccured) exit(); //Exits if any errors occured in setup();

	background(120);
	fill(0, 255, 0);
	stroke(0, 255, 0);
	square(20, selectedPin * 50 + 20, 20);
	for(int i = 0; i < 14; i++) {
		fill(255);
		textSize(30);
		text("D" + i, 60, i * 50 + 40);
		if(i == 3 || (i >= 5 && i <= 6) || (i >= 9 && i <= 11)) {
			if(pmwOut[i]) fill(255, 255, 0);
			else fill(255);
			textSize(20);
			text("PMW", 130, i * 50 + 40);
		}
		if(digitalOut[i]) fill(255);
		else noFill();
		stroke(255);
		rect(300, i * 50 + 20, 20, 20);
	}
}

void keyPressed() {
	if(keyCode == 40) {
		selectedPin++;
		if(selectedPin > 13) selectedPin = 0;
	}
	else if(keyCode == 38) {
		selectedPin--;
		if(selectedPin < 0) selectedPin = 13;
	}
	else if(keyCode == 90 && !pmwOut[selectedPin]) {
		digitalOut[selectedPin] = !digitalOut[selectedPin];
	}
}