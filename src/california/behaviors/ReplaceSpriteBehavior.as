package california.behaviors {
    import california.PlayState;
    import org.flixel.FlxG;
    
    public class ReplaceSpriteBehavior extends Behavior {
        private var oldSpriteName:String;        
        private var newSpriteName:String;
        private var x:uint;        
        private var y:uint;
        
        public function ReplaceSpriteBehavior(oldSpriteName:String, newSpriteName:String, x:uint=NaN, y:uint=NaN):void {
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