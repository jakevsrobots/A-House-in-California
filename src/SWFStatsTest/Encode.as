package SWFStats
{
	import flash.display.BitmapData;
	import flash.utils.ByteArray;	

	public class Encode
	{
		// ----------------------------------------------------------------------------
		// Base64 encoding
		// ----------------------------------------------------------------------------
		// http://dynamicflash.com/goodies/base64/
		//
		// Copyright (c) 2006 Steve Webster
		// Permission is hereby granted, free of charge, to any person obtaining a copy of
		// this software and associated documentation files (the "Software"), to deal in
		// the Software without restriction, including without limitation the rights to
		// use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
		// the Software, and to permit persons to whom the Software is furnished to do so,
		// subject to the following conditions: 
		// The above copyright notice and this permission notice shall be included in all
		// copies or substantial portions of the Software.
		private static const BASE64_CHARS:String = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";

		public static function Base64(data:ByteArray):String 
		{
			var output:String = "";
			var dataBuffer:Array;
			var outputBuffer:Array = new Array(4);
			var i:uint;
			var j:uint;
			var k:uint;
			
			data.position = 0;
			
			while (data.bytesAvailable > 0) 
			{
				dataBuffer = new Array();
				
				for(i=0; i<3 && data.bytesAvailable>0; i++) 
					dataBuffer[i] = data.readUnsignedByte();
				
				outputBuffer[0] = (dataBuffer[0] & 0xfc) >> 2;
				outputBuffer[1] = ((dataBuffer[0] & 0x03) << 4) | ((dataBuffer[1]) >> 4);
				outputBuffer[2] = ((dataBuffer[1] & 0x0f) << 2) | ((dataBuffer[2]) >> 6);
				outputBuffer[3] = dataBuffer[2] & 0x3f;
				
				for(j=dataBuffer.length; j<3; j++)
					outputBuffer[j + 1] = 64;
				
				for (k = 0; k<outputBuffer.length; k++)
					output += BASE64_CHARS.charAt(outputBuffer[k]);
			}
			
			return output;
		}

		
		// ----------------------------------------------------------------------------
		// PNG encoding
		// ----------------------------------------------------------------------------
		// http://code.google.com/p/as3corelib/source/browse/trunk/src/com/adobe/images/PNGEncoder.as
		//
 		// Copyright (c) 2008, Adobe Systems Incorporated
  		// All rights reserved.		
	   public static function PNG(img:BitmapData):ByteArray 
	   {
			// Create output byte array
			var png:ByteArray = new ByteArray();
			png.writeUnsignedInt(0x89504e47);
			png.writeUnsignedInt(0x0D0A1A0A);

			var IHDR:ByteArray = new ByteArray();
			IHDR.writeInt(img.width);
			IHDR.writeInt(img.height);
			IHDR.writeUnsignedInt(0x08060000); // 32bit RGBA
			IHDR.writeByte(0);
			writeChunk(png,0x49484452,IHDR);

			var IDAT:ByteArray= new ByteArray();
			var p:uint;
			var j:int;
			
			for(var i:int=0;i < img.height;i++) 
			{
				// no filter
				IDAT.writeByte(0);

				if (!img.transparent)
				{
					for(j=0;j < img.width;j++) 
					{
						p = img.getPixel(j,i);
						IDAT.writeUnsignedInt(uint(((p&0xFFFFFF) << 8) | 0xFF));
					}
				} 
				else 
				{
					for(j=0;j < img.width;j++) 
					{
						p = img.getPixel32(j,i);
						IDAT.writeUnsignedInt(uint(((p&0xFFFFFF) << 8) |	(p>>>24)));
					}
				}
			}
			
			IDAT.compress();
			writeChunk(png,0x49444154,IDAT);
			writeChunk(png,0x49454E44, null);
			return png;
		}
	
		private static var crcTable:Array;
		private static var crcTableComputed:Boolean = false;
	
		private static function writeChunk(png:ByteArray, type:uint, data:ByteArray):void 
		{
			if(!crcTableComputed) 
			{
				crcTableComputed = true;
				crcTable = [];
				var c:uint;
				
				for(var n:uint = 0; n < 256; n++) 
				{
					c = n;
					
					for(var k:uint = 0; k < 8; k++) 
					{
						if (c & 1) 
						{
							c = uint(uint(0xedb88320) ^ uint(c >>> 1));
						} 
						else 
						{
							c = uint(c >>> 1);
						}
					}

					crcTable[n] = c;
				}
			}
			
			var len:uint = 0;

			if(data != null) 
			{
				len = data.length;
			}

			png.writeUnsignedInt(len);
			
			var p:uint = png.position;
			png.writeUnsignedInt(type);
			
			if(data != null) 
			{
				png.writeBytes(data);
			}
			
			var e:uint = png.position;
			png.position = p;
			c = 0xffffffff;
			
			for(var i:int=0; i<(e-p); i++) 
			{
				c = uint(crcTable[(c ^ png.readUnsignedByte()) & uint(0xff)] ^ uint(c >>> 8));
			}
			
			c = uint(c^uint(0xffffffff));
			png.position = e;
			png.writeUnsignedInt(c);
		}

		// ------------------------------------------------------------------------------
		// MD5 stuff
		// ------------------------------------------------------------------------------
		// A JavaScript implementation of the RSA Data Security, Inc. MD5 Message
		// Digest Algorithm, as defined in RFC 1321.
		// Copyright (C) Paul Johnston 1999 - 2000.
		// Updated by Greg Holt 2000 - 2001.
		// See http://pajhome.org.uk/site/legal.html for details.
		// Updated by Ger Hobbelt 2001 (Flash 5) - works for totally buggered MAC Flash player and, of course, Windows / Linux as well.
		// Updated by Ger Hobbelt 2008 (Flash 9 / AS3) - quick fix.
		private static var hex_chr:String = "0123456789abcdef";

		private static function bitOR(a:Number, b:Number):Number
		{
			var lsb:Number = (a & 0x1) | (b & 0x1);
			var msb31:Number = (a >>> 1) | (b >>> 1);

			return (msb31 << 1) | lsb;
		}

		private static function bitXOR(a:Number, b:Number):Number
		{			
			var lsb:Number = (a & 0x1) ^ (b & 0x1);
			var msb31:Number = (a >>> 1) ^ (b >>> 1);

			return (msb31 << 1) | lsb;
		}

		private static function bitAND(a:Number, b:Number):Number
		{ 
			var lsb:Number = (a & 0x1) & (b & 0x1);
			var msb31:Number = (a >>> 1) & (b >>> 1);

			return (msb31 << 1) | lsb;
		}

		private static function addme(x:Number, y:Number):Number
		{
			var lsw:Number = (x & 0xFFFF)+(y & 0xFFFF);
			var msw:Number = (x >> 16)+(y >> 16)+(lsw >> 16);

			return (msw << 16) | (lsw & 0xFFFF);
		}

		private static function rhex(num:Number):String
		{
			var str:String = "";
			var j:int;

			for(j=0; j<=3; j++)
				str += hex_chr.charAt((num >> (j * 8 + 4)) & 0x0F) + hex_chr.charAt((num >> (j * 8)) & 0x0F);

			return str;
		}

		private static function str2blks_MD5(str:String):Array
		{
			var nblk:Number = ((str.length + 8) >> 6) + 1;
			var blks:Array = new Array(nblk * 16);
			var i:int;

			for(i=0; i<nblk * 16; i++) 
				blks[i] = 0;
																
			for(i=0; i<str.length; i++)
				blks[i >> 2] |= str.charCodeAt(i) << (((str.length * 8 + i) % 4) * 8);

			blks[i >> 2] |= 0x80 << (((str.length * 8 + i) % 4) * 8);

			var l:int = str.length * 8;
			blks[nblk * 16 - 2] = (l & 0xFF);
			blks[nblk * 16 - 2] |= ((l >>> 8) & 0xFF) << 8;
			blks[nblk * 16 - 2] |= ((l >>> 16) & 0xFF) << 16;
			blks[nblk * 16 - 2] |= ((l >>> 24) & 0xFF) << 24;

			return blks;
		}

		private static function rol(num:Number, cnt:Number):Number
		{
			return (num << cnt) | (num >>> (32 - cnt));
		}

		private static function cmn(q:Number, a:Number, b:Number, x:Number, s:Number, t:Number):Number
		{
			return addme(rol((addme(addme(a, q), addme(x, t))), s), b);
		}

		private static function ff(a:Number, b:Number, c:Number, d:Number, x:Number, s:Number, t:Number):Number
		{
			return cmn(bitOR(bitAND(b, c), bitAND((~b), d)), a, b, x, s, t);
		}

		private static function gg(a:Number, b:Number, c:Number, d:Number, x:Number, s:Number, t:Number):Number
		{
			return cmn(bitOR(bitAND(b, d), bitAND(c, (~d))), a, b, x, s, t);
		}

		private static function hh(a:Number, b:Number, c:Number, d:Number, x:Number, s:Number, t:Number):Number
		{
			return cmn(bitXOR(bitXOR(b, c), d), a, b, x, s, t);
		}

		private static function ii(a:Number, b:Number, c:Number, d:Number, x:Number, s:Number, t:Number):Number
		{
			return cmn(bitXOR(c, bitOR(b, (~d))), a, b, x, s, t);
		}

		public static function MD5(str:String):String
		{
			var x:Array = str2blks_MD5(str);
			var a:Number =  1732584193;
			var b:Number = -271733879;
			var c:Number = -1732584194;
			var d:Number =  271733878;
			var i:int;

			for(i=0; i<x.length; i += 16)
			{
				var olda:Number = a;
				var oldb:Number = b;
				var oldc:Number = c;
				var oldd:Number = d;

				a = ff(a, b, c, d, x[i+ 0], 7 , -680876936);
				d = ff(d, a, b, c, x[i+ 1], 12, -389564586);
				c = ff(c, d, a, b, x[i+ 2], 17,  606105819);
				b = ff(b, c, d, a, x[i+ 3], 22, -1044525330);
				a = ff(a, b, c, d, x[i+ 4], 7 , -176418897);
				d = ff(d, a, b, c, x[i+ 5], 12,  1200080426);
				c = ff(c, d, a, b, x[i+ 6], 17, -1473231341);
				b = ff(b, c, d, a, x[i+ 7], 22, -45705983);
				a = ff(a, b, c, d, x[i+ 8], 7 ,  1770035416);
				d = ff(d, a, b, c, x[i+ 9], 12, -1958414417);
				c = ff(c, d, a, b, x[i+10], 17, -42063);
				b = ff(b, c, d, a, x[i+11], 22, -1990404162);
				a = ff(a, b, c, d, x[i+12], 7 ,  1804603682);
				d = ff(d, a, b, c, x[i+13], 12, -40341101);
				c = ff(c, d, a, b, x[i+14], 17, -1502002290);
				b = ff(b, c, d, a, x[i+15], 22,  1236535329);    
				a = gg(a, b, c, d, x[i+ 1], 5 , -165796510);
				d = gg(d, a, b, c, x[i+ 6], 9 , -1069501632);
				c = gg(c, d, a, b, x[i+11], 14,  643717713);
				b = gg(b, c, d, a, x[i+ 0], 20, -373897302);
				a = gg(a, b, c, d, x[i+ 5], 5 , -701558691);
				d = gg(d, a, b, c, x[i+10], 9 ,  38016083);
				c = gg(c, d, a, b, x[i+15], 14, -660478335);
				b = gg(b, c, d, a, x[i+ 4], 20, -405537848);
				a = gg(a, b, c, d, x[i+ 9], 5 ,  568446438);
				d = gg(d, a, b, c, x[i+14], 9 , -1019803690);
				c = gg(c, d, a, b, x[i+ 3], 14, -187363961);
				b = gg(b, c, d, a, x[i+ 8], 20,  1163531501);
				a = gg(a, b, c, d, x[i+13], 5 , -1444681467);
				d = gg(d, a, b, c, x[i+ 2], 9 , -51403784);
				c = gg(c, d, a, b, x[i+ 7], 14,  1735328473);
				b = gg(b, c, d, a, x[i+12], 20, -1926607734);
				a = hh(a, b, c, d, x[i+ 5], 4 , -378558);
				d = hh(d, a, b, c, x[i+ 8], 11, -2022574463);
				c = hh(c, d, a, b, x[i+11], 16,  1839030562);
				b = hh(b, c, d, a, x[i+14], 23, -35309556);
				a = hh(a, b, c, d, x[i+ 1], 4 , -1530992060);
				d = hh(d, a, b, c, x[i+ 4], 11,  1272893353);
				c = hh(c, d, a, b, x[i+ 7], 16, -155497632);
				b = hh(b, c, d, a, x[i+10], 23, -1094730640);
				a = hh(a, b, c, d, x[i+13], 4 ,  681279174);
				d = hh(d, a, b, c, x[i+ 0], 11, -358537222);
				c = hh(c, d, a, b, x[i+ 3], 16, -722521979);
				b = hh(b, c, d, a, x[i+ 6], 23,  76029189);
				a = hh(a, b, c, d, x[i+ 9], 4 , -640364487);
				d = hh(d, a, b, c, x[i+12], 11, -421815835);
				c = hh(c, d, a, b, x[i+15], 16,  530742520);
				b = hh(b, c, d, a, x[i+ 2], 23, -995338651);
				a = ii(a, b, c, d, x[i+ 0], 6 , -198630844);
				d = ii(d, a, b, c, x[i+ 7], 10,  1126891415);
				c = ii(c, d, a, b, x[i+14], 15, -1416354905);
				b = ii(b, c, d, a, x[i+ 5], 21, -57434055);
				a = ii(a, b, c, d, x[i+12], 6 ,  1700485571);
				d = ii(d, a, b, c, x[i+ 3], 10, -1894986606);
				c = ii(c, d, a, b, x[i+10], 15, -1051523);
				b = ii(b, c, d, a, x[i+ 1], 21, -2054922799);
				a = ii(a, b, c, d, x[i+ 8], 6 ,  1873313359);
				d = ii(d, a, b, c, x[i+15], 10, -30611744);
				c = ii(c, d, a, b, x[i+ 6], 15, -1560198380);
				b = ii(b, c, d, a, x[i+13], 21,  1309151649);
				a = ii(a, b, c, d, x[i+ 4], 6 , -145523070);
				d = ii(d, a, b, c, x[i+11], 10, -1120210379);
				c = ii(c, d, a, b, x[i+ 2], 15,  718787259);
				b = ii(b, c, d, a, x[i+ 9], 21, -343485551);

				a = addme(a, olda);
				b = addme(b, oldb);
				c = addme(c, oldc);
				d = addme(d, oldd);
			}

			return rhex(a) + rhex(b) + rhex(c) + rhex(d);
		}
	}	
}