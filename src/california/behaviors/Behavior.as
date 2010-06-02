package california.behaviors {
    import org.flixel.FlxG;
    
    public class Behavior {
        // Find the appropriate Behavior subclass and instantiate it
        // properly.
        public static function getBehaviorFromXML(behaviorNode:XML):Behavior {
            FlxG.log('trying to get behavior from xml, type=|' + behaviorNode.@type + '|');
            switch (behaviorNode.@type.toString()) {
                case "dialog":
                return new DialogBehavior(behaviorNode.toString());
                break;
                
                case "transitionToRoom":
                return new TransitionToRoomBehavior(behaviorNode.toString());
                break;
            }

            return null;
        }

        public function run():void {
            // all subclasses should override this
        }
    }
}