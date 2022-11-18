#/usr/local/env bash

# TODO clean up
# Referenced data from https://github.com/jonasjacek/colors

# TODO cross reference http://www.calmar.ws/vim/256-xterm-24bit-rgb-color-chart.html

for ansi_code in {0..255}; do 

  fg_labels="Foreground,fg"
  fg_color="$(ansi --color=$ansi_code --no-restore --no-newline)"
  fg_background_color="$(ansi --bg-color=233 --no-newline --no-restore)"

  ansi_code_padded=$(printf "%03d" $ansi_code)
  ansi_code_data_line="$(sed "$(($ansi_code + 1))q;d" color-data-ext-col-trim.out)"
  ansi_code_print_data="${ansi_code_data_line##* }"
  ansi_code_data="${ansi_code_data_line% *}"

  normalized_fg_color=$(printf "%q" "${fg_color}")
  normalized_fg_color="${normalized_fg_color:1}"
  normalized_fg_color="${normalized_fg_color%\'}"
  normalized_fg_color="${normalized_fg_color#\'}"
  normalized_fg_color="${normalized_fg_color/\\E/\\033}"

  ansi --bg-color=16 --bold --no-newline --no-restore
  printf "%s%s %-35s" "$fg_background_color" "$fg_color" "$ansi_code_print_data"
  ansi --reset-foreground --reset-background --no-newline
  printf " "
  ansi --reset-background --bg-color=7 --bold --no-newline --no-restore
  printf "%s %-35s" "$fg_color" "$ansi_code_print_data"
  ansi --reset-foreground --reset-background --no-newline --reset-color
  printf " "
  printf "%s %-14s %-18s %s %s\n" "$ansi_code_padded" "$normalized_fg_color" "\\[$normalized_fg_color\\]" "$ansi_code_data" "$fg_labels"
  ansi --reset-attrib --reset-foreground --reset-background --reset-color --reset-font --erase-display --no-newline

done

for ansi_code in {0..255}; do 

  bg_labels="Background,bg"
  bg_color="$(ansi --bg-color=$ansi_code --no-restore --no-newline)"
  bg_text_color="$(ansi --color=254 --no-newline --no-restore)"

  ansi_code_padded=$(printf "%03d" $ansi_code)
  # ansi_code_data="$(grep ^$ansi_code_padded color-data-ext-col.out)"
  ansi_code_data_line="$(sed "$(($ansi_code + 1))q;d" color-data-ext-col-trim.out)"
  ansi_code_print_data="${ansi_code_data_line##* }"
  ansi_code_data="${ansi_code_data_line% *}"

  normalized_bg_color=$(printf "%q" "${bg_color}")
  normalized_bg_color="${normalized_bg_color:1}"
  normalized_bg_color="${normalized_bg_color%\'}"
  normalized_bg_color="${normalized_bg_color#\'}"
  normalized_bg_color="${normalized_bg_color/\\E/\\033}"

  printf "%s%s %-35s" "$bg_color" "$bg_text_color" "$ansi_code_print_data"
  ansi --reset-background --no-newline
  printf " "
  ansi --reset-foreground --color=16 --bold --no-newline --no-restore
  printf "%s %-35s" "$bg_color" "$ansi_code_print_data"
  ansi --reset-foreground --reset-background --no-newline --reset-color
  printf " "
  printf "%s %-14s %-18s %s %s\n" "$ansi_code_padded" "$normalized_bg_color" "\\[$normalized_bg_color\\]" "$ansi_code_data" "$bg_labels"
  ansi --reset-attrib --reset-foreground --reset-background --reset-color --reset-font --erase-display --no-newline
done
