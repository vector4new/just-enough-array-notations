extends Resource
class_name JeanParser

func _is_char_whitespace(character: String) -> bool:
	return character in [" ", "\t", "\n", "\r"]

func _skip_comment(text: String, i: int, n: int) -> int:
	if text[i] == "%":
		while i < n and not text[i] in ["\r", "\n"]:
			i += 1
	return i

func parse_jean_data(text: String) -> Array:
	var tokens: Array = []
	var i: int = 0
	var n: int = text.length()
	
	while i < n:
		var _char: String = text[i]
		
		if _is_char_whitespace(_char):
			i += 1
			continue
		
		if _char == "%":
			i = _skip_comment(text, i, n)
			continue
		
		if _char == '"':
			var str_start: int = i + 1
			i += 1
			while i < n and text[i] != '"':
				i += 1
			if i >= n:
				printerr("Unterminated string literal")
				return tokens
			tokens.append(text.substr(str_start, i - str_start))
			i += 1
			continue
		
		var word_start: int = i
		while i < n and not _is_char_whitespace(text[i]) and text[i] != '%':
			i += 1
		var word: String = text.substr(word_start, i - word_start)
		
		if word.is_empty():
			continue
		
		if word == 't':
			tokens.append(true)
		elif word == 'f':
			tokens.append(false)
		elif word.is_valid_int():
			tokens.append(word.to_int())
		elif word.is_valid_float():
			tokens.append(word.to_float())
		else:
			printerr("Unrecognized token: '" + word + "'")
	
	return tokens

func parse_jean_file(file_path: String) -> Array:
	if not FileAccess.file_exists(file_path):
		printerr("File not found: " + file_path)
		return []
	
	var file = FileAccess.open(file_path, FileAccess.READ)
	var content: String = file.get_as_text()
	file.close()
	
	return parse_jean_data(content)