package california {
    import flash.system.fscommand;    
    import org.flixel.*;
    import SWFStats.*;
    
    public class EndGameState extends FlxState {
        private var creditsText:FlxText;

        private var allCredits:Array;

        private var FADING_IN_CREDITS:int = 0;
        private var FADING_OUT_CREDITS:int = 1;
        private var HOLD_CREDITS:int = 2;
        private var DO_NOTHING_CREDITS:int = 3;
        
        private var creditsSwitchState:int;
        
        private var creditsSwitchMaxFadeTimer:Number = 2;
        private var creditsSwitchMaxHoldTimer:Number = 5;
        private var creditsSwitchTimer:Number;

        private var currentCreditIndex:int = 0;

        private var backgroundImage:FlxSprite;

        private var cursor:GameCursor;
        
        public function EndGameState():void {
            backgroundImage = new FlxSprite(0,0,Main.library.getAsset('menuBackground'));

            allCredits = [
                "In memory of Connie Ferguson and Beulah Karney.",
                "Design, development, text, art & music by Jake Elliott.",
                "Includes sound material derived from a field recording by mitchellsounds, licensed CC Sampling Plus 1.0",
                "Thanks to:\n\nLois, Beulah, Connie & Ann\n\nKacenda, Hattie & Eloise",
                "Thanks to alpha testers:\n\nStephen Lavelle, Gregory Weir, Christy LeMaster, Jeremy Voorhis, Tamas Kemenczy, Mark Beasley, Dan Najarian, Ryan Batten, Ben Cabot, Bredon Clay & Charlotte Elliott.",
                "This game was created with tools developed by:\n\nAdam Saltsman, Matt Thorson, Richard Stallman, Ableton and Adobe.", 
                "Thank you for playing. I would love to hear your feedback at cardboardcomputer@gmail.com."
            ];
            
            super();
        }
        
        override public function create():void {
            add(backgroundImage);
            
            creditsSwitchTimer = creditsSwitchMaxFadeTimer;
            creditsSwitchState = DO_NOTHING_CREDITS;
            
            creditsText = new FlxText(20, 20, 200, "A House in California. by Cardboard Computer 2010." );
            creditsText.setFormat(null, 8, 0xffffffff);
            add(creditsText);

            //FlxG.mouse.show();

            var quitButton:FlxButton = new FlxButton(232, 55, function():void {
                    //musicPlayer.fadeOut();
                    FlxG.fade.start(0xff000000, 2.0, function():void {
                            FlxG.fade.stop();
                            fscommand("quit");
                        });
                });
            quitButton.loadGraphic(
                new FlxSprite(0,0,Main.library.getAsset('quitButton')),
                new FlxSprite(0,0,Main.library.getAsset('quitButtonHover')));
            add(quitButton);

            var playAgainButton:FlxButton = new FlxButton(232, 23, function():void {
                    //musicPlayer.fadeOut();
                    FlxG.fade.start(0xff000000, 2.0, function():void {
                            FlxG.fade.stop();
                            FlxG.state = new CutSceneState('lois', 'loisHome');
                        });
                });
            playAgainButton.loadGraphic(
                new FlxSprite(0,0,Main.library.getAsset('playButton')),
                new FlxSprite(0,0,Main.library.getAsset('playButtonHover')));
            add(playAgainButton);

            FlxG.flash.start(0xff000000, 3.0, function():void {
                    FlxG.flash.stop();
                    creditsSwitchState = FADING_OUT_CREDITS;
                    //currentCreditIndex = 0;
                    //creditsText.text = allCredits[currentCreditIndex];
                });

            cursor = new GameCursor();
            cursor.setText(null);
            add(cursor);
        }

        override public function update():void {
            if(creditsSwitchState == FADING_IN_CREDITS) {
                creditsSwitchTimer -= FlxG.elapsed;

                creditsText.alpha = 1.0 - (creditsSwitchTimer / creditsSwitchMaxFadeTimer);
                
                if(creditsSwitchTimer <= 0) {
                    creditsSwitchTimer = creditsSwitchMaxHoldTimer;
                    creditsText.alpha = 1.0;
                    creditsSwitchState = HOLD_CREDITS;
                }
            } else if(creditsSwitchState == FADING_OUT_CREDITS) {
                creditsSwitchTimer -= FlxG.elapsed;

                creditsText.alpha = creditsSwitchTimer / creditsSwitchMaxFadeTimer;

                if(creditsSwitchTimer <= 0) {
                    creditsSwitchTimer = creditsSwitchMaxFadeTimer;
                    creditsText.alpha = 0.0;
                    creditsSwitchState = FADING_IN_CREDITS;
                    getNextText();
                }                
            } else if(creditsSwitchState == HOLD_CREDITS) {
                creditsSwitchTimer -= FlxG.elapsed;

                if(creditsSwitchTimer <= 0) {
                    creditsSwitchTimer = creditsSwitchMaxFadeTimer;
                    creditsSwitchState = FADING_OUT_CREDITS;
                }
            }
            
            /*
            if(FlxG.mouse.justPressed()) {
                FlxG.mouse.hide();
                FlxG.state = new StartState();
            }*/
            
            super.update();
        }

        private function getNextText():void {
            currentCreditIndex += 1;
            if(currentCreditIndex >= allCredits.length-1) {
                creditsSwitchState = DO_NOTHING_CREDITS;
                FlxG.fade.start(0xff000000, 2.0, function():void {
                        FlxG.fade.stop();
                        FlxG.state = new StartState();
                    });
            } else {
                creditsText.text = allCredits[currentCreditIndex];
            }
        }

    }
}