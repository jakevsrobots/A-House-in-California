package california {
    import org.flixel.*;
    import AssetLibrary;
    //import SWFStats.*;
    import california.sprites.*;
    import california.behaviors.*;
    import california.music.*;
        
    import flash.net.SharedObject;
    import flash.display.StageDisplayState;

    [SWF(width="640", height="340", backgroundColor="#000000")];

    [Frame(factoryClass="Preloader")]
    
    //[SWF(width="640", height="440", backgroundColor="#000000")];

    public class Main extends FlxGame {
        public static var gameFontFamily:String;
        public static var gameFontSize:uint;        
        
        //public static var bgcolor:uint = 0xff303030;
        public static var bgcolor:uint = 0xff000000;

        public static var library:AssetLibrary;

        [Embed(source="/../data/game.xml",
                mimeType="application/octet-stream")]
        private var GameXMLFile:Class;

        public static var gameXML:XML;
        public static var logViewInitialized:Boolean;
        public static var saveGame:SharedObject;

        public static var instance:Main;
        
        public function Main():void {
            Main.instance = this;

            gameFontFamily = 'system';
            gameFontSize = 8;
            
            library = new AssetLibrary();
            gameXML = new XML(new GameXMLFile());

            Behavior.registerBehaviorClasses({
                    "dialog": DialogBehavior,
                    "transitionToRoom": TransitionToRoomBehavior,
                    "replaceSprite": ReplaceSpriteBehavior,
                    "removeSprite": RemoveSpriteBehavior,
                    "addSprite": AddSpriteBehavior,
                    "addVerb": AddVerbBehavior,
                    "flash": FlashBehavior,
                    "soundEffect": SoundEffectBehavior,
                    "removeVerb": RemoveVerbBehavior,
                    "replaceVerb": ReplaceVerbBehavior,
                    "catchFireflies": CatchFirefliesBehavior,
                    "fadeToMenu": FadeToMenuBehavior,
                    "setFlag": SetFlagBehavior,
                    "setVocabulary": SetVocabularyBehavior,
                    "setPlayer": SetPlayerBehavior,
                    "playMusic": PlayMusicBehavior,
                    "moveSprite": MoveSpriteBehavior,
                    "updateBirds": UpdateBirdsBehavior,
                    "catchButterflies": CatchButterfliesBehavior,
                    "fadeToCutScene": FadeToCutSceneBehavior
                });
            
            GameSprite.registerSpriteClasses({
                    "TrappedFireflies": TrappedFireflies,
                    "Moon": Moon,
                    "MoonStars": MoonStars,
                    "Window": Window,
                    "ComputerScreenBoy": ComputerScreenBoy,
                    "ComputerScreenRockysBoots": ComputerScreenRockysBoots,
                    "JarOfBugs": JarOfBugs,
                    "LooseFireflies": LooseFireflies,
                    "LampFireflies": LampFireflies,
                    "HouseCloud": HouseCloud,
                    "LightedLampPost": LightedLampPost,
                    "Bird": Bird,
                    "AirplaneWithBanner": AirplaneWithBanner,
                    "TinyLampPost": TinyLampPost,
                    "SmallLightbulb": SmallLightbulb,
                    "Butterfly": Butterfly,
                    "Television": Television,
                    "Car": Car
                });

            GameSprite.createSpriteDatabase();

            MusicPlayer.registerMusicPlayerClasses({
                    "lois": LoisMusicPlayer,
                    "beulah": BeulahMusicPlayer
                });
            
            logViewInitialized = false;

            FlxG.showBounds = false;

            //super(320, 170, MenuState, 2);
            //super(320, 170, PlayState, 2);
            super(320, 170, StartState, 2);

            FlxState.bgColor = Main.bgcolor;

            saveGame = SharedObject.getLocal('aHouseInCalifornia_savedata');
            
            saveGame.data['sectionsUnlocked'] = ['lois', 'beulah', 'connie'];
            //saveGame.data['sectionsUnlocked'] = ['lois'];

            /*
            if(saveGame.data['sectionsUnlocked'] == null) {
                saveGame.data['sectionsUnlocked'] = ['lois'];
            }*/

            //stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
            //stage.displayState = 'fullScreenInteractive';
        }
    }
}