import processing.serial.*;
import cc.arduino.*;
Arduino arduino;

boolean errorOccured = false;

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
	frameRate(30);
	size(1005, 510);
	textFont(loadFont(fontFile));
}
