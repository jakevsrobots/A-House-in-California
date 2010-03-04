package net.dai5ychain.glowinginsects {
    import org.flixel.*;

    import com.adobe.serialization.json.JSON;
    
    public class PlayState extends FlxState {
        [Embed(source='/../data/jar.png')]
        private var JarImage:Class;
        
        private var background_group:FlxGroup;
        private var walls_group:FlxGroup;
        private var player_group:FlxGroup;
        private var ladders_group:FlxGroup;
        private var fireflies_group:FlxGroup;        
                
        private var walls_map:FlxTilemap;

        [Embed(source="/../data/world.json", mimeType="application/octet-stream")]
        private var WorldMapJSON:Class;
        [Embed(source="/../data/autotiles.png")]
        private var AutoTiles:Class;
        
        private var player:Player;
        private var jar:FlxSprite;

        public static var JAR_POSITION:FlxPoint;
        
        public static const TILE_SIZE:uint=8;
        public static var WORLD_LIMITS:FlxPoint;

        override public function create():void {
            walls_group = new FlxGroup;
            this.add(walls_group);
            
            ladders_group = new FlxGroup;
            this.add(ladders_group);
            
            player_group = new FlxGroup;
            this.add(player_group);

            fireflies_group = new FlxGroup;
            this.add(fireflies_group);

            JAR_POSITION = new FlxPoint(19 * TILE_SIZE, 77 * TILE_SIZE);
            
            jar = new FlxSprite(JAR_POSITION.x, JAR_POSITION.y, JarImage);
            this.add(jar);
            
            // Load map
            var map:Object = JSON.decode(new WorldMapJSON);
            WORLD_LIMITS = new FlxPoint;
            WORLD_LIMITS.x = map['width'] * TILE_SIZE;
            WORLD_LIMITS.y = map['height'] * TILE_SIZE;            
            var sprite_index_map:Object = {
                'ladder': 2
            };
            for(var i:uint = 0; i < map['layers'].length; i++) {
                var layer:Object = map['layers'][i];

                if(layer['name'] == 'walls') {
                    walls_map = new FlxTilemap;
                    walls_map.auto = FlxTilemap.AUTO;
                    walls_map.loadMap(layer['tiles'], AutoTiles, TILE_SIZE, TILE_SIZE);
                    walls_map.follow();
                    walls_group.add(walls_map);
                } else if(layer['name'] == 'sprites') {
                    // This method for parsing the csv tiles is from FlxTilemap.as
                    var rows:Array = layer['tiles'].split("\n");
                    var cols:Array;
                    var tile_data:Array = [];
                    for(var r:uint = 0; r < rows.length; r++) {
                        cols = rows[r].split(",");
                        for(var c:uint = 0; c < cols.length; c++) {
                            tile_data.push(uint(cols[c]));
                        }
                    }
                    
                    for(var y:uint=0; y < map['height']; y++) {
                        for(var x:uint=0; x < map['width']; x++) {
                            var gid:uint = tile_data[y * map['width'] + x];
                            var sprite_position:FlxPoint = new FlxPoint(x * TILE_SIZE, y * TILE_SIZE);

                            switch(gid) {
                                // Ladders
                                case sprite_index_map['ladder']:
                                ladders_group.add(new Ladder(sprite_position.x, sprite_position.y));
                                break;
                            }
                        }
                    }
                }
            }

            // Generate fireflies
            for(var bug_i:uint = 0; bug_i < GlowingInsects.bug_count; bug_i++) {
                
                fireflies_group.add(
                    new Firefly(
                        JAR_POSITION.x + uint(Math.random() * 16),
                        JAR_POSITION.y + uint(Math.random() * 16))
                );
            }
            
            // Player
            player = new Player(5 * TILE_SIZE,77 * TILE_SIZE);
            player_group.add(player);

            FlxG.followAdjust(0.5,0.5);
            FlxG.follow(player, 2.5);
        }

        override public function update():void {
            walls_map.collide(player);

            // Check ladder overlaps.
            player.on_ladder = false;
            FlxU.overlap(player, ladders_group,
                function(player:FlxObject, ladder:FlxObject):void {
                    (player as Player).on_ladder = true;
                });
            
            // Check firefly overlaps.
            FlxU.overlap(player, fireflies_group,
                function(player:FlxObject, firefly:FlxObject):void {
                    if((firefly as Firefly).behavior_state == Firefly.FLYING_FREE) {
                        (player as Player).add_firefly();
                        firefly.kill();
                    }
                });

            // Check jar overlap
            if(jar.alpha == 1.0) {
                FlxU.overlap(player, jar,
                    function(player:FlxObject, jar:FlxObject):void {
                        FlxG.flash.start(0xfff14d36);
                        (jar as FlxSprite).alpha = 0.5;
                        
                        for each(var firefly:Firefly in fireflies_group.members) {
                            firefly.fly_to_first_point();
                        }
                    });
            }
            
            super.update();
        }

        override public function preProcess():void {
            super.preProcess();
        }
        
        override public function postProcess():void {
            super.postProcess();
        }
    }
}