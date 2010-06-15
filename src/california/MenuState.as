package california {
    import org.flixel.*;
    import SWFStats.*;
    
    public class MenuState extends FlxState {
        private var roomTitle:FlxText;
        private var copyrightText:FlxText;        
        
        private var backgroundImage:FlxSprite;
        private var buttonGroup:FlxGroup;
        
        private var cursor:GameCursor;

        override public function create():void {
            if(!Main.logViewInitialized) {
                Log.View(540, "9f491e53-4116-4945-85e7-803052dc1b05", root.loaderInfo.loaderURL);
                Main.logViewInitialized = true;
            }
            
            FlxG.flash.start(0xff000000, 1.0, function():void {
                    FlxG.flash.stop();
                });

            backgroundImage = new FlxSprite(0,0,Main.library.getAsset('menuBackground'));
            add(backgroundImage);
            
            roomTitle = new FlxText(8, 8, FlxG.width, 'A House in California');
            roomTitle.setFormat(null, 8, 0xffffffff);
            add(roomTitle);

            copyrightText = new FlxText(FlxG.width - 156, FlxG.height - 16, FlxG.width, '(c) 2010 Cardboard Computer');
            copyrightText.setFormat(null, 8, 0xffffffff);
            add(copyrightText);

            var buttonPos:uint = 60;

            buttonGroup = new FlxGroup;
            
            var loisButton:MenuButton = new MenuButton(48, buttonPos, Main.library.getAsset('loisLevelIcon'), 'Lois', false, 'loisHome');
            buttonGroup.add(loisButton);

            for(var i:uint = 0; i < 3; i++) {
                buttonGroup.add(new MenuButton(102 + (64 * i), buttonPos, Main.library.getAsset('blankLevelIcon'), '------', true, ''));
            }

            add(buttonGroup);
            
            cursor = new GameCursor();
            cursor.setText(null);
            add(cursor);
        }

    }
}