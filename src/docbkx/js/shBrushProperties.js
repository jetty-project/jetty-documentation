/**
 * A Syntax Highlighter brush for Java properties files.
 * For a description of their syntax, see the link below. 
 * @see "http://download.oracle.com/javase/1.5.0/docs/api/java/util/Properties.html#load(java.io.InputStream)"
 * @version 1.0
 * @author Alexandre DUTRA
 *
 */
;(function()
{
	// CommonJS
	typeof(require) != 'undefined' ? SyntaxHighlighter = require('shCore').SyntaxHighlighter : null;

	function Brush() {
				
		function process(match, regexInfo)  {
			var result = [];
			var line = match[0];
			//one or more lines with just a line terminator have been skipped => reset flags for multiline keys and values
			//but continue processing
			if(match.index > currentIndex + 1) {
				multilineValue = false;
				multilineKey = false;
			}
			//a line with whitespaces only => reset flags for multiline keys and values and stop processing
			if(isBlank(line)){
				multilineValue = false;
				multilineKey = false;
			//a comment line
			} else if(!multilineValue && !multilineKey && isComment(line)){
				pushResult(result, line, match.index, 'comments');
			//a value spanned over multiple lines
			} else if (multilineValue) {
				pushResult(result, line, match.index, 'string');
				multilineValue = isMultiline(line);
			} else {
				//a line containing at least a key, possibly key + separator + value
				//can also be the continuation of a multiline key
				var indexes = splitKeySepValue(line);
				//separator found
				if(indexes[0] != -1) {
					//non empty key
					if(indexes[0] > 0) {
						var key = line.substring(0, indexes[0]);
						pushResult(result, key, match.index, 'functions');
					}
					//separator
					var sep = line.substring(indexes[0], indexes[1] != -1 ? indexes[1] : line.length);
					pushResult(result, sep, match.index + indexes[0], 'constants');
					//non empty value
					if(indexes[1] != -1) {
						var value = line.substring(indexes[1], line.length);
						pushResult(result, value, match.index + indexes[1], 'string');
					}
					//check if it is the start of a multiline value
					multilineValue = isMultiline(line);
					multilineKey = false;
				} else {
					//no separator => key without value, check if it is the start of a multiline key
					var key = line.substring(0, line.length);
					pushResult(result, key, match.index, 'functions');
					multilineValue = false;
					multilineKey = isMultiline(line);
				}
			}
			//record the current input index
			currentIndex = match.index + line.length;
			return result;
		}
				
		function isBlank(text) {
			return text.match(/^\s*$/);
		}
		
		function isComment(text) {
			return text.match(/^\s*[#!].*$/);
		}

		function isMultiline(text) {
			return text.match(/^.*\\\s*$/g);
		}
		
		/**
		 * Splits the line into up to 3 parts: key, separator and value.
		 * Returns the indexes for the separator and the value, if they are found, or -1 otherwise.
		 */
		function splitKeySepValue(text) {
			var indexes = [-1,-1];
			var escape = false;
			var INIT=-1, KEY=0, SEP=1;
			var state = INIT;
			var hardSepFound = false;
			for(var i = 0; i < text.length; i++) {
				var c = text.charAt(i);
				switch(state) {
					case INIT:
						if(!isSoftSeparator(c)){
							if(isSeparator(c)) {
								state = SEP;
								indexes[0] = i;
							} else {
								state = KEY;
							}
						}
						break;
					case KEY:
						if(!escape && isSeparator(c)) {
							state = SEP;
							indexes[0] = i;
						}
						hardSepFound = isHardSeparator(c);
						break;
					case SEP:
						if(!isSeparator(c) || (hardSepFound && isHardSeparator(c))) {
							indexes[1] = i;
							return indexes;
						}
						hardSepFound = isHardSeparator(c);
						break;
				}
				escape = c === '\\';
			}
			return indexes;
		}
		
		/**
		 * Creates a new constructor and pushes it to the result.
		 * @param result
		 * @param text
		 * @param index
		 * @param css
		 */
		function pushResult(result, text, index, css){
			var constructor = SyntaxHighlighter.Match;
			var unicodeIndex = findUnicodeEscapeIndex(text);
			while(unicodeIndex != -1) {
				if(unicodeIndex > 0) {
					var textBefore = text.substring(0, unicodeIndex);
					result.push(new constructor(textBefore, index, css));
				}
				var escape = text.substr(unicodeIndex, 6);
				result.push(new constructor(escape, index + unicodeIndex, 'keyword'));
				text = text.substring(unicodeIndex + 6, text.length);
				index = index + unicodeIndex + 6;
				unicodeIndex = findUnicodeEscapeIndex(text);
			}
			if(text != '') {
				result.push(new constructor(text, index, css));
			}
		}
		
		/**
		 * Locates unicode escape sequences of the form "\u" + four hex digits.
		 * @param text
		 * @return the index of the escape sequence start
		 */
		function findUnicodeEscapeIndex(text) {
			var escape = false;
			var started = false;
			for(var i = 0; i < text.length; i++) {
				var c = text.charAt(i);
				if(c === '\\'){
					escape = true;
				} else {
					if(escape && c === 'u') {
						return i - 1;
					}
					escape = false;
				}
			}
			return -1;
		}
		
		function isSeparator(c) {
			return c === '=' || c === ':' || c === ' ' || c === '\t';
		}
		
		function isHardSeparator(c) {
			return c === '=' || c === ':';
		}
		
		function isSoftSeparator(c) {
			return c === ' ' || c === '\t';
		}
		
		var multilineValue = false;
		var multilineKey = false;
		var currentIndex = -1;
		
		this.regexList = [
			{ regex: /^.+$/gm, func: process }
		];

	};

	Brush.prototype	= new SyntaxHighlighter.Highlighter();
	Brush.aliases	= ['properties'];

	SyntaxHighlighter.brushes.Properties = Brush;

	// CommonJS
	typeof(exports) != 'undefined' ? exports.Brush = Brush : null;
})();