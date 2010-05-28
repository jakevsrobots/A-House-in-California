package california {
    import org.flixel.*;

    public class PlayState extends FlxState {
        //[Embed(source='/../data/gardenia.ttf', fontFamily='gardenia')]
        //private var GardeniaFont:String;
        
        [Embed(source='/../data/Balderas.ttf', fontFamily='balderas')]
        private var BalderasFont:String;

        [Embed(source="/../data/autotiles.png")]
            private var AutoTiles:Class;
        
        private var backgroundGroup:FlxGroup;
        private var playerGroup:FlxGroup;
        private var hudGroup:FlxGroup;

        private var background:FlxSprite;
        private var player:Player;

        private var darkness_color:uint = 0xaa000000;
        private var darkness:FlxSprite;
        
        public static var WORLD_LIMITS:FlxPoint;

        private var world:World;
        private var currentRoom:Room;
        private var roomTitle:FlxText;

        private var cursor:GameCursor;

        private var tc:Boolean = true;

        public static var vocabulary:Vocabulary;
        
        override public function create():void {
            world = new World();
            WORLD_LIMITS = new FlxPoint(FlxG.width, FlxG.height);

            // Set up global vocabulary
            vocabulary = new Vocabulary();
            
            // Player
            player = new Player(145, 135);
            
            // Load room
            loadRoom('home');

            cursor.setText('test');
        }

        override public function update():void {
            if(FlxG.mouse.justPressed()) {
                player.setWalkTarget(FlxG.mouse.x);
            }

            if(FlxG.keys.justPressed('Z')) {
                if(tc) {
                    cursor.setText();
                    tc = false;
                } else {
                    cursor.setText('testing');
                    tc = true;                    
                }
            }
            
            super.update();
        }

        private function loadRoom(roomName:String):void {
            this.destroy(); // just destroys the group that contains objects for this state

            currentRoom = world.getRoom(roomName);
            backgroundGroup = currentRoom.backgrounds;
            playerGroup = new FlxGroup();

            playerGroup.add(player);

            this.add(backgroundGroup);
            this.add(playerGroup);

            roomTitle = new FlxText(8, 8, FlxG.width, currentRoom.title);
            roomTitle.setFormat("balderas", 8, 0xffffffff);
            this.add(roomTitle);

            hudGroup = new FlxGroup();
            hudGroup.add(vocabulary.currentVerbs);
            this.add(hudGroup);
            
            cursor = new GameCursor();
            this.add(cursor);
       }
    }
}