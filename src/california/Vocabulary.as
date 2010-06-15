package california {
    import org.flixel.*;
    
    public class Vocabulary {
        public var verbData:Object;
        public var currentVerbs:FlxGroup;

        public function Vocabulary(maxCurrentVerbs:uint = 5):void {
            var verbListXML:XML = Main.gameXML.verbs[0];

            verbData = {};
            currentVerbs = new FlxGroup();
            
            for each (var verbNode:XML in verbListXML.verb) {
                var verbObject:Verb = new Verb(verbNode.name);

                // ex. "Sing to Bird" or by default just "Sing Bird"
                if(verbNode.template.toString() != '') {
                    verbObject.template = verbNode.template;
                } else {
                    verbObject.template = verbNode.name;
                }

                verbData[verbNode.name] = verbObject;

                if(currentVerbs.members.length < maxCurrentVerbs) {
                    currentVerbs.add(verbObject);
                }
            }

            sortVerbs();
        }

        public function setCurrentVerbsByName(verbList:Array):void {
            // Set the list of current verbs from an array of verb names
            currentVerbs.members.length = 0;

            for each (var verbName:String in verbList) {
                currentVerbs.add(verbData[verbName]);
            }

            sortVerbs();
        }
        
        public function sortVerbs():void {
            // Re-flow verb layout
            var xSum:uint = 4;
            var yOffset:uint = FlxG.height - 16;
            
            for(var i:uint = 0; i < currentVerbs.members.length; i++) {
                var verb:Verb = currentVerbs.members[i];
                verb.y = yOffset;
                verb.x = xSum;

                FlxG.log(verb.name + ',' + verb.x + ',' + verb.y);
                
                // Add this verb's width to x_sum
                xSum += verb.width;
                
                // Add some padding between verbs
                xSum += 2;
            }
        }

        public function replaceVerb(oldVerbName:String, newVerbName:String):void {
            var oldVerb:Verb = verbData[oldVerbName];
            var newVerb:Verb = verbData[newVerbName];

            if(oldVerb != null && newVerb != null) {
                currentVerbs.replace(oldVerb, newVerb);
            }

            sortVerbs();
        }

        public function addVerbByName(verbName:String):void {
            var newVerb:Verb = verbData[verbName];
            if(!newVerb) {
                FlxG.log('could not find verb ' + verbName);
                FlxG.log(verbData);
                return;
            }

            // Don't add a verb redundantly
            if(currentVerbs.members.indexOf(newVerb) != -1) {
                return;
            }
            
            currentVerbs.add(newVerb);
            sortVerbs();
        }

        public function removeVerbByName(verbName:String):void {
            var targetVerb:Verb = verbData[verbName];

            if(!targetVerb) {
                return;
            }

            currentVerbs.remove(targetVerb, true);
            sortVerbs();
        }
        
        public function getVerb(verbName:String):Verb {
            return verbData[verbName];
        }
    }
}