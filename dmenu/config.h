// #include "/home/adi/.cache/wal/colors-wal-dmenu.h"

static int topbar = 1;                      /* -b  option; if 0, dmenu appears at bottom     */
static int centered = 1;                    /* -c option; centers dmenu on screen */
static int min_width = 350;                    /* minimum width when centered */
/* -fn option overrides fonts[0]; default X11 font or font set */
static const int user_bh = 15;               /* add an defined amount of pixels to the bar height */

static const char *colors[SchemeLast][2] = {
	/*                  fg         bg       */
	[SchemeNorm] = { "#d3dccf", "#1d2021" },
	[SchemeSel] = { "#000000", "#ebdbb2" },
	[SchemeOut] = { "#d3dccf", "#A3BB8D" },
};

static const char *fonts[] = {
	"Ubuntu Condensed:size=16"
};
static const char *prompt      = NULL;      /* -p  option; prompt to the left of input field */

/* -l option; if nonzero, dmenu uses vertical list with given number of lines */
static unsigned int lines      = 8;

/*
 * Characters not considered part of a word while deleting words
 * for example: " /?\"&[]"
 */
static const char worddelimiters[] = " ";

/* Size of the window border */
static unsigned int border_width = 2;
