package net.dai5ychain.afterandbefore {
    import org.flixel.*;

    import net.dai5ychain.afterandbefore.phenomena.*;
    
    import com.adobe.serialization.json.JSON;
    
    public class PlayState extends FlxState {
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

        private var phenomena:Array;

        private var current_phenomenon:Phenomenon;
        
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
            
            // Load map
            var map:Object = JSON.decode(new WorldMapJSON);
            WORLD_LIMITS = new FlxPoint;
            WORLD_LIMITS.x = map['width'] * TILE_SIZE;
            WORLD_LIMITS.y = map['height'] * TILE_SIZE;            
            var sprite_index_map:Object = {
                'ladder': 2,
                'firefly': 3
            };
            for(var i:uint = 0; i < map['layers'].length; i++) {
                var layer:Object = map['layers'][i];

                if(layer['name'] == 'walls') {
                    trace('loading walls');
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
                    
                    trace('loading sprites');
                    for(var y:uint=0; y < map['height']; y++) {
                        for(var x:uint=0; x < map['width']; x++) {
                            var gid:uint = tile_data[y * map['width'] + x];
                            var sprite_position:FlxPoint = new FlxPoint(x * TILE_SIZE, y * TILE_SIZE);

                            switch(gid) {
                                // Ladders
                                case sprite_index_map['ladder']:
                                ladders_group.add(new Ladder(sprite_position.x, sprite_position.y));
                                break;

                                // Fireflies
                                case sprite_index_map['firefly']:
                                fireflies_group.add(new Firefly(sprite_position.x, sprite_position.y));
                                break;
                            }
                        }
                    }
                }
            }

            // Player
            player = new Player(5 * TILE_SIZE,77 * TILE_SIZE);
            player_group.add(player);

            FlxG.followAdjust(0.5,0.5);
            FlxG.follow(player, 2.5);

            // Phenomena
            phenomena = [
                new Trails(16 * TILE_SIZE, 69 * TILE_SIZE, player)
            ];

            //current_phenomenon = null;
            current_phenomenon = phenomena[0];
        }

        override public function update():void {
            walls_map.collide(player);

            // Check ladder overlaps.
            player.on_ladder = false;
            FlxU.overlap(player, ladders_group, function(player:FlxObject, ladder:FlxObject):void {
                    (player as Player).on_ladder = true;
                });
            /*
            if(player.x >= walls_map.width - player.width) {
                trace('off right');
            } else if(player.x <= 2) {
                trace('off left');
            } else {
                trace('----');
            }*/
            
            super.update();
        }

        override public function preProcess():void {
            if(current_phenomenon) {
                current_phenomenon.preProcess();
            } else {
                super.preProcess();
            }

                
        }
        
        override public function postProcess():void {
            if(current_phenomenon) {
                current_phenomenon.postProcess();
            } else {
                super.postProcess();
            }
 
        }
    }
}