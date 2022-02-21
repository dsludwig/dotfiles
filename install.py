import pathlib


def main():
    replace_all = False
    path = pathlib.Path('.')
    for fn in path.glob("*"):
        if fn.name.startswith('.') or fn.name in ('install.py'):
            continue
        fn = fn.resolve()
        home_fn = path.home() / ('.' + fn.name)
        if home_fn.is_symlink() or home_fn.exists():
            if home_fn.exists() and home_fn.samefile(fn):
                print(f'identical {home_fn}')
            elif replace_all:
                replace_file(home_fn, fn)
            else:
                answer = input(f'overwrite {home_fn}? [ynaq] ')
                if answer == 'a':
                    replace_all = True
                    replace_file(home_fn, fn)
                elif answer == 'y':
                    replace_file(home_fn, fn)
                elif answer == 'q':
                    return
        else:
            link_file(home_fn, fn)


def replace_file(home_fn: pathlib.Path, fn: pathlib.Path):
    if home_fn.is_dir():
        # TODO: remove recursive
        home_fn.rmdir()
    else:
        home_fn.unlink()
    link_file(home_fn, fn)


def link_file(home_fn: pathlib.Path, fn: pathlib.Path):
    print(f'ln -s {fn} {home_fn}')
    home_fn.symlink_to(fn)


if __name__ == "__main__":
    main()
