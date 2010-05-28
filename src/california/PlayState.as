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

        public static var vocabulary:Vocabulary;

        private var currentVerbName:String;
        
        override public function create():void {
            world = new World();
            WORLD_LIMITS = new FlxPoint(FlxG.width, FlxG.height);

            // Set up global vocabulary
            vocabulary = new Vocabulary();
            
            // Player
            player = new Player(145, 135);
            
            // Load room
            loadRoom('home');

            currentVerbName = 'walk'
        }

        override public function update():void {
            var verb:Verb; // used to iterate thru verbs below in a few places
            
            if(FlxG.mouse.y > 146) {
                // UI area mouse behavior
                cursor.setText(null);

                for each (verb in vocabulary.currentVerbs.members) {
                    verb.highlight = false;
                }
                for each (verb in vocabulary.currentVerbs.members) {
                    if(cursor.graphic.overlaps(verb)) {
                        verb.highlight = true;
                        if(FlxG.mouse.justPressed()) {
                            currentVerbName = verb.name;
                        }

                        break;
                    }
                }
            } else {
                for each (verb in vocabulary.currentVerbs.members) {
                    if(verb.name == currentVerbName) {
                        verb.highlight = true;
                    } else {
                        verb.highlight = false;
                    }
                }
                
                // Game area mouse behavior
                cursor.setText(currentVerbName);
                
                if(FlxG.mouse.justPressed()) {
                    player.setWalkTarget(FlxG.mouse.x);
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