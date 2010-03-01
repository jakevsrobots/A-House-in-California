"""
Compile levels from tiled's TMX format into a JSON document
with the level's tiles already processed into a comma-separated
list for flixel.
"""

from xml.dom import minidom
import simplejson
import os

SRC_DIR = os.path.join(os.path.abspath(os.path.dirname(__file__)), '../data/')

def tmx_to_json(source_path, output_path):
    dom = minidom.parse(source_path)

    # this loads in the base map element properties: width, height, tilesize
    map_data = dict(dom.getElementsByTagName('map')[0].attributes.items())

    for map_prop in dom.getElementsByTagName('property'):
        map_prop_dict = dict(map_prop.attributes.items())
        map_data[map_prop_dict['name']] = map_prop_dict['value']

    map_data['layers'] = []
        
    for layer in dom.getElementsByTagName('layer'):
        layer_dict = dict(layer.attributes.items())
        
        width = int(layer_dict['width'])
        
        layer_dict['tiles'] = ""
        
        for i, tile in enumerate(layer.getElementsByTagName('tile')):
            gid = int(tile.getAttribute('gid'))

            # adjust for tiled's gid system
            if gid > 0:
                gid -= 1

            layer_dict['tiles'] += str(gid)

            if i > 0 and i % width == width - 1:
                layer_dict['tiles'] += "\n"
            else:
                layer_dict['tiles'] += ","
        map_data['layers'].append(layer_dict)

    if os.path.exists(output_path):
        os.remove(output_path)
        
    f = open(output_path,'w')
    f.write(simplejson.dumps(map_data))
    f.close()
    print "wrote", output_path
                
def main():
    for filename in os.listdir(SRC_DIR):
        if not filename.endswith('tmx'):
            continue
        source_path = os.path.abspath(os.path.join(SRC_DIR,filename))
        
        output_filename = filename.replace('tmx','json')
        output_path = os.path.abspath(os.path.join(SRC_DIR,output_filename))

        # check if an output file already exists and is newer than
        # the source file, in which case no need to recompile
        if os.path.exists(output_path):
            if os.path.getmtime(output_path) > os.path.getmtime(source_path):
                print "--%s up to date" % output_filename
                continue
        
        tmx_to_json(source_path, output_path)

if __name__ == '__main__':
    main()
