package california {
    import org.flixel.*;

    public class CutSceneState extends FlxState {
        // Static
        public static var cutSceneDataBase:Object = {
            'lois': {
                'title': '1. Lois',
                'text': [
                    'A boy said, "Grandma, the house is too dark! I can\'t sleep."',
                    'Lois said, "Don\'t worry, boy, the lamp has just gone out."',
                    '"Once, when I was young, we caught fireflies in jars."',
                    '"I\'m sure The fireflies will light the street lamp now."'
                ],
                'sprites': [
                    'loisStill_1', 'loisStill_2', 'loisStill_3', 'loisStill_4'
                ]
            },
            'beulah': {
                'title': '2. Beulah',
                'text': [
                    'A boy said, "Grandma, the house is too quiet. I\'m scared."',
                    'Beulah said, "Don\'t worry; the birds have just gone to sleep.',
                    '"When I was young, we fed the birds and listened to them sing."',
                    '"Let\'s think of some snacks that birds like to eat."'
                ],
                'sprites': [
                    'beulahStill_1', 'beulahStill_2', 'beulahStill_3'
                ]
            },
            'connie': {
                'title': '3. Connie',
                'text': [
                    'A boy said, "Grandma, the house is too gray. I\'m bored."',
                    'Connie said, "Don\'t worry; the butterflies are just distracted"',
                    '"When their daydreams are over they\'ll color the house."'
                ],
                'sprites': [
                    'connieStill_1', 'connieStill_2'                    
                ]
            }
        };

        public static var FADING_IN:uint = 0;
        public static var VISIBLE:uint = 1;
        public static var FADING_OUT:uint = 2;
        public static var INITIAL_FADE_IN:uint = 3;
        
        // Instance
        private var roomName:String;   // what room to go to once this cutscene is done.
        
        private var textLines:Array;
        private var spriteAssetNames:Array;
        private var text:FlxText;
        private var titleText:FlxText;        
        private var labelText:FlxText;        
        private var sprites:FlxGroup;
        private var currentLineIndex:uint;
        private var fadeState:uint;
        private var initialFadeInSpeed:Number = 1.0;
        private var fadeInSpeed:Number = 2.0;
        private var fadeOutSpeed:Number = 1.0;
        private var nextText:String;
        private var cursor:GameCursor;
        
        public function CutSceneState(sceneName:String, roomName:String):void {
            this.roomName = roomName;
            
            var cutSceneData:Object = CutSceneState.cutSceneDataBase[sceneName];

            spriteAssetNames = cutSceneData['sprites'];
            textLines = cutSceneData['text'];

            sprites = new FlxGroup;
            add(sprites);

            for each(var spriteAssetName:String in spriteAssetNames) {
                var sprite:CutSceneSprite = new CutSceneSprite(spriteAssetName);
                sprites.add(sprite);
            }

            var textPaddingX:uint = 64;
            
            //text = new FlxText(textPaddingX, 64, FlxG.width - (textPaddingX * 2));
            text = new FlxText(0, 64, FlxG.width);
            text.setFormat(Main.gameFontFamily, Main.gameFontSize, 0xffffff, 'center');
            text.alpha = 0.0;
            add(text);

            titleText = new FlxText(0, 16, FlxG.width);
            titleText.setFormat(Main.gameFontFamily, Main.gameFontSize * 4, 0xffffff, 'center');
            titleText.alpha = 1.0;
            titleText.text = cutSceneData['title'];
            //add(titleText);

            labelText = new FlxText(-4, FlxG.height - 16, FlxG.width, '(click to continue)');
            labelText.setFormat(Main.gameFontFamily, Main.gameFontSize, 0xffffff, 'right');
            labelText.alpha = 0.0;
            add(labelText);

            cursor = new GameCursor();
            add(cursor);
            
            fadeState = CutSceneState.INITIAL_FADE_IN;
            
            currentLineIndex = 0;
            text.text = textLines[0];
            //nextText = textLines[0];
        }

        override public function update():void {
            if(fadeState == CutSceneState.FADING_IN) {
                text.alpha += fadeInSpeed * FlxG.elapsed;
                if(text.alpha >= 1.0) {
                    fadeState = CutSceneState.VISIBLE;
                    text.alpha = 1.0;
                }
            } else if(fadeState == CutSceneState.FADING_OUT) {
                text.alpha -= fadeOutSpeed * FlxG.elapsed;
                if(text.alpha <= 0.0) {
                    text.alpha = 0;
                    if(nextText == null) {
                        endState();
                    } else {
                        text.text = nextText;
                        fadeState = CutSceneState.FADING_IN;
                    }
                }
            } else if(fadeState == CutSceneState.INITIAL_FADE_IN) {
                text.alpha += initialFadeInSpeed * FlxG.elapsed;
                if(text.alpha >= 1.0) {
                    fadeState = CutSceneState.VISIBLE;
                    text.alpha = 1.0;
                }
                
                labelText.alpha = text.alpha;
            }

            if(FlxG.mouse.justPressed()) {
                if(fadeState == CutSceneState.FADING_IN) {
                    text.alpha = 1.0;
                    fadeState = CutSceneState.VISIBLE;
                } else if(fadeState == CutSceneState.VISIBLE) {
                    advanceText();
                } else if(fadeState == CutSceneState.FADING_OUT) {
                    // Shortcut to next fade-in.
                    text.alpha = 0.0;
                }
            }
            
            //labelText.alpha = text.alpha;
            
            super.update();
        }

        private function advanceText():void {
            currentLineIndex += 1;
            FlxG.log('advancing to text index ' + currentLineIndex);
            
            nextText = textLines[currentLineIndex];
            
            /*
            if(currentLineIndex >= textLines.length -1) {
                nextText = null;
            } else {
            nextText = textLines[currentLineIndex];               
            }*/

            fadeState = CutSceneState.FADING_OUT;
        }

        private function endState():void {
            FlxG.fade.start(0xff000000, 3, function():void {
                    FlxG.fade.stop();
                    FlxG.state = new PlayState(roomName);
                });
            
        }
    }
}