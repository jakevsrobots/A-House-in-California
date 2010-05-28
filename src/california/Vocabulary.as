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
        }

        public function replaceVerb(oldVerbName:String, newVerbName:String):void {
            var oldVerb:Verb = verbData[oldVerbName];
            var newVerb:Verb = verbData[newVerbName];
            
            var oldVerbPosition:uint = currentVerbs.members.indexOf(oldVerb);

            if(oldVerbPosition != -1) {
                currentVerbs[oldVerbPosition] = newVerb;
            }
        }
    }
}