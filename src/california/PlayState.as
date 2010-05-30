package california {
    import org.flixel.*;
    import california.sprites.*;
    
    public class PlayState extends FlxState {
        [Embed(source="/../data/autotiles.png")]
            private var AutoTiles:Class;
        
        private var backgroundGroup:FlxGroup;
        private var spriteGroup:FlxGroup;        
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
        private var currentVerb:Verb;

        public static var dialog:DialogWindow;

        public static var hasMouseFocus:Boolean = true;
        
        override public function create():void {
            world = new World();
            WORLD_LIMITS = new FlxPoint(FlxG.width, FlxG.height);

            // Set up global vocabulary
            vocabulary = new Vocabulary();
            
            // Player
            player = new Player(145, 135);
            
            // Load room
            loadRoom('home');

            currentVerb = vocabulary.verbData['Walk'];

            dialog = new DialogWindow();
            add(dialog);
        }

        override public function update():void {
            var verb:Verb; // used to iterate thru verbs below in a few places

            if(PlayState.hasMouseFocus) {
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
                                currentVerb = verb;
                            }

                            break;
                        }
                    }
                } else {
                    // Game area mouse behavior
                    
                    for each (verb in vocabulary.currentVerbs.members) {
                        if(verb == currentVerb) {
                            verb.highlight = true;
                        } else {
                            verb.highlight = false;
                        }
                    }

                    var cursorOverlappedSprite:Boolean = false;

                    for each(var sprite:GameSprite in currentRoom.sprites.members) {
                        if(cursor.spriteHitBox.overlaps(sprite)) {
                            cursor.setText(sprite.getVerbText(currentVerb));
                            cursorOverlappedSprite = true;

                            if(FlxG.mouse.justPressed()) {
                                FlxG.log('attempting to handle verb ' + currentVerb + ' with sprite ' + sprite);
                                sprite.handleVerb(currentVerb);
                            }
                        }
                    }

                    if(!cursorOverlappedSprite) {
                        cursor.setText(currentVerb.name);                    
                    }

                    if(FlxG.mouse.justPressed()) {
                        if(currentVerb.name == 'Walk') {
                            player.setWalkTarget(FlxG.mouse.x);
                        }
                    }
                }
            }
            super.update();
        }

        private function loadRoom(roomName:String):void {
            this.destroy(); // just destroys the group that contains objects for this state

            currentRoom = world.getRoom(roomName);
            backgroundGroup = currentRoom.backgrounds;
            spriteGroup = currentRoom.sprites;            
            playerGroup = new FlxGroup();

            playerGroup.add(player);

            this.add(backgroundGroup);
            this.add(spriteGroup);            
            this.add(playerGroup);

            roomTitle = new FlxText(8, 8, FlxG.width, currentRoom.title);
            roomTitle.setFormat(null, 8, 0xffffffff);
            this.add(roomTitle);

            hudGroup = new FlxGroup();
            hudGroup.add(vocabulary.currentVerbs);
            this.add(hudGroup);
            
            cursor = new GameCursor();
            this.add(cursor);

            add(dialog);
       }
    }
}