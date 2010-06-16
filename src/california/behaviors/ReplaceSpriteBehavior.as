package california.behaviors {
    import california.PlayState;
    import org.flixel.FlxG;
    
    public class ReplaceSpriteBehavior extends Behavior {
        private var oldSpriteName:String;        
        private var newSpriteName:String;
        private var x:Number = NaN;
        private var y:Number = NaN;
        
        public function ReplaceSpriteBehavior(oldSpriteName:String, newSpriteName:String, x:Number=NaN, y:Number=NaN):void {
            this.oldSpriteName = oldSpriteName;
            this.newSpriteName = newSpriteName;
            
            this.x = x;
            this.y = y;
        }

        override public function run():void {
            PlayState.replaceSprite(oldSpriteName, newSpriteName, x, y);
        }
    }
}