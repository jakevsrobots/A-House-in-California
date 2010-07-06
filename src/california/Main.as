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
                    "playMusic": PlayMusicBehavior
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
                    "HouseCloud": HouseCloud
                });

            GameSprite.createSpriteDatabase();

            MusicPlayer.registerMusicClasses({
                    "lois": LoisMusicPlayer
                });
            
            logViewInitialized = false;
            
            super(320, 170, MenuState, 2);
            //super(320, 170, PlayState, 2);

            FlxState.bgColor = Main.bgcolor;

            saveGame = SharedObject.getLocal('aHouseInCalifornia_savedata');
            saveGame.data['sectionsUnlocked'] = ['lois', 'beulah'];
            if(saveGame.data['sectionsUnlocked'] == null) {
                saveGame.data['sectionsUnlocked'] = ['lois'];
            }
        }
    }
}