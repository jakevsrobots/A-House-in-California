package california {
    import org.flixel.*;
    import SWFStats.*;
    import california.music.MenuMusicPlayer;

    import flash.display.StageDisplayState;
    import flash.display.SimpleButton;

    import flash.system.fscommand;
    
    public class StartState extends FlxState {
        private var roomTitle:FlxText;
        private var copyrightText:FlxText;        
        
        private var backgroundImage:FlxSprite;
        
        private var cursor:GameCursor;

        private var fadeFromColor:uint;

        private var fullScreenButton:SimpleButton;
        
        public function StartState(fadeFromColor:uint=0xff000000):void {
            this.fadeFromColor = fadeFromColor;
            
            super();
        }
        
        override public function create():void {
            //Main.stage.displayState = 'fullScreenInteractive';
            //FlxG.stage.displayState = 'fullScreen';

            //FlxG.stage.displayState = StageDisplayState.FULL_SCREEN;            

            //fscommand("trapallkeys", "true");
            //fscommand("showmenu", "false");            
            
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
            copyrightText = new FlxText(FlxG.width - 186, FlxG.height - 16, FlxG.width, 'Kickstarter Backer build - Jake Elliott [2010]');
            copyrightText.setFormat(Main.gameFontFamily, Main.gameFontSize, 0xffffffff);
            //add(copyrightText);

            var buttonPos:uint = 60;

            var playButton:FlxButton = new FlxButton(232, 23, function():void {
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
            
            var creditsButton:FlxButton = new FlxButton(232, 55, function():void {
                    FlxG.fade.start(0xff000000, 2.0, function():void {
                            FlxG.fade.stop();
                            FlxG.state = new EndGameState();
                        });
                });
            creditsButton.loadGraphic(
                new FlxSprite(0,0,Main.library.getAsset('creditsButton')),
                new FlxSprite(0,0,Main.library.getAsset('creditsButtonHover')));
            add(creditsButton);

            var quitButton:FlxButton = new FlxButton(232, 87, function():void {
                    //musicPlayer.fadeOut();
                    FlxG.fade.start(0xff000000, 2.0, function():void {
                            FlxG.fade.stop();
                            fscommand("quit");
                        });
                });
            quitButton.loadGraphic(
                new FlxSprite(0,0,Main.library.getAsset('quitButton')),
                new FlxSprite(0,0,Main.library.getAsset('quitButtonHover')));
            add(quitButton);
            
            cursor = new GameCursor();
            cursor.setText(null);
            add(cursor);

            //FlxG.stage.displayState = StageDisplayState.FULL_SCREEN;
        }

    }
}