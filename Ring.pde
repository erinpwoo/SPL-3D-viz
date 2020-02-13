void drawRing(int i, int month, int year) { // i: # of ring
    pushMatrix();
    translate(width/2, height/2, -i*30);
    strokeWeight(1);
    stroke(255,255,255, 80);
    strokeWeight(1);
    noFill();
    ellipse(0, 0,300,300); // x,y,w,h
    fill(255,255,255);
    noStroke();
    textSize(20);
    scale(.5);
    text(month + "/" + year, 350, 0,0);
    popMatrix();
    textSize(12);
}

void drawPoint(Book book, int ringNum) {
  pushMatrix();
  fill(255,0,0);
  translate(width/2, height/2);
  switch (book.deweyClass.substring(0,3)) {
    case "130":
      if (!off130) {
        noStroke();
      } else {
        stroke(128,21,21);
      }
      break;
    case "131":
      if (!off131) {
        noStroke();
      } else {
        stroke(212,106,106);
      }
      break;
     case "132":
      if (!off132) {
        noStroke();
      } else {
       stroke(212,154,106);
      }
      break;
     case "133":
      if (!off133) {
        noStroke();
      } else {
       stroke(128,69,21);
      }
      break;
     case "134":
      if (!off134) {
        noStroke();
      } else {
        stroke(64,127,127);
      }
      break;
     case "135":
      if (!off135) {
        noStroke();
      } else {
        stroke(13,77,77);
      }
      break;
     case "136":
      if (!off136) {
        noStroke();
      } else {
        stroke(85,170,85);
      }
      break;
     case "137":
      if (!off137) {
        noStroke();
      } else {
        stroke(17,102,17);
      }
      break;
     case "138":
     if (!off138) {
        noStroke();
      } else {
        stroke(85,0,0);
      }
      break;
     case "139":
      if (!off139) {
        noStroke();
      } else {
        stroke(86,117,104);
      }
      break;
    default:
      stroke(255,255,255);
      break;
  }
  float size = map(book.count, countMin, countMax, 3, 20);
  strokeWeight(size);
  if (!(keyPressed && key == ' ')) {
    book.speed += book.theta;
    book.X =  150*cos(book.speed);
    book.Y =  150*sin(book.speed); 
  } else {
    if (overPoint(screenX(book.X,book.Y, -ringNum*30), screenY(book.X,book.Y, -ringNum*30), size)) {
      popup(book);
    } else {
      noFill();
    }
  }
  point(book.X,book.Y,-ringNum*30);
  popMatrix();
}