package california.behaviors {
    import california.PlayState;
    
    public class AddSpriteBehavior extends Behavior {
        private var spriteName:String;
        private var x:Number;
        private var y:Number;

        private var width:Number;
        private var height:Number;        
        
        public function AddSpriteBehavior(spriteName:String, x:Number, y:Number, width:Number=NaN, height:Number=NaN):void {
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