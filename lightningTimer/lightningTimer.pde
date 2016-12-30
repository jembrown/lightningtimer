  //Created by Brian O'Meara for Evolution 2013 Lightning Talks
//   This program is free software: you can redistribute it and/or modify
//    it under the terms of the GNU General Public License as published by
//    the Free Software Foundation, either version 3 of the License, or
//    (at your option) any later version.
//
//    This program is distributed in the hope that it will be useful,
//    but WITHOUT ANY WARRANTY; without even the implied warranty of
//    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//    GNU General Public License for more details.
//
//    You should have received a copy of the GNU General Public License
//    along with this program.  If not, see <http://www.gnu.org/licenses/>.

PFont f16;
PFont f24;
PFont f32;
PFont f48;
PFont f64;
PFont f128;
PFont f200;
PFont f96;
Table table;
int offset = 0;
int startTime = (60*60*hour()) + (60*minute()) + second();

void setup() {
  frameRate(20);
  size(1450, 850);
  //size(displayWidth, displayHeight);
  f128 = createFont("Arial", 128, true); 
  f96 = createFont("Arial", 96, true); 
  f200 = createFont("Arial", 200, true);
  f64 = createFont("Arial", 64, true); 
  f48 = createFont("Arial", 48, true);
  f32 = createFont("Arial", 32, true); 
  f24 = createFont("Arial", 24, true);
  f16 = createFont("Arial", 16, true); 
  table = loadTable("Session1.tsv", "header, tsv");
 // table = loadTable("http://www.weebly.com/uploads/3/1/9/3/31930665/ssblightning.tsv", "header, tsv");
 // table = loadTable("LightningTalksSchedule2014.csv", "header, csv");
}



void draw() {
  
  int secondsElapsed = (((60*60*hour()) + (60*minute()) + second()) - startTime);
  int minutesElapsed = floor(secondsElapsed/60);
  
  int minutesLeft = 5 - (minutesElapsed % 5);
  int secondsLeft = 300 - (secondsElapsed % 300);
    
  fill(0, 0, 0);
  textAlign(CENTER);

  if (minutesLeft > 2) {
    background(91, 250, 81);
  } 
  else if (minutesLeft == 2) {
    background(252, 252, 0);
  }
  else {
    background(203, 4, 4);
    textFont(f64);       
    text("Set up for next talk", width/2, 2*height/5);
  }
  textFont(f200);       
  
  String[] timeString = new String[2];
  //timeString[0] = nf(minute()%5, 1);

  timeString[0] = nf(minutesLeft-1, 1);
  //timeString[1] = nf(second(), 2);
  timeString[1] = nf(secondsLeft % 60, 2);
  if ((secondsLeft % 60) == 0){
    timeString[0] = nf(minutesLeft,1);
  }
  text(join(timeString, ':'), width/2, height/5);
  textFont(f16);

  for (TableRow row : table.rows()) {
    int rowTime = (60*int(row.getString("Hour"))) + int(row.getString("Minute")); // Row time in minutes       

    if ( (minutesLeft > 1) && (minutesElapsed < (rowTime+5)) && (minutesElapsed >= rowTime) ) {
      textFont(f64);       
      //text(str(rowTime)+"  "+str(minutesLeft)+"  "+str(minutesElapsed), width/2, 4*height/5);
      text("Now: " + row.getString("Presenter") +  " " + row.getString("Time") , width/2, 2*height/5);
      if ( minutesLeft > 2 ){
        textFont(f48);
        text(row.getString("Title"), 0.5*width/4, 2.5*height/5, 3*width/4, 3.5*height/5);
      }
    }
    if ( (minutesLeft < 3) && ((minutesElapsed+5) < (rowTime+5)) && ((minutesElapsed+5) >= rowTime) ) {
      textFont(f64);       
      text("Next: " + row.getString("Presenter") +  " " + row.getString("Time") , width/2, 3*height/5);
    }
    if ( (minutesLeft < 2) && ((minutesElapsed+10) < (rowTime+5)) && ((minutesElapsed+10) >= rowTime) ) {
      textFont(f32);       
      text("Then: " + row.getString("Presenter") +  " " + row.getString("Time") , width/2, 4*height/5);
    }
  }
}