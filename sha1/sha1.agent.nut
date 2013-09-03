function swap32(val) {
    return ((val & 0xFF) << 24) |
           ((val & 0xFF00) << 8) |
           ((val >>> 8) & 0xFF00) |
           ((val >>> 24) & 0xFF);
}

function _left_rotate(n, b){
    return ((n << b)&0xffffffff | (n >>> (32 - b))&0xffffffff)&0xffffffff
}
    
function sha1(message) {

    // Initialize variables:
    local h0 = 0x67452301;
    local h1 = 0xEFCDAB89;
    local h2 = 0x98BADCFE;
    local h3 = 0x10325476;
    local h4 = 0xC3D2E1F0;
    local mb = blob();
    
    // Pre-processing:
    local original_byte_len = message.len();
    local original_bit_len = original_byte_len * 8;
    
    foreach (val in message) {
        mb.writen(val, 'b');
    }

    // append the bit '1' to the message
    mb.writen('\x80', 'b')
    
    // append 0 <= k < 512 bits '0', so that the resulting message length (in bits)
    //    is congruent to 448 (mod 512)
    
    local l = ((56 - (original_byte_len + 1) % 64) % 64);
    while (l--) {
  		mb.writen('\x00', 'b')
	}
	
    // append length of message (before pre-processing), in bits, as 64-bit big-endian integer
    //FIX message += struct.pack('>Q', original_bit_len);
    //print("len=" + original_bit_len + ", swap=" + swap32(original_bit_len) + "" );
    mb.writen('\x00', 'i')
    mb.writen(swap32(original_bit_len), 'i')

    // Process the message in successive 512-bit chunks:
    // break message into 512-bit chunks
    //print("break message into 512-bit chunks");
    for (local i=0;i<mb.len();i+=64) {
        local w=[]; w.resize(80);

        // break chunk into sixteen 32-bit big-endian words w[i]
        for(local j=0;j<16;j+=1) {
            local s = i + j*4;
            mb.seek(s, 'b');
            w[j] = swap32(mb.readn('i'));
        }

        // Extend the sixteen 32-bit words into eighty 32-bit words:
        //print("Extend the sixteen 32-bit words into eighty 32-bit words:");
        for(local j=16;j<80;j+=1) {
            w[j] = _left_rotate(w[j-3] ^ w[j-8] ^ w[j-14] ^ w[j-16], 1);
        }
    
        // Initialize hash value for this chunk:

        local a = h0;
        local b = h1;
        local c = h2;
        local d = h3;
        local e = h4;
        
        for(local i=0;i<80;i+=1) {
            local f=0;
            local k=0;
            if (i>=0 && i<=19) {
                # Use alternative 1 for f from FIPS PB 180-1 to avoid ~
                f = d ^ (b & (c ^ d));
                k = 0x5A827999;
            }
            else if (i>=20 && i<= 39) {
                f = b ^ c ^ d;
                k = 0x6ED9EBA1;
            }
            else if (i>=40 && i<= 59) {
                f = (b & c) | (b & d) | (c & d) ;
                k = 0x8F1BBCDC;
            }
            else if (i>=60 && i<= 79) {
                f = b ^ c ^ d;
                k = 0xCA62C1D6;
            }
            
			local _a=a
			local _b=b
			local _c=c
			local _d=d
			local _e=e
			local _f=f
			
			a = (_left_rotate(_a, 5) + _f + _e + k + w[i]) & 0xffffffff;
			b = _a;
			c = _left_rotate(_b, 30);
			d = _c;
            e = _d;
        }
    
        // Add this chunk's hash to result so far:
        h0 = (h0 + a) & 0xffffffff
        h1 = (h1 + b) & 0xffffffff 
        h2 = (h2 + c) & 0xffffffff
        h3 = (h3 + d) & 0xffffffff
        h4 = (h4 + e) & 0xffffffff
    }
    
    // Produce the final hash value (big-endian):
    return format("%08x %08x %08x %08x %08x", h0, h1, h2, h3, h4);
} 

function TestSha1() {
    server.log("-----")
    server.log("s "+sha1("this is a really long string that is longer than 64 characters (1 block): 0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789")+"");
    server.log("= 097199af 74d81a94 89696f7a 7adcb4d7 31d0892c")
    server.log("-----")
    server.log("s "+sha1("The quick brown fox jumps over the lazy dog")+"");
    server.log("= 2fd4e1c6 7a2d28fc ed849ee1 bb76e739 1b93eb12");
    server.log("-----")
    server.log("s "+sha1("The quick brown fox jumps over the lazy cog")+"");
    server.log("= de9f2c7f d25e1b3a fad3e85a 0bd17d9b 100db4b3");
    server.log("-----")
    server.log("s "+sha1("")+"");
    server.log("= da39a3ee 5e6b4b0d 3255bfef 95601890 afd80709");
    server.log("-----")
} TestSha1();