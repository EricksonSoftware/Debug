class_name JavaScriptCodeEditor
extends CodeEdit

const FONT_COLOR : Color = Color("#ffffff")
const STRING_COLOR : Color = Color("#50a050")
const COMMENT_COLOR : Color = Color("#808080")
const KEYWORD_COLOR : Color = Color("#4040ff")
const MEMBER_COLOR : Color = Color("#ff40ff")
const NUMBER_COLOR : Color = Color("#ff4040")
const FUNCTION_COLOR : Color = Color("#6060ff")

func _ready() -> void:
	highlight_code()
	if not editable:
		self.modulate = Color(0.8, 0.8, 0.8)

func highlight_code() -> void:
	var highlighter : CodeHighlighter = syntax_highlighter as CodeHighlighter
	highlighter.symbol_color = FONT_COLOR
	highlighter.number_color = NUMBER_COLOR
	highlighter.function_color = FUNCTION_COLOR
	highlighter.member_variable_color = MEMBER_COLOR
	
	highlighter.add_color_region("\"", "\"", STRING_COLOR, false)
	highlighter.add_color_region("'", "'", STRING_COLOR, false)
	highlighter.add_color_region("//", "", COMMENT_COLOR, true)
	highlighter.add_color_region("/*", "*/", COMMENT_COLOR, false)
	
	for keyword in Constants.JAVASCRIPT_KEYWORDS:
		highlighter.add_keyword_color(keyword, KEYWORD_COLOR)
	for member in Constants.JAVASCRIPT_MEMBERS:
		highlighter.add_member_keyword_color(member, MEMBER_COLOR)

func update_height() -> void:
	var font : Font = get_theme_font("font")
	var font_size : int = get_theme_font_size("font_size")
	var font_height : float = font.get_height(font_size)
	var num_lines : int = get_line_count()
	var padding : int = 4
	custom_minimum_size.y = num_lines * (font_height + padding)
