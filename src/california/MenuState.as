package california {
    import org.flixel.*;
    import SWFStats.*;
    
    public class MenuState extends FlxState {
        private var roomTitle:FlxText;
        private var copyrightText:FlxText;        
        
        private var backgroundImage:FlxSprite;
        private var buttonGroup:FlxGroup;
        
        private var cursor:GameCursor;

        private var fadeFromColor:uint;
        
        public function MenuState(fadeFromColor:uint=0x000000):void {
            this.fadeFromColor = fadeFromColor;
            
            super();
        }
        
        override public function create():void {
            if(!Main.logViewInitialized) {
                Log.View(540, "9f491e53-4116-4945-85e7-803052dc1b05", root.loaderInfo.loaderURL);
                Main.logViewInitialized = true;
            }
            
            FlxG.flash.start(this.fadeFromColor, 1.0, function():void {
                    FlxG.flash.stop();
                });

            backgroundImage = new FlxSprite(0,0,Main.library.getAsset('menuBackground'));
            add(backgroundImage);
            
            roomTitle = new FlxText(8, 8, FlxG.width, 'A House in California');
            roomTitle.setFormat(Main.gameFontFamily, Main.gameFontSize, 0xffffffff);
            add(roomTitle);

            copyrightText = new FlxText(FlxG.width - 156, FlxG.height - 16, FlxG.width, '(c) 2010 Cardboard Computer');
            copyrightText.setFormat(Main.gameFontFamily, Main.gameFontSize, 0xffffffff);
            add(copyrightText);

            var buttonPos:uint = 60;

            buttonGroup = new FlxGroup;

            //var sections:Array = ['lois', 'beulah', 'connie', 'ann'];

            if(Main.saveGame.data.sectionsUnlocked.indexOf('lois') != -1) {
                var loisButton:MenuButton = new MenuButton(48, buttonPos, Main.library.getAsset('loisLevelIcon'), 'Lois', false, 'loisHome', 'lois');
                buttonGroup.add(loisButton);
            } else {
                buttonGroup.add(new MenuButton(48, buttonPos, Main.library.getAsset('blankLevelIcon'), '------', true, ''));                
            }

            if(Main.saveGame.data.sectionsUnlocked.indexOf('beulah') != -1) {
                var beulahButton:MenuButton = new MenuButton(102, buttonPos, Main.library.getAsset('beulahLevelIcon'), 'Beulah', false, 'beulahHome');
                buttonGroup.add(beulahButton);
            } else {
                buttonGroup.add(new MenuButton(102, buttonPos, Main.library.getAsset('blankLevelIcon'), '------', true, ''));                                
            }

            if(Main.saveGame.data.sectionsUnlocked.indexOf('connie') != -1) {
                var connieButton:MenuButton = new MenuButton(166, buttonPos, Main.library.getAsset('loisLevelIcon'), 'Connie', false, 'connieHome');
                buttonGroup.add(connieButton);
            } else {
                buttonGroup.add(new MenuButton(166, buttonPos, Main.library.getAsset('blankLevelIcon'), '------', true, ''));                                
            }

            if(Main.saveGame.data.sectionsUnlocked.indexOf('ann') != -1) {
                var annButton:MenuButton = new MenuButton(230, buttonPos, Main.library.getAsset('loisLevelIcon'), 'Ann', false, 'annHome');
                buttonGroup.add(annButton);
            } else {
                buttonGroup.add(new MenuButton(230, buttonPos, Main.library.getAsset('blankLevelIcon'), '------', true, ''));                                
            }

            add(buttonGroup);
            
            cursor = new GameCursor();
            cursor.setText(null);
            add(cursor);
        }

    }
}