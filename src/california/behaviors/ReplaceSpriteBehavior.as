package california.behaviors {
    import california.PlayState;
    import org.flixel.FlxG;
    
    public class ReplaceSpriteBehavior extends Behavior {
        private var oldSpriteName:String;        
        private var newSpriteName:String;
        private var x:Number = NaN;
        private var y:Number = NaN;
        
        public function ReplaceSpriteBehavior(behaviorNode:XML):void {
            this.oldSpriteName = behaviorNode.@oldSprite.toString();
            this.newSpriteName = behaviorNode.@newSprite.toString();
            
            this.x = Behavior.stringToNumber(behaviorNode.@x);
            this.y = Behavior.stringToNumber(behaviorNode.@y);
        }

        override public function run():void {
            PlayState.replaceSprite(oldSpriteName, newSpriteName, x, y);
        }
    }
}