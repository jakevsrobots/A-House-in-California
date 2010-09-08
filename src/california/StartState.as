package california {
    import org.flixel.*;
    import SWFStats.*;
    import california.music.MenuMusicPlayer;
    
    public class StartState extends FlxState {
        private var roomTitle:FlxText;
        private var copyrightText:FlxText;        
        
        private var backgroundImage:FlxSprite;
        
        private var cursor:GameCursor;

        private var fadeFromColor:uint;
        
        public function StartState(fadeFromColor:uint=0xff000000):void {
            this.fadeFromColor = fadeFromColor;
            
            super();
        }
        
        override public function create():void {
            //Main.stage.displayState = 'fullScreenInteractive';
            //FlxG.stage.displayState = 'fullScreen';

            var musicPlayer:MenuMusicPlayer = new MenuMusicPlayer();
            
            FlxG.flash.start(this.fadeFromColor, 2.0, function():void {
                    FlxG.flash.stop();
                });

            backgroundImage = new FlxSprite(0,0,Main.library.getAsset('menuBackground'));
            add(backgroundImage);
            
            roomTitle = new FlxText(8, 8, FlxG.width, 'A House in California');
            roomTitle.setFormat(Main.gameFontFamily, Main.gameFontSize, 0xffffffff);
            //add(roomTitle);

            //copyrightText = new FlxText(FlxG.width - 156, FlxG.height - 16, FlxG.width, '(c) 2010 Cardboard Computer');
            copyrightText = new FlxText(FlxG.width - 186, FlxG.height - 16, FlxG.width, 'LearnToPlay build -- Jake Elliott [2010]');
            copyrightText.setFormat(Main.gameFontFamily, Main.gameFontSize, 0xffffffff);
            //add(copyrightText);

            var buttonPos:uint = 60;

            var playButton:FlxButton = new FlxButton(232, 25, function():void {
                    //musicPlayer.fadeOut();
                    FlxG.fade.start(0xff000000, 2.0, function():void {
                            FlxG.fade.stop();
                            FlxG.state = new CutSceneState('lois', 'loisHome');
                        });
                });
            playButton.loadGraphic(
                new FlxSprite(0,0,Main.library.getAsset('playButton')),
                new FlxSprite(0,0,Main.library.getAsset('playButtonHover')));
            add(playButton);
            
            cursor = new GameCursor();
            cursor.setText(null);
            add(cursor);
        }

    }
}