package california {
    import org.flixel.*;
    import AssetLibrary;
    import SWFStats.*;
    import california.sprites.*;
    import california.behaviors.*;
    import california.music.*;
    
    import flash.net.SharedObject;
    
    [SWF(width="640", height="340", backgroundColor="#000000")];

    [Frame(factoryClass="Preloader")]
    
    //[SWF(width="640", height="440", backgroundColor="#000000")];

    public class Main extends FlxGame {
        /*

        // Alternate fonts?????
        
        [Embed(source='/../data/Antenna8.ttf', fontFamily='antenna8', embedAsCFF="false")]
        public static var Antenna8FontClass:String;

        [Embed(source='/../data/lilabit.ttf', fontFamily='lilabit', embedAsCFF="false")]
        public static var LilabitFontClass:String;

        [Embed(source='/../data/Pixilated.ttf', fontFamily='pixilated', embedAsCFF="false")]
        public static var PixilatedFontClass:String;

        [Embed(source='/../data/roundabout.ttf', fontFamily='roundabout', embedAsCFF="false")]
        public static var RoundaboutFontClass:String;
        
        [Embed(source='/../data/handy00.ttf', fontFamily='handy', embedAsCFF="false")]
        public static var HandyFontClass:String;

        [Embed(source='/../data/fixed_01.ttf', fontFamily='fixed01', embedAsCFF="false")]
        public static var Fixed01FontClass:String;
        
        [Embed(source='/../data/Nouveau_IBM.ttf', fontFamily='nouveau_ibm', embedAsCFF="false")]
        public static var NouveauibmFontClass:String;
        [Embed(source='/../data/Nouveau_IBM_Stretch.ttf', fontFamily='nouveau_ibm_stretch', embedAsCFF="false")]
        public static var NouveauibmstretchFontClass:String;
        */

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
        
        public function Main():void {
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
                    "updateBirds": UpdateBirdsBehavior
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
                    "TinyLampPost": TinyLampPost
                });

            GameSprite.createSpriteDatabase();

            MusicPlayer.registerMusicPlayerClasses({
                    "lois": LoisMusicPlayer,
                    "beulah": BeulahMusicPlayer
                });
            
            logViewInitialized = false;

            FlxG.showBounds = false;
            
            super(320, 170, MenuState, 2);
            //super(320, 170, PlayState, 2);

            FlxState.bgColor = Main.bgcolor;

            saveGame = SharedObject.getLocal('aHouseInCalifornia_savedata');
            
            saveGame.data['sectionsUnlocked'] = ['lois', 'beulah'];
            //saveGame.data['sectionsUnlocked'] = ['lois'];
            
            if(saveGame.data['sectionsUnlocked'] == null) {
                saveGame.data['sectionsUnlocked'] = ['lois'];
            }
        }
    }
}