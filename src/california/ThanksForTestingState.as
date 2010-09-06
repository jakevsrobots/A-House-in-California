package california {
    import org.flixel.*;
    import SWFStats.*;
    
    public class ThanksForTestingState extends FlxState {
        private var thankYouText:FlxText;

        private var fadeFromColor:uint;
        
        public function ThanksForTestingState(fadeFromColor:uint=0x000000):void {
            this.fadeFromColor = fadeFromColor;
            
            super();
        }
        
        override public function create():void {
            //Log.CustomMetric("completed testing game");
            
            FlxG.flash.start(this.fadeFromColor, 1.0, function():void {
                    FlxG.flash.stop();
                });

            thankYouText = new FlxText(40, 40, FlxG.width, "Thank you for testing! <3 <3 <3\nClick anywhere to restart");
            thankYouText.setFormat(null, 8, 0xffffffff);
            add(thankYouText);

            FlxG.mouse.show();
        }

        override public function update():void {
            if(FlxG.mouse.justPressed()) {
                FlxG.mouse.hide();
                FlxG.state = new MenuState();
            }
            
            super.update();
        }

    }
}