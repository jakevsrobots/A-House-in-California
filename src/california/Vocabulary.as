package california {
    public class Vocabulary {
        [Embed(source='/../data/verbs.xml', mimeType="application/octet-stream")]
        private var VerbListXMLData:Class;

        private var verbData:Object;
        public var currentVerbs:Array;
        
        public function Vocabulary(maxCurrentVerbs:uint = 5):void {
            var verbListXML:XML = new XML(new VerbListXMLData());

            verbData = {};
            currentVerbs = [];
            
            for each (var verbNode:XML in verbListXML.verb) {
                var verbObject:Object = {};

                verbObject['name'] = verbNode.name;
                
                // ex. "Sing to Bird" or by default just "Sing Bird"
                if(verbNode.defaultTemplate) {
                    verbObject.template = verbNode.name;
                } else {
                    verbObject.template = verbNode.name;
                }

                if(verbNode.persist) {
                    verbObject.persist = true;
                } else {
                    verbObject.persist = false;
                }

                verbData[verbNode.name] = verbObject;

                if(currentVerbs.length < maxCurrentVerbs) {
                    currentVerbs.push(verbObject);
                }
            }
        }

        public function replaceVerb(oldVerbName:String, newVerbName:String):void {
            var oldVerb:Object = verbData[oldVerbName];
            var newVerb:Object = verbData[newVerbName];
            
            var oldVerbPosition:uint = currentVerbs.IndexOf(oldVerb);

            if(oldVerbPosition != -1) {
                currentVerbs[oldVerbPosition] = newVerb;
            }
        }
    }
}