#!/usr/bin/python

import os
import commands
from xml.dom import minidom

#--------------------------------------
BASE_PATH = os.path.join(os.path.dirname(__file__), 'asset_library')
ASSET_BASE = '/../data/'
ASSET_XML_FILE = os.path.join(BASE_PATH, '../data/assets.xml')
#--------------------------------------


def main():
    build_assets()
    build_swf()

def build_assets():
    """
    Build the 'AssetLibrary' class file.
    """

    # templates
    template = open(os.path.join(BASE_PATH, 'AssetLibrary.as.template'), 'r').read()

    embed_templates = {
        'image': "[Embed(source='%(asset_path)s')] private var %(asset_class_name)s:Class;\n",
        'xml': "[Embed(source='%(asset_path)s', mimeType=\"application/octet-stream\")] private var %(asset_class_name)s:Class;\n"
    }
    
    library_element_template = "'%(asset_id)s': %(asset_class_name)s"

    # load+parse asset xml
    complete_asset_embed_code = ""
    complete_asset_data_code = ""
    asset_dom = minidom.parse(ASSET_XML_FILE)
    
    asset_nodes = list(asset_dom.getElementsByTagName('asset'))
    
    for asset_node in asset_nodes:
        asset_attrs = dict(asset_node.attributes.items())
        asset_embed_code = embed_templates[asset_attrs['type']] % {
            'asset_class_name': asset_attrs['name'],
            'asset_path': ASSET_BASE + asset_attrs['file']
        }

        complete_asset_embed_code += asset_embed_code
        
        asset_data_code = library_element_template % {
            'asset_id': asset_attrs['name'],
            'asset_class_name': asset_attrs['name']
        }

        complete_asset_data_code += asset_data_code

        if asset_nodes.index(asset_node) == len(asset_nodes) - 1:
            complete_asset_data_code += "\n"
        else:
            complete_asset_data_code += ",\n"

    # load+parse map files from the 'world' object in the game xml
    
            
    output = template % {
        'asset_embeds': complete_asset_embed_code,
        'asset_data': complete_asset_data_code
    }
        
    # render
    output_f = open(os.path.join(BASE_PATH, 'AssetLibrary.as'), 'w')
    output_f.write(output)

def build_swf():
    if os.name == 'posix':
        build_command = "mxmlc src/california/Main.as -source-path=src/ -source-path=asset_library/ -output output/AHouseInCalifornia.swf -static-link-runtime-shared-libraries -default-size 640 340 && flashplayer_10 output/AHouseInCalifornia.swf"
    elif os.name == 'nt':
        build_command = 'mxmlc.exe src/california/Main.as -source-path=src/ -output output/AHouseInCalifornia.swf -static-link-runtime-shared-libraries -default-size 640 440 && /c/flex4/runtimes/player/10/win/FlashPlayer.exe output/AHouseInCalifornia.swf'
    else:
        print "no build command found for OS ", os.name
        return
        
    print commands.getoutput(build_command)
    
if __name__ == '__main__':
    main()
