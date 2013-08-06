server.log(imp.getsoftwareversion());
imp.enableblinkup(false);

imp.configure("NeoPixel",[],[]);

class neoPixels {
    spi = null;
    frameSize = null;
    bits = [
      "\xF0\x00\x1E\x00\x03\xC0\x00\x78\x00\x0F\x00\x01\xE0\x00\x3C\x00\x07\x80\x00",
      "\xF0\x00\x1E\x00\x03\xC0\x00\x78\x00\x0F\x00\x01\xE0\x00\x3C\x00\x07\xFC\x00",
      "\xF0\x00\x1E\x00\x03\xC0\x00\x78\x00\x0F\x00\x01\xE0\x00\x3F\xE0\x07\x80\x00",
      "\xF0\x00\x1E\x00\x03\xC0\x00\x78\x00\x0F\x00\x01\xE0\x00\x3F\xE0\x07\xFC\x00",
    	"\xF0\x00\x1E\x00\x03\xC0\x00\x78\x00\x0F\x00\x01\xFF\x00\x3C\x00\x07\x80\x00",
    	"\xF0\x00\x1E\x00\x03\xC0\x00\x78\x00\x0F\x00\x01\xFF\x00\x3C\x00\x07\xFC\x00",
    	"\xF0\x00\x1E\x00\x03\xC0\x00\x78\x00\x0F\x00\x01\xFF\x00\x3F\xE0\x07\x80\x00",
    	"\xF0\x00\x1E\x00\x03\xC0\x00\x78\x00\x0F\x00\x01\xFF\x00\x3F\xE0\x07\xFC\x00",
    	"\xF0\x00\x1E\x00\x03\xC0\x00\x78\x00\x0F\xF8\x01\xE0\x00\x3C\x00\x07\x80\x00",
    	"\xF0\x00\x1E\x00\x03\xC0\x00\x78\x00\x0F\xF8\x01\xE0\x00\x3C\x00\x07\xFC\x00",
    	"\xF0\x00\x1E\x00\x03\xC0\x00\x78\x00\x0F\xF8\x01\xE0\x00\x3F\xE0\x07\x80\x00",
    	"\xF0\x00\x1E\x00\x03\xC0\x00\x78\x00\x0F\xF8\x01\xE0\x00\x3F\xE0\x07\xFC\x00",
    	"\xF0\x00\x1E\x00\x03\xC0\x00\x78\x00\x0F\xF8\x01\xFF\x00\x3C\x00\x07\x80\x00",
    	"\xF0\x00\x1E\x00\x03\xC0\x00\x78\x00\x0F\xF8\x01\xFF\x00\x3C\x00\x07\xFC\x00",
    	"\xF0\x00\x1E\x00\x03\xC0\x00\x78\x00\x0F\xF8\x01\xFF\x00\x3F\xE0\x07\x80\x00",
    	"\xF0\x00\x1E\x00\x03\xC0\x00\x78\x00\x0F\xF8\x01\xFF\x00\x3F\xE0\x07\xFC\x00",
    	"\xF0\x00\x1E\x00\x03\xC0\x00\x7F\xC0\x0F\x00\x01\xE0\x00\x3C\x00\x07\x80\x00",
    	"\xF0\x00\x1E\x00\x03\xC0\x00\x7F\xC0\x0F\x00\x01\xE0\x00\x3C\x00\x07\xFC\x00",
    	"\xF0\x00\x1E\x00\x03\xC0\x00\x7F\xC0\x0F\x00\x01\xE0\x00\x3F\xE0\x07\x80\x00",
    	"\xF0\x00\x1E\x00\x03\xC0\x00\x7F\xC0\x0F\x00\x01\xE0\x00\x3F\xE0\x07\xFC\x00",
    	"\xF0\x00\x1E\x00\x03\xC0\x00\x7F\xC0\x0F\x00\x01\xFF\x00\x3C\x00\x07\x80\x00",
    	"\xF0\x00\x1E\x00\x03\xC0\x00\x7F\xC0\x0F\x00\x01\xFF\x00\x3C\x00\x07\xFC\x00",
    	"\xF0\x00\x1E\x00\x03\xC0\x00\x7F\xC0\x0F\x00\x01\xFF\x00\x3F\xE0\x07\x80\x00",
    	"\xF0\x00\x1E\x00\x03\xC0\x00\x7F\xC0\x0F\x00\x01\xFF\x00\x3F\xE0\x07\xFC\x00",
    	"\xF0\x00\x1E\x00\x03\xC0\x00\x7F\xC0\x0F\xF8\x01\xE0\x00\x3C\x00\x07\x80\x00",
    	"\xF0\x00\x1E\x00\x03\xC0\x00\x7F\xC0\x0F\xF8\x01\xE0\x00\x3C\x00\x07\xFC\x00",
    	"\xF0\x00\x1E\x00\x03\xC0\x00\x7F\xC0\x0F\xF8\x01\xE0\x00\x3F\xE0\x07\x80\x00",
    	"\xF0\x00\x1E\x00\x03\xC0\x00\x7F\xC0\x0F\xF8\x01\xE0\x00\x3F\xE0\x07\xFC\x00",
    	"\xF0\x00\x1E\x00\x03\xC0\x00\x7F\xC0\x0F\xF8\x01\xFF\x00\x3C\x00\x07\x80\x00",
    	"\xF0\x00\x1E\x00\x03\xC0\x00\x7F\xC0\x0F\xF8\x01\xFF\x00\x3C\x00\x07\xFC\x00",
    	"\xF0\x00\x1E\x00\x03\xC0\x00\x7F\xC0\x0F\xF8\x01\xFF\x00\x3F\xE0\x07\x80\x00",
    	"\xF0\x00\x1E\x00\x03\xC0\x00\x7F\xC0\x0F\xF8\x01\xFF\x00\x3F\xE0\x07\xFC\x00",
    	"\xF0\x00\x1E\x00\x03\xFE\x00\x78\x00\x0F\x00\x01\xE0\x00\x3C\x00\x07\x80\x00",
    	"\xF0\x00\x1E\x00\x03\xFE\x00\x78\x00\x0F\x00\x01\xE0\x00\x3C\x00\x07\xFC\x00",
    	"\xF0\x00\x1E\x00\x03\xFE\x00\x78\x00\x0F\x00\x01\xE0\x00\x3F\xE0\x07\x80\x00",
    	"\xF0\x00\x1E\x00\x03\xFE\x00\x78\x00\x0F\x00\x01\xE0\x00\x3F\xE0\x07\xFC\x00",
    	"\xF0\x00\x1E\x00\x03\xFE\x00\x78\x00\x0F\x00\x01\xFF\x00\x3C\x00\x07\x80\x00",
    	"\xF0\x00\x1E\x00\x03\xFE\x00\x78\x00\x0F\x00\x01\xFF\x00\x3C\x00\x07\xFC\x00",
    	"\xF0\x00\x1E\x00\x03\xFE\x00\x78\x00\x0F\x00\x01\xFF\x00\x3F\xE0\x07\x80\x00",
    	"\xF0\x00\x1E\x00\x03\xFE\x00\x78\x00\x0F\x00\x01\xFF\x00\x3F\xE0\x07\xFC\x00",
    	"\xF0\x00\x1E\x00\x03\xFE\x00\x78\x00\x0F\xF8\x01\xE0\x00\x3C\x00\x07\x80\x00",
    	"\xF0\x00\x1E\x00\x03\xFE\x00\x78\x00\x0F\xF8\x01\xE0\x00\x3C\x00\x07\xFC\x00",
    	"\xF0\x00\x1E\x00\x03\xFE\x00\x78\x00\x0F\xF8\x01\xE0\x00\x3F\xE0\x07\x80\x00",
    	"\xF0\x00\x1E\x00\x03\xFE\x00\x78\x00\x0F\xF8\x01\xE0\x00\x3F\xE0\x07\xFC\x00",
    	"\xF0\x00\x1E\x00\x03\xFE\x00\x78\x00\x0F\xF8\x01\xFF\x00\x3C\x00\x07\x80\x00",
    	"\xF0\x00\x1E\x00\x03\xFE\x00\x78\x00\x0F\xF8\x01\xFF\x00\x3C\x00\x07\xFC\x00",
    	"\xF0\x00\x1E\x00\x03\xFE\x00\x78\x00\x0F\xF8\x01\xFF\x00\x3F\xE0\x07\x80\x00",
    	"\xF0\x00\x1E\x00\x03\xFE\x00\x78\x00\x0F\xF8\x01\xFF\x00\x3F\xE0\x07\xFC\x00",
    	"\xF0\x00\x1E\x00\x03\xFE\x00\x7F\xC0\x0F\x00\x01\xE0\x00\x3C\x00\x07\x80\x00",
    	"\xF0\x00\x1E\x00\x03\xFE\x00\x7F\xC0\x0F\x00\x01\xE0\x00\x3C\x00\x07\xFC\x00",
    	"\xF0\x00\x1E\x00\x03\xFE\x00\x7F\xC0\x0F\x00\x01\xE0\x00\x3F\xE0\x07\x80\x00",
    	"\xF0\x00\x1E\x00\x03\xFE\x00\x7F\xC0\x0F\x00\x01\xE0\x00\x3F\xE0\x07\xFC\x00",
    	"\xF0\x00\x1E\x00\x03\xFE\x00\x7F\xC0\x0F\x00\x01\xFF\x00\x3C\x00\x07\x80\x00",
    	"\xF0\x00\x1E\x00\x03\xFE\x00\x7F\xC0\x0F\x00\x01\xFF\x00\x3C\x00\x07\xFC\x00",
    	"\xF0\x00\x1E\x00\x03\xFE\x00\x7F\xC0\x0F\x00\x01\xFF\x00\x3F\xE0\x07\x80\x00",
    	"\xF0\x00\x1E\x00\x03\xFE\x00\x7F\xC0\x0F\x00\x01\xFF\x00\x3F\xE0\x07\xFC\x00",
    	"\xF0\x00\x1E\x00\x03\xFE\x00\x7F\xC0\x0F\xF8\x01\xE0\x00\x3C\x00\x07\x80\x00",
    	"\xF0\x00\x1E\x00\x03\xFE\x00\x7F\xC0\x0F\xF8\x01\xE0\x00\x3C\x00\x07\xFC\x00",
    	"\xF0\x00\x1E\x00\x03\xFE\x00\x7F\xC0\x0F\xF8\x01\xE0\x00\x3F\xE0\x07\x80\x00",
    	"\xF0\x00\x1E\x00\x03\xFE\x00\x7F\xC0\x0F\xF8\x01\xE0\x00\x3F\xE0\x07\xFC\x00",
    	"\xF0\x00\x1E\x00\x03\xFE\x00\x7F\xC0\x0F\xF8\x01\xFF\x00\x3C\x00\x07\x80\x00",
    	"\xF0\x00\x1E\x00\x03\xFE\x00\x7F\xC0\x0F\xF8\x01\xFF\x00\x3C\x00\x07\xFC\x00",
    	"\xF0\x00\x1E\x00\x03\xFE\x00\x7F\xC0\x0F\xF8\x01\xFF\x00\x3F\xE0\x07\x80\x00",
    	"\xF0\x00\x1E\x00\x03\xFE\x00\x7F\xC0\x0F\xF8\x01\xFF\x00\x3F\xE0\x07\xFC\x00",
    	"\xF0\x00\x1F\xF0\x03\xC0\x00\x78\x00\x0F\x00\x01\xE0\x00\x3C\x00\x07\x80\x00",
    	"\xF0\x00\x1F\xF0\x03\xC0\x00\x78\x00\x0F\x00\x01\xE0\x00\x3C\x00\x07\xFC\x00",
    	"\xF0\x00\x1F\xF0\x03\xC0\x00\x78\x00\x0F\x00\x01\xE0\x00\x3F\xE0\x07\x80\x00",
    	"\xF0\x00\x1F\xF0\x03\xC0\x00\x78\x00\x0F\x00\x01\xE0\x00\x3F\xE0\x07\xFC\x00",
    	"\xF0\x00\x1F\xF0\x03\xC0\x00\x78\x00\x0F\x00\x01\xFF\x00\x3C\x00\x07\x80\x00",
    	"\xF0\x00\x1F\xF0\x03\xC0\x00\x78\x00\x0F\x00\x01\xFF\x00\x3C\x00\x07\xFC\x00",
    	"\xF0\x00\x1F\xF0\x03\xC0\x00\x78\x00\x0F\x00\x01\xFF\x00\x3F\xE0\x07\x80\x00",
    	"\xF0\x00\x1F\xF0\x03\xC0\x00\x78\x00\x0F\x00\x01\xFF\x00\x3F\xE0\x07\xFC\x00",
    	"\xF0\x00\x1F\xF0\x03\xC0\x00\x78\x00\x0F\xF8\x01\xE0\x00\x3C\x00\x07\x80\x00",
    	"\xF0\x00\x1F\xF0\x03\xC0\x00\x78\x00\x0F\xF8\x01\xE0\x00\x3C\x00\x07\xFC\x00",
    	"\xF0\x00\x1F\xF0\x03\xC0\x00\x78\x00\x0F\xF8\x01\xE0\x00\x3F\xE0\x07\x80\x00",
    	"\xF0\x00\x1F\xF0\x03\xC0\x00\x78\x00\x0F\xF8\x01\xE0\x00\x3F\xE0\x07\xFC\x00",
    	"\xF0\x00\x1F\xF0\x03\xC0\x00\x78\x00\x0F\xF8\x01\xFF\x00\x3C\x00\x07\x80\x00",
    	"\xF0\x00\x1F\xF0\x03\xC0\x00\x78\x00\x0F\xF8\x01\xFF\x00\x3C\x00\x07\xFC\x00",
    	"\xF0\x00\x1F\xF0\x03\xC0\x00\x78\x00\x0F\xF8\x01\xFF\x00\x3F\xE0\x07\x80\x00",
    	"\xF0\x00\x1F\xF0\x03\xC0\x00\x78\x00\x0F\xF8\x01\xFF\x00\x3F\xE0\x07\xFC\x00",
    	"\xF0\x00\x1F\xF0\x03\xC0\x00\x7F\xC0\x0F\x00\x01\xE0\x00\x3C\x00\x07\x80\x00",
    	"\xF0\x00\x1F\xF0\x03\xC0\x00\x7F\xC0\x0F\x00\x01\xE0\x00\x3C\x00\x07\xFC\x00",
    	"\xF0\x00\x1F\xF0\x03\xC0\x00\x7F\xC0\x0F\x00\x01\xE0\x00\x3F\xE0\x07\x80\x00",
    	"\xF0\x00\x1F\xF0\x03\xC0\x00\x7F\xC0\x0F\x00\x01\xE0\x00\x3F\xE0\x07\xFC\x00",
    	"\xF0\x00\x1F\xF0\x03\xC0\x00\x7F\xC0\x0F\x00\x01\xFF\x00\x3C\x00\x07\x80\x00",
    	"\xF0\x00\x1F\xF0\x03\xC0\x00\x7F\xC0\x0F\x00\x01\xFF\x00\x3C\x00\x07\xFC\x00",
    	"\xF0\x00\x1F\xF0\x03\xC0\x00\x7F\xC0\x0F\x00\x01\xFF\x00\x3F\xE0\x07\x80\x00",
    	"\xF0\x00\x1F\xF0\x03\xC0\x00\x7F\xC0\x0F\x00\x01\xFF\x00\x3F\xE0\x07\xFC\x00",
    	"\xF0\x00\x1F\xF0\x03\xC0\x00\x7F\xC0\x0F\xF8\x01\xE0\x00\x3C\x00\x07\x80\x00",
    	"\xF0\x00\x1F\xF0\x03\xC0\x00\x7F\xC0\x0F\xF8\x01\xE0\x00\x3C\x00\x07\xFC\x00",
    	"\xF0\x00\x1F\xF0\x03\xC0\x00\x7F\xC0\x0F\xF8\x01\xE0\x00\x3F\xE0\x07\x80\x00",
    	"\xF0\x00\x1F\xF0\x03\xC0\x00\x7F\xC0\x0F\xF8\x01\xE0\x00\x3F\xE0\x07\xFC\x00",
    	"\xF0\x00\x1F\xF0\x03\xC0\x00\x7F\xC0\x0F\xF8\x01\xFF\x00\x3C\x00\x07\x80\x00",
    	"\xF0\x00\x1F\xF0\x03\xC0\x00\x7F\xC0\x0F\xF8\x01\xFF\x00\x3C\x00\x07\xFC\x00",
    	"\xF0\x00\x1F\xF0\x03\xC0\x00\x7F\xC0\x0F\xF8\x01\xFF\x00\x3F\xE0\x07\x80\x00",
    	"\xF0\x00\x1F\xF0\x03\xC0\x00\x7F\xC0\x0F\xF8\x01\xFF\x00\x3F\xE0\x07\xFC\x00",
    	"\xF0\x00\x1F\xF0\x03\xFE\x00\x78\x00\x0F\x00\x01\xE0\x00\x3C\x00\x07\x80\x00",
    	"\xF0\x00\x1F\xF0\x03\xFE\x00\x78\x00\x0F\x00\x01\xE0\x00\x3C\x00\x07\xFC\x00",
    	"\xF0\x00\x1F\xF0\x03\xFE\x00\x78\x00\x0F\x00\x01\xE0\x00\x3F\xE0\x07\x80\x00",
    	"\xF0\x00\x1F\xF0\x03\xFE\x00\x78\x00\x0F\x00\x01\xE0\x00\x3F\xE0\x07\xFC\x00",
    	"\xF0\x00\x1F\xF0\x03\xFE\x00\x78\x00\x0F\x00\x01\xFF\x00\x3C\x00\x07\x80\x00",
    	"\xF0\x00\x1F\xF0\x03\xFE\x00\x78\x00\x0F\x00\x01\xFF\x00\x3C\x00\x07\xFC\x00",
    	"\xF0\x00\x1F\xF0\x03\xFE\x00\x78\x00\x0F\x00\x01\xFF\x00\x3F\xE0\x07\x80\x00",
    	"\xF0\x00\x1F\xF0\x03\xFE\x00\x78\x00\x0F\x00\x01\xFF\x00\x3F\xE0\x07\xFC\x00",
    	"\xF0\x00\x1F\xF0\x03\xFE\x00\x78\x00\x0F\xF8\x01\xE0\x00\x3C\x00\x07\x80\x00",
    	"\xF0\x00\x1F\xF0\x03\xFE\x00\x78\x00\x0F\xF8\x01\xE0\x00\x3C\x00\x07\xFC\x00",
    	"\xF0\x00\x1F\xF0\x03\xFE\x00\x78\x00\x0F\xF8\x01\xE0\x00\x3F\xE0\x07\x80\x00",
    	"\xF0\x00\x1F\xF0\x03\xFE\x00\x78\x00\x0F\xF8\x01\xE0\x00\x3F\xE0\x07\xFC\x00",
    	"\xF0\x00\x1F\xF0\x03\xFE\x00\x78\x00\x0F\xF8\x01\xFF\x00\x3C\x00\x07\x80\x00",
    	"\xF0\x00\x1F\xF0\x03\xFE\x00\x78\x00\x0F\xF8\x01\xFF\x00\x3C\x00\x07\xFC\x00",
    	"\xF0\x00\x1F\xF0\x03\xFE\x00\x78\x00\x0F\xF8\x01\xFF\x00\x3F\xE0\x07\x80\x00",
    	"\xF0\x00\x1F\xF0\x03\xFE\x00\x78\x00\x0F\xF8\x01\xFF\x00\x3F\xE0\x07\xFC\x00",
    	"\xF0\x00\x1F\xF0\x03\xFE\x00\x7F\xC0\x0F\x00\x01\xE0\x00\x3C\x00\x07\x80\x00",
    	"\xF0\x00\x1F\xF0\x03\xFE\x00\x7F\xC0\x0F\x00\x01\xE0\x00\x3C\x00\x07\xFC\x00",
    	"\xF0\x00\x1F\xF0\x03\xFE\x00\x7F\xC0\x0F\x00\x01\xE0\x00\x3F\xE0\x07\x80\x00",
    	"\xF0\x00\x1F\xF0\x03\xFE\x00\x7F\xC0\x0F\x00\x01\xE0\x00\x3F\xE0\x07\xFC\x00",
    	"\xF0\x00\x1F\xF0\x03\xFE\x00\x7F\xC0\x0F\x00\x01\xFF\x00\x3C\x00\x07\x80\x00",
    	"\xF0\x00\x1F\xF0\x03\xFE\x00\x7F\xC0\x0F\x00\x01\xFF\x00\x3C\x00\x07\xFC\x00",
    	"\xF0\x00\x1F\xF0\x03\xFE\x00\x7F\xC0\x0F\x00\x01\xFF\x00\x3F\xE0\x07\x80\x00",
    	"\xF0\x00\x1F\xF0\x03\xFE\x00\x7F\xC0\x0F\x00\x01\xFF\x00\x3F\xE0\x07\xFC\x00",
    	"\xF0\x00\x1F\xF0\x03\xFE\x00\x7F\xC0\x0F\xF8\x01\xE0\x00\x3C\x00\x07\x80\x00",
    	"\xF0\x00\x1F\xF0\x03\xFE\x00\x7F\xC0\x0F\xF8\x01\xE0\x00\x3C\x00\x07\xFC\x00",
    	"\xF0\x00\x1F\xF0\x03\xFE\x00\x7F\xC0\x0F\xF8\x01\xE0\x00\x3F\xE0\x07\x80\x00",
    	"\xF0\x00\x1F\xF0\x03\xFE\x00\x7F\xC0\x0F\xF8\x01\xE0\x00\x3F\xE0\x07\xFC\x00",
    	"\xF0\x00\x1F\xF0\x03\xFE\x00\x7F\xC0\x0F\xF8\x01\xFF\x00\x3C\x00\x07\x80\x00",
    	"\xF0\x00\x1F\xF0\x03\xFE\x00\x7F\xC0\x0F\xF8\x01\xFF\x00\x3C\x00\x07\xFC\x00",
    	"\xF0\x00\x1F\xF0\x03\xFE\x00\x7F\xC0\x0F\xF8\x01\xFF\x00\x3F\xE0\x07\x80\x00",
    	"\xF0\x00\x1F\xF0\x03\xFE\x00\x7F\xC0\x0F\xF8\x01\xFF\x00\x3F\xE0\x07\xFC\x00",
    	"\xFF\x80\x1E\x00\x03\xC0\x00\x78\x00\x0F\x00\x01\xE0\x00\x3C\x00\x07\x80\x00",
    	"\xFF\x80\x1E\x00\x03\xC0\x00\x78\x00\x0F\x00\x01\xE0\x00\x3C\x00\x07\xFC\x00",
    	"\xFF\x80\x1E\x00\x03\xC0\x00\x78\x00\x0F\x00\x01\xE0\x00\x3F\xE0\x07\x80\x00",
    	"\xFF\x80\x1E\x00\x03\xC0\x00\x78\x00\x0F\x00\x01\xE0\x00\x3F\xE0\x07\xFC\x00",
    	"\xFF\x80\x1E\x00\x03\xC0\x00\x78\x00\x0F\x00\x01\xFF\x00\x3C\x00\x07\x80\x00",
    	"\xFF\x80\x1E\x00\x03\xC0\x00\x78\x00\x0F\x00\x01\xFF\x00\x3C\x00\x07\xFC\x00",
    	"\xFF\x80\x1E\x00\x03\xC0\x00\x78\x00\x0F\x00\x01\xFF\x00\x3F\xE0\x07\x80\x00",
    	"\xFF\x80\x1E\x00\x03\xC0\x00\x78\x00\x0F\x00\x01\xFF\x00\x3F\xE0\x07\xFC\x00",
    	"\xFF\x80\x1E\x00\x03\xC0\x00\x78\x00\x0F\xF8\x01\xE0\x00\x3C\x00\x07\x80\x00",
    	"\xFF\x80\x1E\x00\x03\xC0\x00\x78\x00\x0F\xF8\x01\xE0\x00\x3C\x00\x07\xFC\x00",
    	"\xFF\x80\x1E\x00\x03\xC0\x00\x78\x00\x0F\xF8\x01\xE0\x00\x3F\xE0\x07\x80\x00",
    	"\xFF\x80\x1E\x00\x03\xC0\x00\x78\x00\x0F\xF8\x01\xE0\x00\x3F\xE0\x07\xFC\x00",
    	"\xFF\x80\x1E\x00\x03\xC0\x00\x78\x00\x0F\xF8\x01\xFF\x00\x3C\x00\x07\x80\x00",
    	"\xFF\x80\x1E\x00\x03\xC0\x00\x78\x00\x0F\xF8\x01\xFF\x00\x3C\x00\x07\xFC\x00",
    	"\xFF\x80\x1E\x00\x03\xC0\x00\x78\x00\x0F\xF8\x01\xFF\x00\x3F\xE0\x07\x80\x00",
    	"\xFF\x80\x1E\x00\x03\xC0\x00\x78\x00\x0F\xF8\x01\xFF\x00\x3F\xE0\x07\xFC\x00",
    	"\xFF\x80\x1E\x00\x03\xC0\x00\x7F\xC0\x0F\x00\x01\xE0\x00\x3C\x00\x07\x80\x00",
    	"\xFF\x80\x1E\x00\x03\xC0\x00\x7F\xC0\x0F\x00\x01\xE0\x00\x3C\x00\x07\xFC\x00",
    	"\xFF\x80\x1E\x00\x03\xC0\x00\x7F\xC0\x0F\x00\x01\xE0\x00\x3F\xE0\x07\x80\x00",
    	"\xFF\x80\x1E\x00\x03\xC0\x00\x7F\xC0\x0F\x00\x01\xE0\x00\x3F\xE0\x07\xFC\x00",
    	"\xFF\x80\x1E\x00\x03\xC0\x00\x7F\xC0\x0F\x00\x01\xFF\x00\x3C\x00\x07\x80\x00",
    	"\xFF\x80\x1E\x00\x03\xC0\x00\x7F\xC0\x0F\x00\x01\xFF\x00\x3C\x00\x07\xFC\x00",
    	"\xFF\x80\x1E\x00\x03\xC0\x00\x7F\xC0\x0F\x00\x01\xFF\x00\x3F\xE0\x07\x80\x00",
    	"\xFF\x80\x1E\x00\x03\xC0\x00\x7F\xC0\x0F\x00\x01\xFF\x00\x3F\xE0\x07\xFC\x00",
    	"\xFF\x80\x1E\x00\x03\xC0\x00\x7F\xC0\x0F\xF8\x01\xE0\x00\x3C\x00\x07\x80\x00",
    	"\xFF\x80\x1E\x00\x03\xC0\x00\x7F\xC0\x0F\xF8\x01\xE0\x00\x3C\x00\x07\xFC\x00",
    	"\xFF\x80\x1E\x00\x03\xC0\x00\x7F\xC0\x0F\xF8\x01\xE0\x00\x3F\xE0\x07\x80\x00",
    	"\xFF\x80\x1E\x00\x03\xC0\x00\x7F\xC0\x0F\xF8\x01\xE0\x00\x3F\xE0\x07\xFC\x00",
    	"\xFF\x80\x1E\x00\x03\xC0\x00\x7F\xC0\x0F\xF8\x01\xFF\x00\x3C\x00\x07\x80\x00",
    	"\xFF\x80\x1E\x00\x03\xC0\x00\x7F\xC0\x0F\xF8\x01\xFF\x00\x3C\x00\x07\xFC\x00",
    	"\xFF\x80\x1E\x00\x03\xC0\x00\x7F\xC0\x0F\xF8\x01\xFF\x00\x3F\xE0\x07\x80\x00",
    	"\xFF\x80\x1E\x00\x03\xC0\x00\x7F\xC0\x0F\xF8\x01\xFF\x00\x3F\xE0\x07\xFC\x00",
    	"\xFF\x80\x1E\x00\x03\xFE\x00\x78\x00\x0F\x00\x01\xE0\x00\x3C\x00\x07\x80\x00",
    	"\xFF\x80\x1E\x00\x03\xFE\x00\x78\x00\x0F\x00\x01\xE0\x00\x3C\x00\x07\xFC\x00",
    	"\xFF\x80\x1E\x00\x03\xFE\x00\x78\x00\x0F\x00\x01\xE0\x00\x3F\xE0\x07\x80\x00",
    	"\xFF\x80\x1E\x00\x03\xFE\x00\x78\x00\x0F\x00\x01\xE0\x00\x3F\xE0\x07\xFC\x00",
    	"\xFF\x80\x1E\x00\x03\xFE\x00\x78\x00\x0F\x00\x01\xFF\x00\x3C\x00\x07\x80\x00",
    	"\xFF\x80\x1E\x00\x03\xFE\x00\x78\x00\x0F\x00\x01\xFF\x00\x3C\x00\x07\xFC\x00",
    	"\xFF\x80\x1E\x00\x03\xFE\x00\x78\x00\x0F\x00\x01\xFF\x00\x3F\xE0\x07\x80\x00",
    	"\xFF\x80\x1E\x00\x03\xFE\x00\x78\x00\x0F\x00\x01\xFF\x00\x3F\xE0\x07\xFC\x00",
    	"\xFF\x80\x1E\x00\x03\xFE\x00\x78\x00\x0F\xF8\x01\xE0\x00\x3C\x00\x07\x80\x00",
    	"\xFF\x80\x1E\x00\x03\xFE\x00\x78\x00\x0F\xF8\x01\xE0\x00\x3C\x00\x07\xFC\x00",
    	"\xFF\x80\x1E\x00\x03\xFE\x00\x78\x00\x0F\xF8\x01\xE0\x00\x3F\xE0\x07\x80\x00",
    	"\xFF\x80\x1E\x00\x03\xFE\x00\x78\x00\x0F\xF8\x01\xE0\x00\x3F\xE0\x07\xFC\x00",
    	"\xFF\x80\x1E\x00\x03\xFE\x00\x78\x00\x0F\xF8\x01\xFF\x00\x3C\x00\x07\x80\x00",
    	"\xFF\x80\x1E\x00\x03\xFE\x00\x78\x00\x0F\xF8\x01\xFF\x00\x3C\x00\x07\xFC\x00",
    	"\xFF\x80\x1E\x00\x03\xFE\x00\x78\x00\x0F\xF8\x01\xFF\x00\x3F\xE0\x07\x80\x00",
    	"\xFF\x80\x1E\x00\x03\xFE\x00\x78\x00\x0F\xF8\x01\xFF\x00\x3F\xE0\x07\xFC\x00",
    	"\xFF\x80\x1E\x00\x03\xFE\x00\x7F\xC0\x0F\x00\x01\xE0\x00\x3C\x00\x07\x80\x00",
    	"\xFF\x80\x1E\x00\x03\xFE\x00\x7F\xC0\x0F\x00\x01\xE0\x00\x3C\x00\x07\xFC\x00",
    	"\xFF\x80\x1E\x00\x03\xFE\x00\x7F\xC0\x0F\x00\x01\xE0\x00\x3F\xE0\x07\x80\x00",
    	"\xFF\x80\x1E\x00\x03\xFE\x00\x7F\xC0\x0F\x00\x01\xE0\x00\x3F\xE0\x07\xFC\x00",
    	"\xFF\x80\x1E\x00\x03\xFE\x00\x7F\xC0\x0F\x00\x01\xFF\x00\x3C\x00\x07\x80\x00",
    	"\xFF\x80\x1E\x00\x03\xFE\x00\x7F\xC0\x0F\x00\x01\xFF\x00\x3C\x00\x07\xFC\x00",
    	"\xFF\x80\x1E\x00\x03\xFE\x00\x7F\xC0\x0F\x00\x01\xFF\x00\x3F\xE0\x07\x80\x00",
    	"\xFF\x80\x1E\x00\x03\xFE\x00\x7F\xC0\x0F\x00\x01\xFF\x00\x3F\xE0\x07\xFC\x00",
    	"\xFF\x80\x1E\x00\x03\xFE\x00\x7F\xC0\x0F\xF8\x01\xE0\x00\x3C\x00\x07\x80\x00",
    	"\xFF\x80\x1E\x00\x03\xFE\x00\x7F\xC0\x0F\xF8\x01\xE0\x00\x3C\x00\x07\xFC\x00",
    	"\xFF\x80\x1E\x00\x03\xFE\x00\x7F\xC0\x0F\xF8\x01\xE0\x00\x3F\xE0\x07\x80\x00",
    	"\xFF\x80\x1E\x00\x03\xFE\x00\x7F\xC0\x0F\xF8\x01\xE0\x00\x3F\xE0\x07\xFC\x00",
    	"\xFF\x80\x1E\x00\x03\xFE\x00\x7F\xC0\x0F\xF8\x01\xFF\x00\x3C\x00\x07\x80\x00",
    	"\xFF\x80\x1E\x00\x03\xFE\x00\x7F\xC0\x0F\xF8\x01\xFF\x00\x3C\x00\x07\xFC\x00",
    	"\xFF\x80\x1E\x00\x03\xFE\x00\x7F\xC0\x0F\xF8\x01\xFF\x00\x3F\xE0\x07\x80\x00",
    	"\xFF\x80\x1E\x00\x03\xFE\x00\x7F\xC0\x0F\xF8\x01\xFF\x00\x3F\xE0\x07\xFC\x00",
    	"\xFF\x80\x1F\xF0\x03\xC0\x00\x78\x00\x0F\x00\x01\xE0\x00\x3C\x00\x07\x80\x00",
    	"\xFF\x80\x1F\xF0\x03\xC0\x00\x78\x00\x0F\x00\x01\xE0\x00\x3C\x00\x07\xFC\x00",
    	"\xFF\x80\x1F\xF0\x03\xC0\x00\x78\x00\x0F\x00\x01\xE0\x00\x3F\xE0\x07\x80\x00",
    	"\xFF\x80\x1F\xF0\x03\xC0\x00\x78\x00\x0F\x00\x01\xE0\x00\x3F\xE0\x07\xFC\x00",
    	"\xFF\x80\x1F\xF0\x03\xC0\x00\x78\x00\x0F\x00\x01\xFF\x00\x3C\x00\x07\x80\x00",
    	"\xFF\x80\x1F\xF0\x03\xC0\x00\x78\x00\x0F\x00\x01\xFF\x00\x3C\x00\x07\xFC\x00",
    	"\xFF\x80\x1F\xF0\x03\xC0\x00\x78\x00\x0F\x00\x01\xFF\x00\x3F\xE0\x07\x80\x00",
    	"\xFF\x80\x1F\xF0\x03\xC0\x00\x78\x00\x0F\x00\x01\xFF\x00\x3F\xE0\x07\xFC\x00",
    	"\xFF\x80\x1F\xF0\x03\xC0\x00\x78\x00\x0F\xF8\x01\xE0\x00\x3C\x00\x07\x80\x00",
    	"\xFF\x80\x1F\xF0\x03\xC0\x00\x78\x00\x0F\xF8\x01\xE0\x00\x3C\x00\x07\xFC\x00",
    	"\xFF\x80\x1F\xF0\x03\xC0\x00\x78\x00\x0F\xF8\x01\xE0\x00\x3F\xE0\x07\x80\x00",
    	"\xFF\x80\x1F\xF0\x03\xC0\x00\x78\x00\x0F\xF8\x01\xE0\x00\x3F\xE0\x07\xFC\x00",
    	"\xFF\x80\x1F\xF0\x03\xC0\x00\x78\x00\x0F\xF8\x01\xFF\x00\x3C\x00\x07\x80\x00",
    	"\xFF\x80\x1F\xF0\x03\xC0\x00\x78\x00\x0F\xF8\x01\xFF\x00\x3C\x00\x07\xFC\x00",
    	"\xFF\x80\x1F\xF0\x03\xC0\x00\x78\x00\x0F\xF8\x01\xFF\x00\x3F\xE0\x07\x80\x00",
    	"\xFF\x80\x1F\xF0\x03\xC0\x00\x78\x00\x0F\xF8\x01\xFF\x00\x3F\xE0\x07\xFC\x00",
    	"\xFF\x80\x1F\xF0\x03\xC0\x00\x7F\xC0\x0F\x00\x01\xE0\x00\x3C\x00\x07\x80\x00",
    	"\xFF\x80\x1F\xF0\x03\xC0\x00\x7F\xC0\x0F\x00\x01\xE0\x00\x3C\x00\x07\xFC\x00",
    	"\xFF\x80\x1F\xF0\x03\xC0\x00\x7F\xC0\x0F\x00\x01\xE0\x00\x3F\xE0\x07\x80\x00",
    	"\xFF\x80\x1F\xF0\x03\xC0\x00\x7F\xC0\x0F\x00\x01\xE0\x00\x3F\xE0\x07\xFC\x00",
    	"\xFF\x80\x1F\xF0\x03\xC0\x00\x7F\xC0\x0F\x00\x01\xFF\x00\x3C\x00\x07\x80\x00",
    	"\xFF\x80\x1F\xF0\x03\xC0\x00\x7F\xC0\x0F\x00\x01\xFF\x00\x3C\x00\x07\xFC\x00",
    	"\xFF\x80\x1F\xF0\x03\xC0\x00\x7F\xC0\x0F\x00\x01\xFF\x00\x3F\xE0\x07\x80\x00",
    	"\xFF\x80\x1F\xF0\x03\xC0\x00\x7F\xC0\x0F\x00\x01\xFF\x00\x3F\xE0\x07\xFC\x00",
    	"\xFF\x80\x1F\xF0\x03\xC0\x00\x7F\xC0\x0F\xF8\x01\xE0\x00\x3C\x00\x07\x80\x00",
    	"\xFF\x80\x1F\xF0\x03\xC0\x00\x7F\xC0\x0F\xF8\x01\xE0\x00\x3C\x00\x07\xFC\x00",
    	"\xFF\x80\x1F\xF0\x03\xC0\x00\x7F\xC0\x0F\xF8\x01\xE0\x00\x3F\xE0\x07\x80\x00",
    	"\xFF\x80\x1F\xF0\x03\xC0\x00\x7F\xC0\x0F\xF8\x01\xE0\x00\x3F\xE0\x07\xFC\x00",
    	"\xFF\x80\x1F\xF0\x03\xC0\x00\x7F\xC0\x0F\xF8\x01\xFF\x00\x3C\x00\x07\x80\x00",
    	"\xFF\x80\x1F\xF0\x03\xC0\x00\x7F\xC0\x0F\xF8\x01\xFF\x00\x3C\x00\x07\xFC\x00",
    	"\xFF\x80\x1F\xF0\x03\xC0\x00\x7F\xC0\x0F\xF8\x01\xFF\x00\x3F\xE0\x07\x80\x00",
    	"\xFF\x80\x1F\xF0\x03\xC0\x00\x7F\xC0\x0F\xF8\x01\xFF\x00\x3F\xE0\x07\xFC\x00",
    	"\xFF\x80\x1F\xF0\x03\xFE\x00\x78\x00\x0F\x00\x01\xE0\x00\x3C\x00\x07\x80\x00",
    	"\xFF\x80\x1F\xF0\x03\xFE\x00\x78\x00\x0F\x00\x01\xE0\x00\x3C\x00\x07\xFC\x00",
    	"\xFF\x80\x1F\xF0\x03\xFE\x00\x78\x00\x0F\x00\x01\xE0\x00\x3F\xE0\x07\x80\x00",
    	"\xFF\x80\x1F\xF0\x03\xFE\x00\x78\x00\x0F\x00\x01\xE0\x00\x3F\xE0\x07\xFC\x00",
    	"\xFF\x80\x1F\xF0\x03\xFE\x00\x78\x00\x0F\x00\x01\xFF\x00\x3C\x00\x07\x80\x00",
    	"\xFF\x80\x1F\xF0\x03\xFE\x00\x78\x00\x0F\x00\x01\xFF\x00\x3C\x00\x07\xFC\x00",
    	"\xFF\x80\x1F\xF0\x03\xFE\x00\x78\x00\x0F\x00\x01\xFF\x00\x3F\xE0\x07\x80\x00",
    	"\xFF\x80\x1F\xF0\x03\xFE\x00\x78\x00\x0F\x00\x01\xFF\x00\x3F\xE0\x07\xFC\x00",
    	"\xFF\x80\x1F\xF0\x03\xFE\x00\x78\x00\x0F\xF8\x01\xE0\x00\x3C\x00\x07\x80\x00",
    	"\xFF\x80\x1F\xF0\x03\xFE\x00\x78\x00\x0F\xF8\x01\xE0\x00\x3C\x00\x07\xFC\x00",
    	"\xFF\x80\x1F\xF0\x03\xFE\x00\x78\x00\x0F\xF8\x01\xE0\x00\x3F\xE0\x07\x80\x00",
    	"\xFF\x80\x1F\xF0\x03\xFE\x00\x78\x00\x0F\xF8\x01\xE0\x00\x3F\xE0\x07\xFC\x00",
    	"\xFF\x80\x1F\xF0\x03\xFE\x00\x78\x00\x0F\xF8\x01\xFF\x00\x3C\x00\x07\x80\x00",
    	"\xFF\x80\x1F\xF0\x03\xFE\x00\x78\x00\x0F\xF8\x01\xFF\x00\x3C\x00\x07\xFC\x00",
    	"\xFF\x80\x1F\xF0\x03\xFE\x00\x78\x00\x0F\xF8\x01\xFF\x00\x3F\xE0\x07\x80\x00",
    	"\xFF\x80\x1F\xF0\x03\xFE\x00\x78\x00\x0F\xF8\x01\xFF\x00\x3F\xE0\x07\xFC\x00",
    	"\xFF\x80\x1F\xF0\x03\xFE\x00\x7F\xC0\x0F\x00\x01\xE0\x00\x3C\x00\x07\x80\x00",
    	"\xFF\x80\x1F\xF0\x03\xFE\x00\x7F\xC0\x0F\x00\x01\xE0\x00\x3C\x00\x07\xFC\x00",
    	"\xFF\x80\x1F\xF0\x03\xFE\x00\x7F\xC0\x0F\x00\x01\xE0\x00\x3F\xE0\x07\x80\x00",
    	"\xFF\x80\x1F\xF0\x03\xFE\x00\x7F\xC0\x0F\x00\x01\xE0\x00\x3F\xE0\x07\xFC\x00",
    	"\xFF\x80\x1F\xF0\x03\xFE\x00\x7F\xC0\x0F\x00\x01\xFF\x00\x3C\x00\x07\x80\x00",
    	"\xFF\x80\x1F\xF0\x03\xFE\x00\x7F\xC0\x0F\x00\x01\xFF\x00\x3C\x00\x07\xFC\x00",
    	"\xFF\x80\x1F\xF0\x03\xFE\x00\x7F\xC0\x0F\x00\x01\xFF\x00\x3F\xE0\x07\x80\x00",
    	"\xFF\x80\x1F\xF0\x03\xFE\x00\x7F\xC0\x0F\x00\x01\xFF\x00\x3F\xE0\x07\xFC\x00",
    	"\xFF\x80\x1F\xF0\x03\xFE\x00\x7F\xC0\x0F\xF8\x01\xE0\x00\x3C\x00\x07\x80\x00",
    	"\xFF\x80\x1F\xF0\x03\xFE\x00\x7F\xC0\x0F\xF8\x01\xE0\x00\x3C\x00\x07\xFC\x00",
    	"\xFF\x80\x1F\xF0\x03\xFE\x00\x7F\xC0\x0F\xF8\x01\xE0\x00\x3F\xE0\x07\x80\x00",
    	"\xFF\x80\x1F\xF0\x03\xFE\x00\x7F\xC0\x0F\xF8\x01\xE0\x00\x3F\xE0\x07\xFC\x00",
    	"\xFF\x80\x1F\xF0\x03\xFE\x00\x7F\xC0\x0F\xF8\x01\xFF\x00\x3C\x00\x07\x80\x00",
    	"\xFF\x80\x1F\xF0\x03\xFE\x00\x7F\xC0\x0F\xF8\x01\xFF\x00\x3C\x00\x07\xFC\x00",
    	"\xFF\x80\x1F\xF0\x03\xFE\x00\x7F\xC0\x0F\xF8\x01\xFF\x00\x3F\xE0\x07\x80\x00",
    	"\xFF\x80\x1F\xF0\x03\xFE\x00\x7F\xC0\x0F\xF8\x01\xFF\x00\x3F\xE0\x07\xFC\x00"
    ];
    frame = null;


    // _spi - A configured spi (MSB_FIRST, 15MHz)
    // _frameSize - Number of Pixels per frame
    constructor(_spi, _frameSize) {
        this.spi = _spi;
        this.frameSize = _frameSize;
        this.frame = blob(frameSize*57 + 40);
        
        clearFrame();
        writeFrame();
    }

    function writePixel(p,r,g,b) {
        frame.seek(p*57);
        frame.writestring(bits[g]);
        frame.writestring(bits[r]);
        frame.writestring(bits[b]);
    }
    
    function clearFrame() {
      for (local p = 0; p < frameSize; p++) writePixel(p,0,0,0);
      for (local i = 0; i < 40; i++) frame.writen(0x00,'c');
    }
    
    function writeFrame() {
        spi.write(frame);
    }
}

const NUMPIXELS = 20;
const DELAY = 0.5;

spi <- hardware.spi257;
spi.configure(MSB_FIRST, 15000);
pixelStrip <- neoPixels(spi, NUMPIXELS);

previousPixel <- 0
currentPixel <- 0
pAdd <- 1;

function test(d = null) { 
  pixelStrip.writePixel(previousPixel,0,0,0);
  pixelStrip.writePixel(currentPixel,64,0,0);
  pixelStrip.writeFrame();
  if (currentPixel >= NUMPIXELS-1) pAdd = -1;
  if (currentPixel <= 0) pAdd = 1;
  previousPixel = currentPixel;
  currentPixel += pAdd;
  imp.wakeup(DELAY, test);
} test();