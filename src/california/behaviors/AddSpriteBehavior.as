package california.behaviors {
    import california.PlayState;
    
    public class AddSpriteBehavior extends Behavior {
        private var spriteName:String;
        private var x:Number;
        private var y:Number;

        private var width:Number;
        private var height:Number;        
        
        public function AddSpriteBehavior(behaviorNode:XML):void {
            this.spriteName = behaviorNode.@spriteName;
            this.x = Behavior.stringToNumber(behaviorNode.@x);
            this.y = Behavior.stringToNumber(behaviorNode.@y);

            this.width = Behavior.stringToNumber(behaviorNode.@width);
            this.height = Behavior.stringToNumber(behaviorNode.@height);
        }

        override public function run():void {
            PlayState.addSprite(spriteName, x, y, width, height);
        }
    }
}