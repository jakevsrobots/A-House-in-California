package california {
    import org.flixel.*;
    import california.sprites.*;
    import SWFStats.*;
    
    public class PlayState extends FlxState {
        private var roomGroup:FlxGroup;    
        private var backgroundGroup:FlxGroup;
        private var spriteGroup:FlxGroup;        
        private var hudGroup:FlxGroup;

        private var background:FlxSprite;
        public static var player:Player;

        private var darkness_color:uint = 0xd0000000;
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
        public static var instance:PlayState;

        private var startingRoomName:String = 'loisHome';
        
        public function PlayState(startingRoomName:String=null) {
            if(startingRoomName != null) {
                this.startingRoomName = startingRoomName;
            }
            
            super();
        }
        
        override public function create():void {
            Log.Play();
            
            FlxG.flash.start(0xff000000, 1.0, function():void {
                    FlxG.flash.stop();
                });
            
            GameSprite.createSpriteDatabase();
            
            roomGroup = new FlxGroup();
            
            add(roomGroup);
            
            world = new World();
            WORLD_LIMITS = new FlxPoint(FlxG.width, FlxG.height);

            // Set up global vocabulary
            vocabulary = new Vocabulary();

            // Darkness overlay
            darkness = new FlxSprite(0,0);
            darkness.createGraphic(FlxG.width, FlxG.height - 24, darkness_color);
            darkness.blend = "multiply";
            darkness.alpha = 1.0;
             
            // Player
            //player = new Player(145, 135);
            player = new LoisPlayer(145, 135);
            
            // Load room
            loadRoom(this.startingRoomName);
            //loadRoom('loisHome');
            //loadRoom('aComputerInAGuestRoom');

            currentVerb = vocabulary.verbData['Look'];
            
            hudGroup = new FlxGroup();
            hudGroup.add(vocabulary.currentVerbs);
            add(hudGroup);
            
            cursor = new GameCursor();
            add(cursor);

            dialog = new DialogWindow();
            add(dialog);

            PlayState.instance = this;

            FlxG.playMusic(Main.library.getAsset('loisMusic'));
        }

        override public function update():void {
            var verb:Verb; // used to iterate thru verbs below in a few places

            if(PlayState.hasMouseFocus) {
                cursor.visible = true;
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
                    
                    for each(var sprite:GameSprite in currentRoom.sprites.members.concat().reverse()) {
                        if(cursor.spriteHitBox.overlaps(sprite)) {
                            cursor.setText(sprite.getVerbText(currentVerb));
                            cursorOverlappedSprite = true;

                            if(FlxG.mouse.justPressed()) {
                                Log.CustomMetric(currentVerb.name + '|' + sprite.name + '|' + currentRoom.roomName, "Verb action");
                                sprite.handleVerb(currentVerb);
                            }
                            
                            break;
                        }

                    }

                    if(!cursorOverlappedSprite) {
                        cursor.setText(currentVerb.name);                    
                    }
                }
            } else {
                cursor.visible = false;
            }
            super.update();
        }

        override public function render():void {
            if(currentRoom.darkness) {
                darkness.fill(darkness_color);
                
                for each(var sprite:GameSprite in spriteGroup.members) {
                    if(sprite.hasOwnProperty('glow')) {
                        var glow:FlxSprite;
                        if(sprite['glow'] is FlxSprite) {
                            glow = sprite['glow'];
                            
                            darkness.draw(glow, glow.x, glow.y);
                        } else if(sprite['glow'] is FlxGroup) {
                            for each(glow in sprite['glow'].members) {
                                darkness.draw(glow, glow.x, glow.y);   
                            }
                        }
                    }
                }
            }
            
            super.render();
        }
        
        static public function transitionToRoom(roomName:String):void {
            var fadeDuration:Number = 0.5;
            
            PlayState.hasMouseFocus = false;
            
            FlxG.fade.start(0xff000000, fadeDuration, function():void {
                    FlxG.fade.stop();
                    instance.loadRoom(roomName);
                    FlxG.flash.start(0xff000000, fadeDuration, function():void {
                            PlayState.hasMouseFocus = true;
                            FlxG.flash.stop();
                        });
                });
        }

        static public function removeSprite(targetSpriteName:String):void {
            var targetSprite:GameSprite = PlayState.instance.currentRoom.getSprite(targetSpriteName);

            if(targetSprite != null) {
                PlayState.instance.currentRoom.sprites.remove(targetSprite, true);
            } else {
                FlxG.log('target sprite was null: ' + targetSpriteName);
            }
        }
        
        static public function replaceSprite(oldSpriteName:String, newSpriteName:String):void {
            FlxG.log('trying to replace ' + oldSpriteName + ' with ' + newSpriteName);
            var oldSprite:GameSprite = PlayState.instance.currentRoom.getSprite(oldSpriteName);

            if(oldSprite != null) {
                var SpriteClass:Class = GameSprite.spriteDatabase[newSpriteName]['spriteClass'];
                var newSprite:GameSprite = new SpriteClass(newSpriteName, oldSprite.x, oldSprite.y);
                
                PlayState.instance.currentRoom.sprites.replace(oldSprite, newSprite);
            } else {
                FlxG.log('old sprite was null: ' + oldSpriteName);
            }
        }

        static public function addVerb(newVerbName:String):void {
            PlayState.vocabulary.addVerbByName(newVerbName);
        }
        
        private function loadRoom(roomName:String):void {
            // I will have to see how this affects performance; clearing
            // the list instead of calling 'destroy()'.
            // The issue is that the members of these sub-groups need
            // to be re-used (with persistent changes).
            // roomGroup.destroy();
            roomGroup.members.length = 0;
            
            currentRoom = world.getRoom(roomName);
            backgroundGroup = currentRoom.backgrounds;
            spriteGroup = currentRoom.sprites;
            
            if(spriteGroup.members.indexOf(player) == -1) {
                spriteGroup.add(player);
            }
            
            roomGroup.add(backgroundGroup);
            roomGroup.add(spriteGroup);            

            if(currentRoom.darkness) {
                FlxG.log('ADDING DARK');
                roomGroup.add(darkness);
            } else {
                FlxG.log('NO DARK');
            }
            
            roomTitle = new FlxText(8, 8, FlxG.width, currentRoom.title);
            roomTitle.setFormat(null, 8, 0xffffffff);
            roomGroup.add(roomTitle);
            
            FlxG.log('finished loading room ' + roomName);

            Log.CustomMetric(currentRoom.roomName, "Room entry");
       }
    }
}