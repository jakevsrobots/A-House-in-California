package california {
    import org.flixel.*;
    
    public class Vocabulary {
        [Embed(source='/../data/verbs.xml', mimeType="application/octet-stream")]
        private var VerbListXMLData:Class;

        private var verbData:Object;
        public var currentVerbs:FlxGroup;
        
        public function Vocabulary(maxCurrentVerbs:uint = 5):void {
            var verbListXML:XML = new XML(new VerbListXMLData());

            verbData = {};
            currentVerbs = new FlxGroup();
            
            for each (var verbNode:XML in verbListXML.verb) {
                var verbObject:Verb = new Verb(verbNode.name);
                
                // ex. "Sing to Bird" or by default just "Sing Bird"
                if(verbNode.defaultTemplate) {
                    verbObject.template = verbNode.defaultTemplate;
                } else {
                    verbObject.template = verbNode.name;
                }

                if(verbNode.persist) {
                    verbObject.persist = true;
                } else {
                    verbObject.persist = false;
                }

                verbData[verbNode.name] = verbObject;

                if(currentVerbs.members.length < maxCurrentVerbs) {
                    currentVerbs.add(verbObject);
                }
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
            
            var oldVerbPosition:uint = currentVerbs.members.indexOf(oldVerb);

            if(oldVerbPosition != -1) {
                currentVerbs.members[oldVerbPosition] = newVerb;
            }
        }

        public function getVerb(verbName:String):Verb {
            return verbData[verbName];
        }
    }
}