/// Font used when signing on paper.
#define SIGNATURE_FONT "Segoe Script"

// Font metrics bitfield
/// Include leading A width and trailing C width in GetWidth() or in DrawText()
#define INCLUDE_AC (1<<0)

DEFINE_BITFIELD(font_flags, list(
	"INCLUDE_AC" = INCLUDE_AC,
))
