package california {
    import org.flixel.*;

    public class StartState extends FlxState {
        public function StartState():void {
            super();
        }

        override public function create():void {
            FlxG.state = new CutSceneState('lois', 'loisHome');
        }
    }
}