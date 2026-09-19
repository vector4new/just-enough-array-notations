import jean_parser

file = "example.jean"

data = jean_parser.parse_jean_file(file)
print(data)