package california.behaviors {
    import california.PlayState;
    
    public class MoveSpriteBehavior extends Behavior {
        private var targetSpriteName:String;
        private var x:Number;
        private var y:Number;
        
        public function MoveSpriteBehavior(behaviorNode:XML):void {
            this.targetSpriteName = behaviorNode.@targetSprite.toString();

            this.x = Behavior.stringToNumber(behaviorNode.@x);
            this.y = Behavior.stringToNumber(behaviorNode.@y);
        }

        override public function run():void {
            PlayState.moveSprite(targetSpriteName, x, y);
        }
    }
}