package california.behaviors {
    import california.PlayState;
    
    public class ReplaceSpriteBehavior extends Behavior {
        private var oldSpriteName:String;        
        private var newSpriteName:String;
        
        public function ReplaceSpriteBehavior(oldSpriteName:String, newSpriteName:String):void {
            this.oldSpriteName = oldSpriteName;
            this.newSpriteName = newSpriteName;            
        }

        override public function run():void {
            PlayState.replaceSprite(oldSpriteName, newSpriteName);
        }
    }
}