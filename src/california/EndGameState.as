package california {
    import org.flixel.*;
    import SWFStats.*;
    
    public class EndGameState extends FlxState {
        private var thankYouText:FlxText;

        private var fadeFromColor:uint;
        
        public function EndGameState(fadeFromColor:uint=0x000000):void {
            this.fadeFromColor = fadeFromColor;
            
            super();
        }
        
        override public function create():void {
            //Log.CustomMetric("completed testing game");
            
            FlxG.flash.start(this.fadeFromColor, 1.0, function():void {
                    FlxG.flash.stop();
                });

            thankYouText = new FlxText(20, 20, FlxG.width - 40, "'A House In California' was developed by Jake Elliott.\n\nThank you for playing. You can find more information about this game and other projects at http://cardboardcomputer.com/");
            thankYouText.setFormat(null, 8, 0xffffffff);
            add(thankYouText);

            FlxG.mouse.show();
        }

        override public function update():void {
            if(FlxG.mouse.justPressed()) {
                FlxG.mouse.hide();
                FlxG.state = new StartState();
            }
            
            super.update();
        }

    }
}