#!/usr/bin/python

import os
from xml.dom import minidom

#--------------------------------------
BASE_PATH = os.path.join(os.path.dirname(__file__), 'asset_library')

OGMO_ASSET_BASE = '../'
ASSET_BASE = '/../data/'

OGMO_PROJECT_FILE = os.path.join(BASE_PATH, '../data/maps/AHouseInCalifornia.oep')
#--------------------------------------


def main():
    build_assets()
    #build_swf()

def build_assets():
    """
    Build the 'AssetLibrary' class file.
    """

    # templates
    template = open(os.path.join(BASE_PATH, 'AssetLibrary.as.template'), 'r').read()

    embed_template = """
        [Embed(source='%(asset_path)s')]
        private var %(asset_class_name)s:Class;
    """

    library_element_template = "'%(asset_id)s': %(asset_class_name)s"

    # load+parse ogmo's XML
    asset_embed_code = ""
    asset_data_code = ""
    ogmo_dom = minidom.parse(OGMO_PROJECT_FILE)
    
    object_nodes = list(ogmo_dom.getElementsByTagName('object'))
    
    for object_node in object_nodes:
        obj_attrs = dict(object_node.attributes.items())
        obj_embed_code = embed_template % {
            'asset_class_name': obj_attrs['name'],
            'asset_path': obj_attrs['image'].replace(OGMO_ASSET_BASE, ASSET_BASE)
        }
        
        obj_data_code = library_element_template % {
            'asset_id': obj_attrs['name'],
            'asset_class_name': obj_attrs['name']
        }

        asset_data_code += obj_data_code        

        if object_nodes.index(object_node) == len(object_nodes) - 1:
            asset_data_code += "\n"
        else:
            asset_data_code += ",\n"

    output = template % {
        'asset_embeds': asset_embed_code,
        'asset_data': asset_data_code
    }
        
    # render
    output_f = open(os.path.join(BASE_PATH, 'AssetLibrary.as'), 'w')
    output_f.write(output)
    
if __name__ == '__main__':
    main()
