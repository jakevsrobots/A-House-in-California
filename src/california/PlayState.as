package california {
    import Date;
    import org.flixel.*;
    import california.sprites.*;
    import SWFStats.*;

    import california.music.*;
    
    public class PlayState extends FlxState {
        private var roomGroup:FlxGroup;    
        private var backgroundGroup:FlxGroup;
        private var spriteGroup:FlxGroup;        
        private var hudGroup:FlxGroup;

        private var background:FlxSprite;
        public static var player:Player;

        private var darkness_color:uint = 0xd0000000;
        private var darkness:FlxSprite;
        private var fadeDarkness:Boolean = false;

        // end of level fadeout
        private var preMenuFade:Boolean = false;
        private var fadeStartTimer:Number;
        
        public static var WORLD_LIMITS:FlxPoint;

        private var world:World;
        public var currentRoom:Room;
        private var roomTitle:FlxText;
        private var cursor:GameCursor;

        public static var vocabulary:Vocabulary;
        public static var dialog:DialogWindow;
        public static var hasMouseFocus:Boolean = true;
        public static var instance:PlayState;
        
        private var currentVerb:Verb;

        //private var startingRoomName:String = 'aHouseAtTheTopOfAHill';
        private var startingRoomName:String = 'beulahHome';
        //private var startingRoomName:String = 'upOnACloud';

        public static var musicPlayer:MusicPlayer;
        
        //-----------------------------
        // Game data
        //-----------------------------
        public var flags:Object;
        
        public function PlayState(startingRoomName:String=null) {
            if(startingRoomName != null) {
                this.startingRoomName = startingRoomName;
            }
            
            super();
        }
        
        override public function create():void {
            PlayState.instance = this;
            
            if(!Main.logViewInitialized) {
                Log.View(540, "9f491e53-4116-4945-85e7-803052dc1b05", root.loaderInfo.loaderURL);
                Main.logViewInitialized = true;
            }

            Log.Play();
            
            flags = {};
            
            FlxG.flash.start(0xff000000, 3.0, function():void {
                    FlxG.flash.stop();
                });

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
            player = new Player("loisPlayer", 145, 135);

            // Load room
            loadRoom(this.startingRoomName);

            currentVerb = vocabulary.verbData['Look'];
            
            hudGroup = new FlxGroup();
            hudGroup.add(vocabulary.currentVerbs);
            add(hudGroup);
            
            cursor = new GameCursor();
            add(cursor);

            dialog = new DialogWindow();
            add(dialog);
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

                    var spritesToCheck:Array = currentRoom.sprites.members.concat();
                    spritesToCheck.push(PlayState.player);
                    spritesToCheck = spritesToCheck.reverse();
                    
                    for each(var sprite:GameSprite in spritesToCheck) {
                        if(sprite.interactive) {
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

                    }

                    if(!cursorOverlappedSprite) {
                        cursor.setText(currentVerb.name);                    
                    }
                }
            } else {
                cursor.visible = false;
            }

            // Update darkness fade
            if(fadeDarkness) {
                darkness.alpha -= 0.5 * FlxG.elapsed;
                if(darkness.alpha < 0) {
                    darkness.alpha = 0;
                }
            }

            // Update end of level fade
            if(preMenuFade) {
                PlayState.hasMouseFocus = false;
                if(fadeStartTimer > 0) {
                    fadeStartTimer -= FlxG.elapsed;
                } else {
                    preMenuFade = false;
                    FlxG.fade.start(0xffffffff, 2, function():void {
                            FlxG.fade.stop();
                            FlxG.state = new MenuState(0xffffffff);
                            //FlxG.state = new ThanksForTestingState(0xffffffff);
                        });
                }
            }
            
            super.update();
        }

        override public function render():void {
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

        static public function getFlag(flagName:String):Boolean {
            if(PlayState.instance.flags.hasOwnProperty(flagName) && instance.flags[flagName]) {
                return true;
            } else {
                return false;
            }
        }

        static public function setFlag(flagName:String, flagValue:Boolean):void {
            PlayState.instance.flags[flagName] = flagValue;
        }
        
        static public function removeSprite(targetSpriteName:String):void {
            var targetSprite:GameSprite = PlayState.instance.currentRoom.getSprite(targetSpriteName);

            if(targetSprite != null) {
                PlayState.instance.currentRoom.sprites.remove(targetSprite, true);
            }
        }

        static public function addSprite(spriteName:String, x:Number, y:Number, width:Number=NaN, height:Number=NaN):void {
            var SpriteClass:Class = GameSprite.spriteDatabase[spriteName]['spriteClass'];
            var newSprite:GameSprite;

            if(!isNaN(width) && !isNaN(height)) {
                newSprite = new SpriteClass(spriteName, x, y, width, height);
            } else {
                newSprite = new SpriteClass(spriteName, x, y);
            }

            PlayState.instance.currentRoom.sprites.add(newSprite);
        }
        
        static public function replaceSprite(oldSpriteName:String, newSpriteName:String, x:Number, y:Number):void {
            var oldSprite:GameSprite = PlayState.instance.currentRoom.getSprite(oldSpriteName);

            if(!GameSprite.spriteDatabase.hasOwnProperty(newSpriteName)) {
                throw new Error("No sprite data found for " + newSpriteName);
            }
            
            if(oldSprite != null) {
                var SpriteClass:Class = GameSprite.spriteDatabase[newSpriteName]['spriteClass'];

                if(isNaN(y)) {
                    y = oldSprite.y;
                }

                if(isNaN(x)) {
                    x = oldSprite.x;
                }
                
                var newSprite:GameSprite = new SpriteClass(newSpriteName, x, y);
                
                PlayState.instance.currentRoom.sprites.replace(oldSprite, newSprite);
            }
        }

        static public function moveSprite(targetSpriteName:String, x:Number, y:Number):void {
            var sprite:GameSprite = PlayState.instance.currentRoom.getSprite(targetSpriteName);

            if(!isNaN(x)) {
                sprite.x = x;
            }

            if(!isNaN(y)) {
                sprite.y = y;
            }
        }
        
        static public function addVerb(newVerbName:String):void {
            PlayState.vocabulary.addVerbByName(newVerbName);
        }

        static public function removeVerb(targetVerbName:String):void {
            PlayState.vocabulary.removeVerbByName(targetVerbName);
        }

        public function replaceVerb(oldVerbName:String, newVerbName:String):void {
            PlayState.vocabulary.replaceVerb(oldVerbName, newVerbName);

            if(currentVerb.name == oldVerbName) {
                currentVerb = PlayState.vocabulary.verbData['Look'];
            }
        }

        static public function changePlayer(newPlayer:Player):void {
            //PlayState.instance.spriteGroup.replace(PlayState.player, newPlayer);
            
            PlayState.instance.roomGroup.replace(PlayState.player, newPlayer);
            PlayState.instance.spriteGroup.replace(PlayState.player, newPlayer);
            PlayState.player = newPlayer;            
        }
        
        public function fadeToMenu(delay:Number):void {
            this.preMenuFade = true;
            this.fadeStartTimer = delay;
        }
        
        public function removeDarkness():void {
            fadeDarkness = true;
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

            /*
            if(spriteGroup.members.indexOf(player) == -1) {
                spriteGroup.add(player);
            }
            */
            
            roomGroup.add(backgroundGroup);
            roomGroup.add(spriteGroup);            

            roomGroup.add(darkness);
            
            roomTitle = new FlxText(8, 8, FlxG.width, currentRoom.title);
            roomTitle.setFormat(Main.gameFontFamily, Main.gameFontSize, 0xffffffff);
            roomGroup.add(roomTitle);

            roomGroup.add(player);

            currentRoom.enterRoom();
            
            Log.CustomMetric(currentRoom.roomName, "Room entry");
       }
    }
}