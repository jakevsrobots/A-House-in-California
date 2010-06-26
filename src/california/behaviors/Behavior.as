package california.behaviors {
    import org.flixel.FlxG;
    
    public class Behavior {
        public var conditional:Boolean = false;
        public var flagName:String;
        public var flagValue:Boolean;

        public static var behaviorClasses:Object;
        
        public static function stringToNumber(value:String):Number {
            if(value == '') {
                return NaN;
            } else {
                return Number(value);
            }
        }

        public static function getBehaviorClass(name:String):Class {
            if(!Behavior.behaviorClasses.hasOwnProperty(name)) {
                throw new Error("No behavior registered with the name " + name);
            }

            return Behavior.behaviorClasses[name];
        }

        public static function registerBehaviorClasses(behaviorClasses:Object):void {
            if(Behavior.behaviorClasses == null) {
                Behavior.behaviorClasses = {};
            }

            for(var className:Object in behaviorClasses) {
                Behavior.behaviorClasses[className] = behaviorClasses[className];
            }
        }
        
        public static function getBehaviorFromXML(behaviorNode:XML):Behavior {
            var behaviorClass:Class = Behavior.getBehaviorClass(behaviorNode.@type.toString());
            var behavior:Behavior = new behaviorClass(behaviorNode);

            if(behaviorNode.parent().name() == 'conditionalBehaviors') {
                behavior.conditional = true;
                behavior.flagName = behaviorNode.parent().@flagName;
                behavior.flagValue = behaviorNode.parent().@value == "1" ? true : false;
            }
            
            return behavior;
        }
        public function run():void {
            // all subclasses should override this
        }
    }
}