/**
 * @Author: Jian-Hong
 * 
 */

if(typeof(security) === "undefined"){var security = function(){}};
if(typeof(security.utils) === "undefined"){security.utils = {}};
$.extend(security.utils, {
	sha256: function (ascii) {
		function rightRotate(value, amount) {
			return (value>>>amount) | (value<<(32 - amount));
		};
		
		var mathPow = Math.pow;
		var maxWord = mathPow(2, 32);
		var lengthProperty = 'length'
		var i, j; // Used as a counter across the whole file
		var result = ''

		var words = [];
		var asciiBitLength = ascii[lengthProperty]*8;
		
		//* caching results is optional - remove/add slash from front of this line to toggle
		// Initial hash value: first 32 bits of the fractional parts of the square roots of the first 8 primes
		// (we actually calculate the first 64, but extra values are just ignored)
		var hash = security.utils.sha256.h = security.utils.sha256.h || [];
		// Round constants: first 32 bits of the fractional parts of the cube roots of the first 64 primes
		var k = security.utils.sha256.k = security.utils.sha256.k || [];
		var primeCounter = k[lengthProperty];
		/*/
		var hash = [], k = [];
		var primeCounter = 0;
		//*/

		var isComposite = {};
		for (var candidate = 2; primeCounter < 64; candidate++) {
			if (!isComposite[candidate]) {
				for (i = 0; i < 313; i += candidate) {
					isComposite[i] = candidate;
				}
				hash[primeCounter] = (mathPow(candidate, .5)*maxWord)|0;
				k[primeCounter++] = (mathPow(candidate, 1/3)*maxWord)|0;
			}
		}
		
		ascii += '\x80' // Append Ƈ' bit (plus zero padding)
		while (ascii[lengthProperty]%64 - 56) ascii += '\x00' // More zero padding
		for (i = 0; i < ascii[lengthProperty]; i++) {
			j = ascii.charCodeAt(i);
			if (j>>8) return; // ASCII check: only accept characters in range 0-255
			words[i>>2] |= j << ((3 - i)%4)*8;
		}
		words[words[lengthProperty]] = ((asciiBitLength/maxWord)|0);
		words[words[lengthProperty]] = (asciiBitLength)
		
		// process each chunk
		for (j = 0; j < words[lengthProperty];) {
			var w = words.slice(j, j += 16); // The message is expanded into 64 words as part of the iteration
			var oldHash = hash;
			// This is now the undefinedworking hash", often labelled as variables a...g
			// (we have to truncate as well, otherwise extra entries at the end accumulate
			hash = hash.slice(0, 8);
			
			for (i = 0; i < 64; i++) {
				var i2 = i + j;
				// Expand the message into 64 words
				// Used below if 
				var w15 = w[i - 15], w2 = w[i - 2];

				// Iterate
				var a = hash[0], e = hash[4];
				var temp1 = hash[7]
					+ (rightRotate(e, 6) ^ rightRotate(e, 11) ^ rightRotate(e, 25)) // S1
					+ ((e&hash[5])^((~e)&hash[6])) // ch
					+ k[i]
					// Expand the message schedule if needed
					+ (w[i] = (i < 16) ? w[i] : (
							w[i - 16]
							+ (rightRotate(w15, 7) ^ rightRotate(w15, 18) ^ (w15>>>3)) // s0
							+ w[i - 7]
							+ (rightRotate(w2, 17) ^ rightRotate(w2, 19) ^ (w2>>>10)) // s1
						)|0
					);
				// This is only used once, so *could* be moved below, but it only saves 4 bytes and makes things unreadble
				var temp2 = (rightRotate(a, 2) ^ rightRotate(a, 13) ^ rightRotate(a, 22)) // S0
					+ ((a&hash[1])^(a&hash[2])^(hash[1]&hash[2])); // maj
				
				hash = [(temp1 + temp2)|0].concat(hash); // We don't bother trimming off the extra ones, they're harmless as long as we're truncating when we do the slice()
				hash[4] = (hash[4] + temp1)|0;
			}
			
			for (i = 0; i < 8; i++) {
				hash[i] = (hash[i] + oldHash[i])|0;
			}
		}
		
		for (i = 0; i < 8; i++) {
			for (j = 3; j + 1; j--) {
				var b = (hash[i]>>(j*8))&255;
				result += ((b < 16) ? 0 : '') + b.toString(16);
			}
		}
		return result;
	},
	

	MD5: function (string) {
	    function RotateLeft(lValue, iShiftBits) {
	        return (lValue<<iShiftBits) | (lValue>>>(32-iShiftBits));
	    }

	    function AddUnsigned(lX,lY) {

	        var lX4,lY4,lX8,lY8,lResult;
	        lX8 = (lX & 0x80000000);
	        lY8 = (lY & 0x80000000);
	        lX4 = (lX & 0x40000000);
	        lY4 = (lY & 0x40000000);
	        lResult = (lX & 0x3FFFFFFF)+(lY & 0x3FFFFFFF);

	        if (lX4 & lY4) {
	            return (lResult ^ 0x80000000 ^ lX8 ^ lY8);
	        }

	        if (lX4 | lY4) {
	            if (lResult & 0x40000000) {
	                return (lResult ^ 0xC0000000 ^ lX8 ^ lY8);
	            } else {
	                return (lResult ^ 0x40000000 ^ lX8 ^ lY8);
	            }
	        } else {
	            return (lResult ^ lX8 ^ lY8);
	        }
	     }

	    function F(x,y,z) { return (x & y) | ((~x) & z); }

	    function G(x,y,z) { return (x & z) | (y & (~z)); }

        function H(x,y,z) { return (x ^ y ^ z); }

	    function I(x,y,z) { return (y ^ (x | (~z))); }

	    function FF(a,b,c,d,x,s,ac) {
	        a = AddUnsigned(a, AddUnsigned(AddUnsigned(F(b, c, d), x), ac));
	        return AddUnsigned(RotateLeft(a, s), b);
	    };

	    function GG(a,b,c,d,x,s,ac) {
	        a = AddUnsigned(a, AddUnsigned(AddUnsigned(G(b, c, d), x), ac));
	        return AddUnsigned(RotateLeft(a, s), b);
	    };

	    function HH(a,b,c,d,x,s,ac) {
	        a = AddUnsigned(a, AddUnsigned(AddUnsigned(H(b, c, d), x), ac));
	        return AddUnsigned(RotateLeft(a, s), b);
	    };

	    function II(a,b,c,d,x,s,ac) {
	        a = AddUnsigned(a, AddUnsigned(AddUnsigned(I(b, c, d), x), ac));
	        return AddUnsigned(RotateLeft(a, s), b);
	    };

	    function ConvertToWordArray(string) {
	        var lWordCount;
	        var lMessageLength = string.length;
	        var lNumberOfWords_temp1=lMessageLength + 8;
	        var lNumberOfWords_temp2=(lNumberOfWords_temp1-(lNumberOfWords_temp1 % 64))/64;
	        var lNumberOfWords = (lNumberOfWords_temp2+1)*16;
	        var lWordArray=Array(lNumberOfWords-1);
	        var lBytePosition = 0;
	        var lByteCount = 0;

	        while ( lByteCount < lMessageLength ) {
	            lWordCount = (lByteCount-(lByteCount % 4))/4;
	            lBytePosition = (lByteCount % 4)*8;
	            lWordArray[lWordCount] = (lWordArray[lWordCount] | (string.charCodeAt(lByteCount)<<lBytePosition));
	            lByteCount++;
	        }
	        
	        lWordCount = (lByteCount-(lByteCount % 4))/4;
	        lBytePosition = (lByteCount % 4)*8;
	        lWordArray[lWordCount] = lWordArray[lWordCount] | (0x80<<lBytePosition);
	        lWordArray[lNumberOfWords-2] = lMessageLength<<3;
	        lWordArray[lNumberOfWords-1] = lMessageLength>>>29;
	        return lWordArray;
	    };

	    function WordToHex(lValue) {
	        var WordToHexValue="",WordToHexValue_temp="",lByte,lCount;
	        for (lCount = 0;lCount<=3;lCount++) {
	            lByte = (lValue>>>(lCount*8)) & 255;
	            WordToHexValue_temp = "0" + lByte.toString(16);
	            WordToHexValue = WordToHexValue + WordToHexValue_temp.substr(WordToHexValue_temp.length-2,2);
	        }
	        return WordToHexValue;
	    };

	    function Utf8Encode(string) {
	        string = string.replace(/\r\n/g,"\n");
	        var utftext = "";

	        for (var n = 0; n < string.length; n++) {
	            var c = string.charCodeAt(n);

	            if (c < 128) {
	                utftext += String.fromCharCode(c);
	            }

	            else if((c > 127) && (c < 2048)) {
	                utftext += String.fromCharCode((c >> 6) | 192);
	                utftext += String.fromCharCode((c & 63) | 128);
	            }
	            else {
	                utftext += String.fromCharCode((c >> 12) | 224);
	                utftext += String.fromCharCode(((c >> 6) & 63) | 128);
	                utftext += String.fromCharCode((c & 63) | 128);
	            }
	        }
	        return utftext;
	    };

	    var x=Array();
	    var k,AA,BB,CC,DD,a,b,c,d;
	    var S11=7, S12=12, S13=17, S14=22;
	    var S21=5, S22=9 , S23=14, S24=20;
	    var S31=4, S32=11, S33=16, S34=23;
	    var S41=6, S42=10, S43=15, S44=21;

	    string = Utf8Encode(string);
	    x = ConvertToWordArray(string);
	    a = 0x67452301; b = 0xEFCDAB89; c = 0x98BADCFE; d = 0x10325476;

	    for (k=0;k<x.length;k+=16) {
	        AA=a; BB=b; CC=c; DD=d;
	        a=FF(a,b,c,d,x[k+0], S11,0xD76AA478);
	        d=FF(d,a,b,c,x[k+1], S12,0xE8C7B756);
	        c=FF(c,d,a,b,x[k+2], S13,0x242070DB);
	        b=FF(b,c,d,a,x[k+3], S14,0xC1BDCEEE);
	        a=FF(a,b,c,d,x[k+4], S11,0xF57C0FAF);
	        d=FF(d,a,b,c,x[k+5], S12,0x4787C62A);
	        c=FF(c,d,a,b,x[k+6], S13,0xA8304613);
	        b=FF(b,c,d,a,x[k+7], S14,0xFD469501);
	        a=FF(a,b,c,d,x[k+8], S11,0x698098D8);
	        d=FF(d,a,b,c,x[k+9], S12,0x8B44F7AF);
	        c=FF(c,d,a,b,x[k+10],S13,0xFFFF5BB1);
	        b=FF(b,c,d,a,x[k+11],S14,0x895CD7BE);
	        a=FF(a,b,c,d,x[k+12],S11,0x6B901122);
	        d=FF(d,a,b,c,x[k+13],S12,0xFD987193);
	        c=FF(c,d,a,b,x[k+14],S13,0xA679438E);
	        b=FF(b,c,d,a,x[k+15],S14,0x49B40821);
	        a=GG(a,b,c,d,x[k+1], S21,0xF61E2562);
	        d=GG(d,a,b,c,x[k+6], S22,0xC040B340);
	        c=GG(c,d,a,b,x[k+11],S23,0x265E5A51);
	        b=GG(b,c,d,a,x[k+0], S24,0xE9B6C7AA);
	        a=GG(a,b,c,d,x[k+5], S21,0xD62F105D);
	        d=GG(d,a,b,c,x[k+10],S22,0x2441453);
	        c=GG(c,d,a,b,x[k+15],S23,0xD8A1E681);
	        b=GG(b,c,d,a,x[k+4], S24,0xE7D3FBC8);
	        a=GG(a,b,c,d,x[k+9], S21,0x21E1CDE6);
	        d=GG(d,a,b,c,x[k+14],S22,0xC33707D6);
	        c=GG(c,d,a,b,x[k+3], S23,0xF4D50D87);
	        b=GG(b,c,d,a,x[k+8], S24,0x455A14ED);
	        a=GG(a,b,c,d,x[k+13],S21,0xA9E3E905);
	        d=GG(d,a,b,c,x[k+2], S22,0xFCEFA3F8);
	        c=GG(c,d,a,b,x[k+7], S23,0x676F02D9);
	        b=GG(b,c,d,a,x[k+12],S24,0x8D2A4C8A);
	        a=HH(a,b,c,d,x[k+5], S31,0xFFFA3942);
	        d=HH(d,a,b,c,x[k+8], S32,0x8771F681);
	        c=HH(c,d,a,b,x[k+11],S33,0x6D9D6122);
	        b=HH(b,c,d,a,x[k+14],S34,0xFDE5380C);
	        a=HH(a,b,c,d,x[k+1], S31,0xA4BEEA44);
	        d=HH(d,a,b,c,x[k+4], S32,0x4BDECFA9);
	        c=HH(c,d,a,b,x[k+7], S33,0xF6BB4B60);
	        b=HH(b,c,d,a,x[k+10],S34,0xBEBFBC70);
	        a=HH(a,b,c,d,x[k+13],S31,0x289B7EC6);
	        d=HH(d,a,b,c,x[k+0], S32,0xEAA127FA);
	        c=HH(c,d,a,b,x[k+3], S33,0xD4EF3085);
	        b=HH(b,c,d,a,x[k+6], S34,0x4881D05);
	        a=HH(a,b,c,d,x[k+9], S31,0xD9D4D039);
	        d=HH(d,a,b,c,x[k+12],S32,0xE6DB99E5);
	        c=HH(c,d,a,b,x[k+15],S33,0x1FA27CF8);
	        b=HH(b,c,d,a,x[k+2], S34,0xC4AC5665);
	        a=II(a,b,c,d,x[k+0], S41,0xF4292244);
	        d=II(d,a,b,c,x[k+7], S42,0x432AFF97);
	        c=II(c,d,a,b,x[k+14],S43,0xAB9423A7);
	        b=II(b,c,d,a,x[k+5], S44,0xFC93A039);
	        a=II(a,b,c,d,x[k+12],S41,0x655B59C3);
	        d=II(d,a,b,c,x[k+3], S42,0x8F0CCC92);
	        c=II(c,d,a,b,x[k+10],S43,0xFFEFF47D);
	        b=II(b,c,d,a,x[k+1], S44,0x85845DD1);
	        a=II(a,b,c,d,x[k+8], S41,0x6FA87E4F);
	        d=II(d,a,b,c,x[k+15],S42,0xFE2CE6E0);
	        c=II(c,d,a,b,x[k+6], S43,0xA3014314);
	        b=II(b,c,d,a,x[k+13],S44,0x4E0811A1);
	        a=II(a,b,c,d,x[k+4], S41,0xF7537E82);
	        d=II(d,a,b,c,x[k+11],S42,0xBD3AF235);
	        c=II(c,d,a,b,x[k+2], S43,0x2AD7D2BB);
	        b=II(b,c,d,a,x[k+9], S44,0xEB86D391);
	        a=AddUnsigned(a,AA);
	        b=AddUnsigned(b,BB);
	        c=AddUnsigned(c,CC);
	        d=AddUnsigned(d,DD);
	    }
	    var temp = WordToHex(a)+WordToHex(b)+WordToHex(c)+WordToHex(d);
	    return temp.toLowerCase();
	},
	
	encryptByDES: function(message, key) {
        var keyHex = CryptoJS.enc.Utf8.parse(key);
        var encrypted = CryptoJS.DES.encrypt(message, keyHex, {
            mode: CryptoJS.mode.ECB,
            padding: CryptoJS.pad.Pkcs7
        });
        return encrypted.toString();
    },
    
    decryptByDES: function(ciphertext, key) {
        var keyHex = CryptoJS.enc.Utf8.parse(key);
        // direct decrypt ciphertext
        var decrypted = CryptoJS.DES.decrypt({
            ciphertext: CryptoJS.enc.Base64.parse(ciphertext)
        }, keyHex, {
            mode: CryptoJS.mode.ECB,
            padding: CryptoJS.pad.Pkcs7
        });
        return decrypted.toString(CryptoJS.enc.Utf8);
    }
});