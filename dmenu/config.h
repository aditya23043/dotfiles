/* See LICENSE file for copyright and license details. */
/* Default settings; can be overriden by command line. */

static int topbar = 1; /* -b  option; if 0, dmenu appears at bottom     */
static int centered = 0;                    /* -c option; centers dmenu on screen */
static int min_width = 0;                    /* minimum width when centered */
static const float menu_height_ratio = 4.0f;  /* This is the ratio used in the original calculation */

static const int user_bh = 0;               /* add an defined amount of pixels to the bar height */

/* -fn option overrides fonts[0]; default X11 font or font set */
static const char *fonts[] = {"MesloLGSDZ Nerd Font Mono:style=Bold:size=13:antialias=true:autohint=true"};

static const char *prompt =
    NULL; /* -p  option; prompt to the left of input field */
static const char *colors[SchemeLast][2] = {
    /*     fg         bg       */
    [SchemeNorm] = {"#999999", "#141617"},
    [SchemeSel] = {"#000000", "#7daea3"},
    [SchemeOut] = {"#000000", "#00ffff"},
};
/* -l option; if nonzero, dmenu uses vertical list with given number of lines */
static unsigned int lines = 0;

/*
 * Characters not considered part of a word while deleting words
 * for example: " /?\"&[]"
 */
static const char worddelimiters[] = " ";

/* Size of the window border */
static unsigned int border_width = 0;
