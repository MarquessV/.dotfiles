# pyright: reportMissingImports=false

from datetime import datetime
import subprocess

from kitty.fast_data_types import Screen
from kitty.rgb import Color
from kitty.tab_bar import (
    DrawData,
    ExtraData,
    Formatter,
    TabBarData,
    as_rgb,
    draw_attributed_string,
    draw_tab_with_powerline,
)
from kitty.utils import color_as_int

timer_id = None

import subprocess
from datetime import datetime

def readable_timedelta(duration):
    data = {}
    data['days'], remaining = divmod(duration.total_seconds(), 86_400)
    data['h'], remaining = divmod(remaining, 3_600)
    data['m'], data['s'] = divmod(remaining, 60)

    time_parts = [f'{round(value)}{name}' for name, value in data.items() if value > 0]
    if time_parts:
        return ' '.join(time_parts)
    else:
        return 'now'

def get_next_calendar_event():
    with subprocess.Popen(["icalBuddy", "-n", "-nc", "-eed", "-ea", "-li", "1", "eventsToday"],
                                stdout=subprocess.PIPE, 
                                stderr=subprocess.PIPE) as proc:
        out = proc.stdout.read().decode("utf-8")
        out = out[2:]
        name, time, _ = out.split("\n")
        time = time.strip()
        time_object = datetime.strptime(time, "%I:%M %p")
        time_object = datetime.today().replace(hour=time_object.hour, minute=time_object.minute, second=0, microsecond=0)
        if datetime.today() > time_object:
            return f"{name} now"
        time_remaining = time_object - datetime.today()
        readable_time_remaining = readable_timedelta(time_remaining)
        return name, readable_time_remaining

def calc_draw_spaces(*args) -> int:
    length = 0
    for i in args:
        if not isinstance(i, str):
            i = str(i)
        length += len(i)
    return length

def _draw_left_status(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_title_length: int,
    index: int,
    is_last: bool,
    extra_data: ExtraData,
) -> int:
    return draw_tab_with_powerline(draw_data, screen, tab, before, max_title_length, index, is_last, extra_data)

# more handy kitty tab_bar things:
# REF: https://github.com/kovidgoyal/kitty/discussions/4447#discussioncomment-2183440
def _draw_right_status(screen: Screen, is_last: bool) -> int:
    if not is_last:
        return 0

    draw_attributed_string(Formatter.reset, screen)
    date = datetime.now().strftime("%H:%M")
    next_event_name, time_remaining = get_next_calendar_event()
    event_delimit = " in " if time_remaining != 'now' else " "
    separator = " | "

    right_status_length = calc_draw_spaces(next_event_name + event_delimit + time_remaining + separator + date + " ")

    draw_spaces = screen.columns - screen.cursor.x - right_status_length
    if draw_spaces > 0:
        screen.draw(" " * draw_spaces)

    cells = [
        (Color(157, 75, 83), next_event_name),
        (Color(46, 44, 47), event_delimit),
        (Color(89, 121, 95), time_remaining),
        (Color(46, 44, 47), separator),
        (Color(64, 115, 154), date),
    ]

    screen.cursor.fg = 0
    for color, status in cells:
        screen.cursor.fg = as_rgb(color_as_int(color))
        screen.draw(status)
    screen.cursor.bg = 0

    if screen.columns - screen.cursor.x > right_status_length:
        screen.cursor.x = screen.columns - right_status_length

    return screen.cursor.x


# REF: https://github.com/kovidgoyal/kitty/discussions/4447#discussioncomment-1940795
# def redraw_tab_bar():
#     tm = get_boss().active_tab_manager
#     if tm is not None:
#         tm.mark_tab_bar_dirty()


def draw_tab(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_title_length: int,
    index: int,
    is_last: bool,
    extra_data: ExtraData,
) -> int:
    # _draw_icon(screen, index, symbol="    ")
    _draw_left_status(
        draw_data,
        screen,
        tab,
        before,
        max_title_length,
        index,
        is_last,
        extra_data,
    )
    _draw_right_status(
        screen,
        is_last,
    )

    return screen.cursor.x
