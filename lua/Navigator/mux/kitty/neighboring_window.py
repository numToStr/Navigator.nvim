def main():
    pass


def handle_result(args, result, target_window_id, boss):
    if args[1] == 'p':
        boss.active_tab.nth_window(-1)
    else:
        boss.active_tab.neighboring_window(args[1])

handle_result.no_ui = True
