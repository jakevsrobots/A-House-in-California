package california.behaviors {
    import org.flixel.FlxG;
    
    public class Behavior {
        // Find the appropriate Behavior subclass and instantiate it
        // properly.
        public static function getBehaviorFromXML(behaviorNode:XML):Behavior {
            var behavior:Behavior = null;
            
            switch (behaviorNode.@type.toString()) {
                case "dialog":
                behavior = new DialogBehavior(behaviorNode.toString());
                break;
                
                case "transitionToRoom":
                behavior = new TransitionToRoomBehavior(behaviorNode.@targetRoom.toString());
                break;
                
                case "replaceSprite":
                behavior = new ReplaceSpriteBehavior(behaviorNode.@oldSprite, behaviorNode.@newSprite);
                break;
            }
            
            return behavior;
        }

        public function run():void {
            // all subclasses should override this
        }
    }
}