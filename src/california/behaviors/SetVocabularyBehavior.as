package california.behaviors {
    import california.PlayState;

    public class SetVocabularyBehavior extends Behavior {
        private var verbNames:Array;

        public function SetVocabularyBehavior(behaviorNode:XML):void {
            verbNames = [];
            
            for each (var verbNode:XML in behaviorNode.verb) {
                verbNames.push(verbNode.@name.toString());
            }
        }

        override public function run():void {
            PlayState.vocabulary.setCurrentVerbsByName(verbNames);
        }
    }
}