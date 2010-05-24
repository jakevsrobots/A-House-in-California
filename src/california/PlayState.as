package california {
    import org.flixel.*;

    public class PlayState extends FlxState {
        //[Embed(source='/../data/gardenia.ttf', fontFamily='gardenia')]
        //private var GardeniaFont:String;
        
        [Embed(source='/../data/Balderas.ttf', fontFamily='balderas')]
        private var BalderasFont:String;

        [Embed(source="/../data/autotiles.png")]
            private var AutoTiles:Class;
        
        private var background_group:FlxGroup;
        private var player_group:FlxGroup;

        private var background:FlxSprite;
        
        private var player:Player;

        private var darkness_color:uint = 0xaa000000;
        private var darkness:FlxSprite;
        
        public static var WORLD_LIMITS:FlxPoint;

        private var hud:FlxSprite;
        private var room_title:FlxText;
        
        private var world:World;
        private var currentRoom:Room;

        private var input_field:FlxInputText;

        override public function create():void {
            world = new World();
            WORLD_LIMITS = new FlxPoint(FlxG.width, FlxG.height);

            // Player
            player = new Player(145, 135);
            
            // Load room
            loadRoom('home');
        }

        override public function update():void {
            if(FlxG.mouse.justPressed()) {
                player.setWalkTarget(FlxG.mouse.x);
            }
            
            super.update();
        }

        private function loadRoom(roomName:String):void {
            this.destroy(); // just destroys the group that contains objects for this state

            currentRoom = world.getRoom(roomName);
            background_group = currentRoom.backgrounds;
            player_group = new FlxGroup();

            player_group.add(player);

            this.add(background_group);
            this.add(player_group);

            room_title = new FlxText(8, 8, FlxG.width, currentRoom.title);
            room_title.setFormat("balderas", 8, 0xffffffff);
            this.add(room_title);

       }
    }
}