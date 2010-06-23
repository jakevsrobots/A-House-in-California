package california.sprites {
    import org.flixel.*;
    import california.Main;
    
    public class HouseCloud extends GameSprite {
        private var speed:Number;
        
        public function HouseCloud(name:String, X:Number, Y:Number):void {
            super(name, X, Y);

            alpha = 0.5 + (Math.random() / 2);
            speed = 10 + (Math.random() * 20);
       }

       override public function update():void {
           x -= speed * FlxG.elapsed;

           if(x < -width) {
               x = FlxG.width;
           }
           
           super.update();
       }
    }
}