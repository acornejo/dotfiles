#!/usr/bin/env python
# -*- coding: utf-8 -*-

# Author: Alex Cornejo
# Purpose: Print the include dependency tree of a C/C++ file.

import sys
import clang.cindex
import asciitree
import argparse
from collections import namedtuple

Node = namedtuple('Node', ['name', 'level', 'offset', 'children'])

def parse_file(fname):
    index = clang.cindex.Index.create()
    tu = index.parse(fname)
    includes = [(f.include.name, f.depth) for f in tu.get_includes() if not f.include.name.startswith("/usr")]

    children = [Node(f[0], f[1], i+1, []) for i, f in enumerate(includes) if f[1] == 1]
    root = Node(tu.spelling, 0, 0, children)
    queue = list(children)

    while len(queue) > 0:
        cur = queue.pop(0)
        for i, f in enumerate(includes[cur.offset:]):
            if f[1] == cur.level + 1:
                node = Node(f[0], f[1], cur.offset + i + 1, [])
                queue.append(node)
                cur.children.append(node)
            elif f[1] > cur.level + 1:
                continue
            else:
                break

    return root

if __name__ == '__main__':
    try:
        clang.cindex.Index.create()
    except:
        # Hack required for libclang.so not being in LD_LIBRARY_PATH
        clang.cindex.Config.set_library_file('/usr/lib/llvm-3.4/lib/libclang.so')
        try:
            clang.cindex.Index.create()
        except:
            print "Unable to find libclang.so in your LD_LIBRARY_PATH"
            sys.exit(1)

    parser = argparse.ArgumentParser(prog="inctree")
    parser.add_argument('files', metavar='FILE', type=str, nargs='+', help='The C/C++ source files to parse.')
    args = parser.parse_args()

    for fname in args.files:
        print asciitree.draw_tree(parse_file(fname), lambda x: x.children, lambda x: x.name)

    sys.exit(0)
