package california {
    import org.flixel.*;

    public class PlayState extends FlxState {
        [Embed(source='/../data/gardenia.ttf', fontFamily='gardenia')]
        private var GardeniaFont:String;
        
        private var background_group:FlxGroup;
        private var walls_group:FlxGroup;
        private var player_group:FlxGroup;
        private var fireflies_group:FlxGroup;
                
        private var walls_map:FlxTilemap;

        [Embed(source="/../data/autotiles.png")]
        private var AutoTiles:Class;
        
        [Embed(source="/../data/lamp-post.png")]
        private var LampPostImage:Class;

        private var background:FlxSprite;
        
        private var player:Player;

        private var darkness_color:uint = 0xdd000000;
        private var darkness:FlxSprite;
        
        public static var WORLD_LIMITS:FlxPoint;

        private var hud:FlxSprite;
        private var room_title:FlxText;

        private var world:World;
        
        override public function create():void {
            world = new World();

            WORLD_LIMITS = new FlxPoint(FlxG.width, FlxG.height);
            
            walls_group = new FlxGroup;
            this.add(walls_group);

            background_group = new FlxGroup;
            this.add(background_group);
            
            player_group = new FlxGroup;
            this.add(player_group);

            fireflies_group = new FlxGroup;
            this.add(fireflies_group);

            darkness = new FlxSprite(0,0);
            darkness.createGraphic(FlxG.width, FlxG.height, darkness_color);
            darkness.scrollFactor.x = darkness.scrollFactor.y = 0;
            darkness.blend = "multiply";
            this.add(darkness);

            // Load map
            walls_map = new FlxTilemap;
            walls_map.auto = FlxTilemap.AUTO;
            walls_map.loadMap(FlxTilemap.pngToCSV(world.rooms.home.walls, true), AutoTiles, 1, 1);

            walls_group.add(walls_map);
            
            background = new FlxSprite(0, 0, world.rooms.home.background);
            background_group.add(background);

            // Player
            player = new Player(16, 48);
            player.darkness = darkness;
            player_group.add(player);

            // Room Title
            //room_title = new FlxText(8, 8, FlxG.width, 'A House in California');
            room_title = new FlxText(8, 8, FlxG.width, 'A train station in Toledo');
            room_title.setFormat("gardenia", 8, 0xffffffff);
            this.add(room_title);

            // make some starting fireflies
            for(var i:uint = 0; i < 5; i++) {
                var firefly:Firefly = new Firefly(
                    uint(Math.random() * FlxG.width),
                    uint(Math.random() * FlxG.height),
                    darkness
                );

                fireflies_group.add(firefly);
            }
        }

        override public function update():void {
            walls_map.collide(player);
            
            for each(var firefly:Firefly in fireflies_group.members) {
                if(firefly.behavior_state == Firefly.FLYING_FREE) {
                    walls_map.collide(firefly);
                }
            }
            
            // Check firefly overlaps.
            FlxU.overlap(player, fireflies_group,
                function(player:FlxObject, firefly:FlxObject):void {
                    if((firefly as Firefly).behavior_state == Firefly.FLYING_FREE) {
                        FlxG.flash.start(Main.bug_color, 0.5);                        
                        (player as Player).add_firefly();
                        firefly.kill();
                    }
                });

            super.update();
        }

        override public function render():void {
            darkness.fill(darkness_color);

            super.render();
        }

        override public function preProcess():void {
            super.preProcess();
        }
        
        override public function postProcess():void {
            super.postProcess();
        }
    }
}