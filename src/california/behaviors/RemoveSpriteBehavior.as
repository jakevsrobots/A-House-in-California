package california.behaviors {
    import california.PlayState;
    
    public class RemoveSpriteBehavior extends Behavior {
        private var targetSpriteName:String;        
        
        public function ReplaceSpriteBehavior(targetSpriteName:String):void {
            this.targetSpriteName = targetSpriteName;            
        }

        override public function run():void {
            PlayState.removeSprite(targetSpriteName);
        }
    }
}