package california {
    import org.flixel.*;

    public class MenuButton extends FlxGroup {
        private var icon:FlxSprite;
        private var labelText:FlxText;        
        private var locked:Boolean;
        private var roomName:String;
        private var cutSceneName:String;        
        
        private var FADE_IN:uint = 0;
        private var FADE_OUT:uint = 1;        
        private var fadingState:uint = 1;
        private var minAlpha:Number = 0.5;
        private var fadeSpeed:Number = 2.0;
        
        public function MenuButton(X:Number, Y:Number, IconGraphic:Class, label:String, locked:Boolean, roomName:String, cutSceneName:String=null):void {
            super();
            
            icon = new FlxSprite(X, Y, IconGraphic);
            icon.alpha = minAlpha;
            add(icon);
            
            labelText = new FlxText(X, Y + icon.height, FlxG.width, label);
            labelText.alpha = minAlpha;
            
            add(labelText);

            this.locked = locked;
            this.roomName = roomName;
            this.cutSceneName = cutSceneName;
        }

        override public function update():void {
            if(icon.overlapsPoint(FlxG.mouse.x, FlxG.mouse.y)) {
                fadingState = FADE_IN;

                if(FlxG.mouse.justPressed() && !this.locked) {
                    FlxG.fade.start(0xff000000, 1.0, function():void {
                            FlxG.fade.stop();
                            if(cutSceneName == null) {
                                FlxG.state = new PlayState(roomName);
                            } else {
                                FlxG.state = new CutSceneState(cutSceneName, roomName);
                            }
                        });
                }
            } else {
                fadingState = FADE_OUT;
            }

            if(fadingState == FADE_IN) {
                if(icon.alpha <= 1.0) {
                    icon.alpha += fadeSpeed * FlxG.elapsed;
                }
            } else if(fadingState == FADE_OUT) {
                if(icon.alpha >= minAlpha) {
                    icon.alpha -= fadeSpeed * FlxG.elapsed;
                }
            }

            if(icon.alpha < minAlpha) {
                icon.alpha = minAlpha;
            } else if(icon.alpha > 1.0) {
                icon.alpha = 1.0;
            }

            labelText.alpha = icon.alpha;
            
            super.update();
        }
    }
}