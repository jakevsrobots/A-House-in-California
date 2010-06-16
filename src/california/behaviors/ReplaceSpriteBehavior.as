package california.behaviors {
    import california.PlayState;
    import org.flixel.FlxG;
    
    public class ReplaceSpriteBehavior extends Behavior {
        private var oldSpriteName:String;        
        private var newSpriteName:String;
        private var x:Number = NaN;
        private var y:Number = NaN;
        
        public function ReplaceSpriteBehavior(oldSpriteName:String, newSpriteName:String, x:Number=NaN, y:Number=NaN):void {
            FlxG.log('nan as string is ' + NaN);
            
            FlxG.log('in constructor got argument x = ' + x);
            FlxG.log('in constructor got argument y = ' + y);
            
            this.oldSpriteName = oldSpriteName;
            this.newSpriteName = newSpriteName;
            
            this.x = x;
            this.y = y;

            FlxG.log('in constructor set x to ' + this.x);
            FlxG.log('in constructor set y to ' + this.y);

        }

        override public function run():void {
            PlayState.replaceSprite(oldSpriteName, newSpriteName, x, y);
        }
    }
}