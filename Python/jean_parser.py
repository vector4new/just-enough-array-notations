def parse_jean_data(text: str) -> list:
    tokens = []
    i = 0
    n = len(text)

    while i < n:
        char = text[i]

        if char.isspace():
            i += 1
            continue

        if char == '%':
            while i < n and text[i] not in '\r\n':
                i += 1
            continue

        if char == '"':
            start = i + 1
            i += 1
            while i < n and text[i] != '"':
                i += 1
            if i >= n:
                raise ValueError("Unterminated string literal")
            tokens.append(text[start:i])
            i += 1
            continue

        start = i
        while i < n and not text[i].isspace() and text[i] != '%':
            i += 1
        word = text[start:i]

        if word == 't':
            tokens.append(True)
        elif word == 'f':
            tokens.append(False)
        else:
            try:
                tokens.append(int(word))
            except ValueError:
                try:
                    tokens.append(float(word))
                except ValueError:
                    raise ValueError(f"Unrecognized token: '{word}'")

    return tokens


def parse_jean_file(file_path: str) -> list:
    with open(file_path, 'r', encoding='utf-8') as f:
        file_content = f.read()
    return parse_jean_data(file_content)