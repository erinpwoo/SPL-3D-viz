class Book{
  String deweyClass;
  String bibNumber;
  String title;
  int[] date; // yyyy,mm,dd
  int count;
  float speed;
  float theta;
  float X;
  float Y;
  
  Book(String deweyClass, String bibNumber, String title, int[] date, int count){
    this.deweyClass = deweyClass;
    this.bibNumber = bibNumber;
    this.title = title;
    this.date = date;
    this.count = count;
    this.speed = map(count, countMin, countMax, .01, .5);
    this.theta = map(count, countMin, countMax, .0005, .02);
    this.X = this.Y = 0;
  }
}