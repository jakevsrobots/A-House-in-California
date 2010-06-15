package california {
    import org.flixel.*;
    import AssetLibrary;
    import SWFStats.*;
    
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

        public function Main():void {
            library = new AssetLibrary();
            gameXML = new XML(new GameXMLFile());
            logViewInitialized = false;
            
            //super(320, 170, MenuState, 2);
            super(320, 170, PlayState, 2);
            
            FlxState.bgColor = Main.bgcolor;
        }
    }
}