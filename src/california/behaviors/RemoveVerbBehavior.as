package california.behaviors {
    import california.PlayState;
    
    public class RemoveVerbBehavior extends Behavior {
        private var targetVerbName:String;        
        
        public function RemoveVerbBehavior(targetVerbName:String):void {
            this.targetVerbName = targetVerbName;            
        }

        override public function run():void {
            PlayState.removeVerb(targetVerbName);
        }
    }
}