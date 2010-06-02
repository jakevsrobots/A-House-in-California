package california.behaviors {
    import california.PlayState;
    
    public class DialogBehavior extends Behavior {
        private var text:String;
        
        public function DialogBehavior(text:String):void {
            this.text = text;
        }

        override public function run():void {
            PlayState.dialog.showText(this.text);
        }
    }
}