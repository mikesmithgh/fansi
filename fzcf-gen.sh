#!/usr/bin/env bash

# TODO clean this up

# TODO add validation
flag=$1

if [[ "$flag" == "--true-color" ]]; then
  awk 'BEGIN {	
  # for(dec = 0;dec < 500;dec++) {
  for(dec=0;dec<16777216;dec = dec + 5) {
    hex=sprintf("#%06X", dec)
    r_hex=sprintf("0x%s",substr(hex, 2, 2))
    g_hex=sprintf("0x%s",substr(hex, 4, 2))
    b_hex=sprintf("0x%s",substr(hex, 6, 2))
    r=sprintf("%d", r_hex)
    g=sprintf("%d", g_hex)
    b=sprintf("%d", b_hex)
    rgb_space=sprintf("%d %d %d", r, g, b)
    rgb_semicolon=sprintf("%d;%d;%d;", r, g, b)
    fg_color_start=sprintf("\x1b[%s;2;%sm", "38", rgb_semicolon)
    fg_background_dark=sprintf("\x1b[%s;2;%sm", "48", "16;16;16")
    fg_background_light=sprintf("\x1b[%s;2;%sm", "48", "245;245;245")
    bg_color_start=sprintf("\x1b[%s;2;%sm", "48", rgb_semicolon)
    bg_text_dark=sprintf("\x1b[%s;2;%sm", "38", "16;16;16")
    bg_text_light=sprintf("\x1b[%s;2;%sm", "38", "245;245;245")
    color_stop=sprintf("\x1b[0m")
    display_data=sprintf("%11s %11s %11s", dec, hex, rgb_space)
    "tput cols || echo 80" | getline width

    s=sprintf("%s%s▕%s%*s%s%s▏%s", color_stop, bg_text_dark, bg_color_start, (width/4) - 2, "", color_stop, bg_text_dark, color_stop);
    gsub(/ /,"▁",s);
    printf(" %s%*s%s\n", fg_background_dark, -(width/4), display_data, s)
  }
}'
fi



