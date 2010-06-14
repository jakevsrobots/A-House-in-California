package california.behaviors {
    import california.PlayState;
    
    public class AddSpriteBehavior extends Behavior {
        private var spriteName:String;
        private var x:uint;
        private var y:uint;        
        
        public function AddSpriteBehavior(spriteName:String, x:uint, y:uint):void {
            this.spriteName = spriteName;
            this.x = x;
            this.y = y;
        }

        override public function run():void {
            PlayState.addSprite(spriteName, x, y);
        }
    }
}