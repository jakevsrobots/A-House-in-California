package california.behaviors {
    import california.PlayState;
    
    public class RemoveSpriteBehavior extends Behavior {
        private var targetSpriteName:String;        
        
        public function RemoveSpriteBehavior(behaviorNode:XML):void {
            this.targetSpriteName = behaviorNode.@targetSprite.toString();
        }

        override public function run():void {
            PlayState.removeSprite(targetSpriteName);
        }
    }
}