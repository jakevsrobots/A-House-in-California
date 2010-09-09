package california.behaviors {
    import california.PlayState;
    import california.sprites.GameSprite;
    
    public class MakeSpriteInteractiveBehavior extends Behavior {
        private var spriteName:String;
        
        public function MakeSpriteInteractiveBehavior(behaviorNode:XML):void {
            this.spriteName = behaviorNode.@spriteName;
        }

        override public function run():void {
            var sprite:GameSprite = PlayState.instance.currentRoom.getSprite(spriteName);
            sprite.interactive = true;
        }
    }
}