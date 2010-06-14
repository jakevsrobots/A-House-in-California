package california.behaviors {
    import california.PlayState;
    
    public class AddSpriteBehavior extends Behavior {
        private var spriteName:String;
        private var x:uint;
        private var y:uint;        

        private var width:uint;
        private var height:uint;        
        
        public function AddSpriteBehavior(spriteName:String, x:uint, y:uint, width:uint=NaN, height:uint=NaN):void {
            this.spriteName = spriteName;
            this.x = x;
            this.y = y;

            this.width = width;
            this.height = height;                
        }

        override public function run():void {
            PlayState.addSprite(spriteName, x, y, width, height);
        }
    }
}