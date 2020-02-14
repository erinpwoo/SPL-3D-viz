/*  3D Visualization Project by Erin Woo
    MAT 259A - Winter 2020
  
  The project visualizes checkout data from Dewey classes 130-139, which are topics on parapsychology and the occult. Each moving point represents a single title and each ring representing a single month. The speed and size
  of each point correlates with the checkout count for that month, while the volume of points on a single ring represents the total volume of checkouts in these Dewey classes for that given month. The rings are organized in
  chronological order, as the user should be able to scroll through time to see trends in this topic over the course of the dataset’s lifetime. 
  
  To view the title & checkout count for a title, the user can hold down the space bar and mouse over a point, in
  which a popup is dispayed with those details.

*/


import peasy.*;
PeasyCam cam;
Table table;
int numRows;
int countMin;
int countMax;
int ringNum;

Boolean off130;
Boolean off131;
Boolean off132;
Boolean off133;
Boolean off134;
Boolean off135;
Boolean off136;
Boolean off137;
Boolean off138;
Boolean off139;

color color130 = color(128,21,21);
color color131 = color(212,106,106);
color color132 = color(212,154,106);
color color133 = color(128,69,21);
color color134 = color(64,127,127);
color color135 = color(13,77,77);
color color136 = color(85,170,85);
color color137 = color(17,102,17);
color color138 = color(85,0,0);
color color139 = color(86,117,104);

ArrayList<Book>books = new ArrayList<Book>();

void setup() {
  fullScreen(P3D);
  cam = new PeasyCam(this, width/2,height/2,-3000,0);
  cam.setCenterDragHandler(null); 
  cam.setDistance(1000);
  cam.setRotations(0,0,0);
  smooth();
  table = loadTable("dewey130-140.csv", "header");
  numRows = table.getRowCount();
  stroke(255,0,0);
  for (int i =0; i<numRows; i++) {
    String deweyClass = table.getString(i, 0);
    String bibNumber = table.getString(i, 1);
    String title = table.getString(i, 2);
    // parsing date
    String[] date = split(table.getString(i, 3), '-');
    int year = Integer.parseInt(date[0]);
    int month = Integer.parseInt(date[1]);
    int day = Integer.parseInt(date[2]);
    int[] parsedDate = {year, month, day};
    
    int count = table.getInt(i, 4);
    if (count > countMax) {
       countMax = count; 
    }
    if (count < countMin) {
      countMin = count;
    }
    books.add(new Book(deweyClass, bibNumber, title, parsedDate, count));
  }
  
  off130 = true;
  off131 = true;
  off132 = true;
  off133 = true;
  off134 = true;
  off135 = true;
  off136 = true;
  off137 = true;
  off138 = true;
  off139 = true;
  
}

void draw() {
  background(0,0,0);
  directionalLight(126, 126, 126, 0, 0, -1);
  ambientLight(102, 102, 102);
  drawData();
  /* DRAWING COLOR KEY */
  textSize(16);
  cam.beginHUD();
  noStroke();
  fill(color130);
  rect(20, 640,10,10);
  fill(255,255,255);
  text("130: Parapsychology & occultism", 35, 650);
  fill(color131);
  rect(20, 660,10,10);
  fill(255,255,255);
  text("131: Parapsychological and occult methods for achieving well-being, happiness, success", 35, 670);
  fill(color132);
  rect(20, 680,10,10);
  fill(255,255,255);
  text("132: No longer used (formerly 'Mental derangements')", 35, 690);
  fill(color133);
  rect(20, 700,10,10);
  fill(255,255,255);
  text("133: Specific topics in parapsychology & occultism", 35, 710);
  fill(color134);
  rect(20, 720,10,10);
  fill(255,255,255);
  text("134: No longer used (formerly 'Mesmerism & Clairvoyance')", 35, 730);
  fill(color135);
  rect(20, 740,10,10);
  fill(255,255,255);
  text("135: Dreams & mysteries", 35, 750);
  fill(color136);
  rect(20, 760,10,10);
  fill(255,255,255);
  text("136: No longer used (formerly 'Mental characteristics')", 35, 770);
  fill(color137);
  rect(20, 780,10,10);
  fill(255,255,255);
  text("137: Divinatory graphology", 35, 790);
  fill(color138);
  rect(20, 800,10,10);
  fill(255,255,255);
  text("138: Physiognomy", 35, 810);
  fill(color139);
  rect(20, 820,10,10);
  fill(255,255,255);
  text("139: Phrenology", 35, 830);
  cam.endHUD();
}

void drawData() {
  ringNum = 0;
  for (int i = 0; i < books.size(); i++) {
    if (i > 0) {
        if (books.get(i).date[1] != books.get(i-1).date[1]) {
           ringNum++;
           drawRing(ringNum, books.get(i).date[1], books.get(i).date[0]); 
        }
    }
    drawPoint(books.get(i), ringNum);
  }
}

boolean overPoint(float x, float y, float diameter) {
  float disX = x - mouseX;
  float disY = y - mouseY;
  if(sqrt(sq(disX) + sq(disY)) < diameter/2 ) {
    return true;
  } else {
    return false;
  }
}

void popup(Book book) {
  cam.beginHUD();
  noStroke();
  fill(255,255,255);
  textSize(12.5);
  rect(50,50, 300,150, 2);
  fill(0,0,0);
  text("Title: " + book.title + "\n\nCheckout count: " + book.count, 60, 60, 280, 140);
  stroke(255,255,255);
  cam.endHUD();
}

void mousePressed() {
   if (mouseX >= 20 && mouseX <= 30 && mouseY >= 640 && mouseY <= 650) {
     if (off130) {
       color130 = color(220,220,220);
       off130 = !off130;
       return;
     } else {
       color130 = color(128,21,21);
       off130 = !off130;
       return;
     }
   } else if (mouseX >= 20 && mouseX <= 30 && mouseY >= 660 && mouseY <= 670) {
     if (off131) {
       color131 = color(220,220,220);
       off131 = !off131;
       return;
     } else {
       color131 = color(212,106,106);
       off131 = !off131;
       return;
     }
   } else if (mouseX >= 20 && mouseX <= 30 && mouseY >= 680 && mouseY <= 690) {
     if (off132) {
       color132 = color(220,220,220);
       off132 = !off132;
       return;
     } else {
       color132 = color(212,154,106);
       off132 = !off132;
       return;
     }
   } else if (mouseX >= 20 && mouseX <= 30 && mouseY >= 700 && mouseY <= 710) {
     if (off133) {
       color133 = color(220,220,220);
       off133 = !off133;
       return;
     } else {
       color133 = color(128,69,21);
       off133 = !off133;
       return;
     }
   }
   else if (mouseX >= 20 && mouseX <= 30 && mouseY >= 720 && mouseY <= 730) {
     if (off134) {
       color134 = color(220,220,220);
       off134 = !off134;
       return;
     } else {
       color134 = color(64,127,127);
       off134 = !off134;
       return;
     }
   }
   else if (mouseX >= 20 && mouseX <= 30 && mouseY >= 740 && mouseY <= 750) {
     if (off135) {
       color135 = color(220,220,220);
       off135 = !off135;
       return;
     } else {
       color135 = color(13,77,77);
       off135 = !off135;
       return;
     }
   } else if (mouseX >= 20 && mouseX <= 30 && mouseY >= 760 && mouseY <= 770) {
     if (off136) {
       color136 = color(220,220,220);
       off136 = !off136;
       return;
     } else {
       color136 = color(85,170,85);
       off136 = !off136;
       return;
     }
   } else if (mouseX >= 20 && mouseX <= 30 && mouseY >= 780 && mouseY <= 790) {
     if (off137) {
       color137 = color(220,220,220);
       off137 = !off137;
       return;
     } else {
       color137 = color(17,102,17);
       off137 = !off137;
       return;
     }
   } else if (mouseX >= 20 && mouseX <= 30 && mouseY >= 800 && mouseY <= 810) {
     if (off138) {
       color138 = color(220,220,220);
       off138 = !off138;
       return;
     } else {
       color138 = color(85,0,0);;
       off138 = !off138;
       return;
     }
   } else if (mouseX >= 20 && mouseX <= 30 && mouseY >= 820 && mouseY <= 840) {
     if (off139) {
       color139 = color(220,220,220);
       off139 = !off139;
       return;
     } else {
       color139 = color(86,117,104);
       off139 = !off139;
       return;
     }
   }
}