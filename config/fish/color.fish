# colors
set -gx COLOR_RESET \033'[0m'
set -gx COLOR_LACK \033'[38;2;112;128;144m'
set -gx COLOR_LUSTER \033'[38;2;222;238;237m'
set -gx COLOR_ORANGE \033'[38;2;255;170;136m'
set -gx COLOR_GREEN \033'[38;2;120;153;120m'
set -gx COLOR_BLUE \033'[38;2;119;136;170m'
set -gx COLOR_RED \033'[38;2;215;0;0m'
set -gx COLOR_BLACK \033'[38;2;0;0;0m'
set -gx COLOR_GRAY1 \033'[38;2;8;8;8m'
set -gx COLOR_GRAY2 \033'[38;2;25;25;25m'
set -gx COLOR_GRAY3 \033'[38;2;42;42;42m'
set -gx COLOR_GRAY4 \033'[38;2;68;68;68m'
set -gx COLOR_GRAY5 \033'[38;2;85;85;85m'
set -gx COLOR_GRAY6 \033'[38;2;122;122;122m'
set -gx COLOR_GRAY7 \033'[38;2;170;170;170m'
set -gx COLOR_GRAY8 \033'[38;2;204;204;204m'
set -gx COLOR_GRAY9 \033'[38;2;221;221;221m'

set -gx COLOR_BG_LACK \033'[48;2;112;128;144m'
set -gx COLOR_BG_LUSTER \033'[48;2;222;238;237m'
set -gx COLOR_BG_ORANGE \033'[48;2;255;170;136m'
set -gx COLOR_BG_GREEN \033'[48;2;120;153;120m'
set -gx COLOR_BG_BLUE \033'[48;2;119;136;170m'
set -gx COLOR_BG_RED \033'[48;2;215;0;0m'
set -gx COLOR_BG_BLACK \033'[48;2;0;0;0m'
set -gx COLOR_BG_GRAY1 \033'[48;2;8;8;8m'
set -gx COLOR_BG_GRAY2 \033'[48;2;25;25;25m'
set -gx COLOR_BG_GRAY3 \033'[48;2;42;42;42m'
set -gx COLOR_BG_GRAY4 \033'[48;2;68;68;68m'
set -gx COLOR_BG_GRAY5 \033'[48;2;85;85;85m'
set -gx COLOR_BG_GRAY6 \033'[48;2;122;122;122m'
set -gx COLOR_BG_GRAY7 \033'[48;2;170;170;170m'
set -gx COLOR_BG_GRAY8 \033'[48;2;204;204;204m'
set -gx COLOR_BG_GRAY9 \033'[48;2;221;221;221m'

set -gx fish_color_end 7a7a7a
set -gx fish_color_error ffaa88
set -gx fish_color_quote 708090
set -gx fish_color_param aaaaaa
set -gx fish_color_option aaaaaa
set -gx fish_color_normal CCCCCC
set -gx fish_color_escape 789978
set -gx fish_color_comment 555555
set -gx fish_color_command CCCCCC
set -gx fish_color_keyword 7a7a7a
set -gx fish_color_operator 7788aa
set -gx fish_color_redirection ffaa88
set -gx fish_color_autosuggestion 2a2a2a
set -gx fish_color_selection --background=555555
set -gx fish_color_search_match --background=555555
set -gx fish_pager_color_prefix 999999
set -gx fish_pager_color_progress 555555
set -gx fish_pager_color_completion cccccc
set -gx fish_pager_color_description 7a7a7a
set -gx fish_pager_color_selected_background --background=555555

# Completion Pager Colors
function log_lack
    echo $COLOR_LACK$argv$COLOR_RESET
end
function log_luster
    echo $COLOR_LUSTER$argv$COLOR_RESET
end
function log_orange
    echo $COLOR_ORANGE$argv$COLOR_RESET
end
function log_green
    echo $COLOR_GREEN$argv$COLOR_RESET
end
function log_blue
    echo $COLOR_BLUE$argv$COLOR_RESET
end
function log_red
    echo $COLOR_RED$argv$COLOR_RESET
end
function log_black
    echo $COLOR_BLACK$argv$COLOR_RESET
end
function log_gray1
    echo $COLOR_GRAY1$argv$COLOR_RESET
end
function log_gray2
    echo $COLOR_GRAY2$argv$COLOR_RESET
end
function log_gray3
    echo $COLOR_GRAY3$argv$COLOR_RESET
end
function log_gray4
    echo $COLOR_GRAY4$argv$COLOR_RESET
end
function log_gray5
    echo $COLOR_GRAY5$argv$COLOR_RESET
end
function log_gray6
    echo $COLOR_GRAY6$argv$COLOR_RESET
end
function log_gray7
    echo $COLOR_GRAY7$argv$COLOR_RESET
end
function log_gray8
    echo $COLOR_GRAY8$argv$COLOR_RESET
end
function log_gray9
    echo $COLOR_GRAY9$argv$COLOR_RESET
end
