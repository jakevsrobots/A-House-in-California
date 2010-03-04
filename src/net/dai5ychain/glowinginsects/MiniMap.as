package net.dai5ychain.glowinginsects {
    import org.flixel.*;

    public class MiniMap extends FlxSprite {
        // Re-usable point object for calculating pixels to draw.
        private var map_pos:FlxPoint;

        private var map_scale_factor:uint = 4 * PlayState.TILE_SIZE;
        
        public function MiniMap():void {
            var _width:uint = PlayState.WORLD_LIMITS.x / map_scale_factor;
            var _height:uint = PlayState.WORLD_LIMITS.y / map_scale_factor;
            
            super(FlxG.width - _width, FlxG.height - _height);

            createGraphic(_width, _height, 0xff000000);

            map_pos = new FlxPoint;
        }

        public function update_map(fireflies:Array, player:Player):void {
            this.fill(0xff000000);
            
            for each(var firefly:Firefly in fireflies) {
                if(!firefly.dead) {
                    map_pos.x = firefly.x / map_scale_factor;
                    map_pos.y = firefly.y / map_scale_factor;

                    this._framePixels.setPixel(map_pos.x, map_pos.y, 0xffd12d16);
                }
            }

            map_pos.x = player.x / map_scale_factor;
            map_pos.y = player.y / map_scale_factor;

            this._framePixels.setPixel(map_pos.x, map_pos.y, 0xff5080a0);
        }
    }
}