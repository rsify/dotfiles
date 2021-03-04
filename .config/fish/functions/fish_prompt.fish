# Stolen from https://github.com/rafaelrinaldi/pure/blob/master/functions/_pure_format_time.fish
function _pure_format_time \
    --description="Format milliseconds to a human readable format" \
    --argument-names milliseconds threshold

    if test $milliseconds -lt 0; return 1; end

    set --local seconds (math -s0 "$milliseconds / 1000 % 60")
    set --local minutes (math -s0 "$milliseconds / 60000 % 60")
    set --local hours (math -s0 "$milliseconds / 3600000 % 24")
    set --local days (math -s0 "$milliseconds / 86400000")
    set --local time

    if test $days -gt 0
        set time $time (printf "%sd" $days)
    end

    if test $hours -gt 0
        set time $time (printf "%sh" $hours)
    end

    if test $minutes -gt 0
        set time $time (printf "%sm" $minutes)
    end

    if test $seconds -gt $threshold
        set time $time (printf "%ss" $seconds)
    end

    echo -e (string join ' ' $time)
end

function fish_prompt --description 'Write out the prompt'
    set -l prefix
    set -l last_status $status

    if test (jobs)
        echo -n (set_color --bold cyan) \&
    end

    if test $last_status != "0"
        set prefix (set_color red --bold) "$last_status "
    end

    set formatted_duration (_pure_format_time $CMD_DURATION 1)

    set -l time
    if test -n $formatted_duration
        set time (set_color yellow) $formatted_duration ' '
    end

    echo -n -s ' ' $prefix $time (set_color --bold white) (prompt_pwd) ' ' (set_color normal)
end
