#!/usr/bin/env python

# Copyright (C) 2014 Alex Cornejo.
# License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
# This is free software: you are free to change and redistribute it.
# There is NO WARRANTY, to the extent permitted by law.

from HTMLParser import HTMLParser
import sys
import argparse
import urlparse
import urllib2

base_url = None
parent_only = False

class LinkParser(HTMLParser):
    def handle_starttag(self, tag, attrs):
        if tag == "a":
           for name, value in attrs:
               if name == "href":
                   if base_url != None and value.find("://") == -1:
                       url = urlparse.urljoin(base_url, value)
                   else:
                       url = value
                   if not parent_only or base_url == None  or url.find(base_url) == 0:
                        print url


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="URL extraction tool")
    parser.add_argument('--parent_only', '-p', dest='parent', action='store_true')
    parser.add_argument('--base_url', '-b', default=base_url, type=str,
            help='base url to prepend to relative urls. Only usable when reading from <stdin>')
    parser.add_argument('url', nargs='?', help='url to query')
    parser.set_defaults(parent=parent_only)

    args = parser.parse_args()
    base_url = args.base_url
    parent_only = args.parent
    if args.url:
        contents = urllib2.urlopen(args.url).read()
        if base_url:
            print "Error: cannot supply a base_url and a url at the same time!"
            parser.print_help()
            sys.exit(1)
        else:
            base_url = args.url
    else:
        contents = sys.stdin.read()

    link_parser = LinkParser()
    link_parser.feed(contents)
