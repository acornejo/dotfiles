#!/usr/bin/env python

import sys
import re
import urllib
import json
import traceback
from threading import Thread
try:
    from mutagen.id3 import ID3, APIC, TALB
except ImportError:
    print "This script requires python mutagen bindings."
    print "In debian-based systems get them through apt-get install python-mutagen"
    sys.exit(1)

try:
    import pylast
except ImportError:
    print "This script requires python last.fm bindings. Getting them now."
    pylast_urlfile = urllib.urlopen("http://pylast.googlecode.com/svn/trunk/pylast.py")
    pylast_file = open(sys.path[0] + "/pylast.py",'wb')
    pylast_file.write(pylast_urlfile.read())
    pylast_file.close() # Save it to pylast.py in the current directory
    import pylast

class CoverGetter:
    def __init__(self):
        api_key = '5dde241299a6b25d28769972e966471b'
        self.network = pylast.LastFMNetwork(api_key = api_key)

    def get_album(self,artist,song):
        tracks = self.network.search_for_track(artist, song).get_next_page()
        for track in tracks[:5]:
            try:
                album_object = track.get_album()
                return album_object.get_name()
            except:
                continue
        return song

    def get_google_url(self,artist,album):
        try:
            qstr = artist.encode("iso-8859-1", "ignore")+" "+album.encode("iso-8859-1","ignore") + " album cover"
            query = urllib.urlencode({'q': qstr})
            response = urllib.urlopen('http://ajax.googleapis.com/ajax/services/search/images?v=1.0&%s'% query)
            results = json.loads(response.read())['responseData']['results']
            for result in results:
                if result['url'].find('.jpg') != -1:
                    return result['url']
            return None
        except:
            traceback.print_exc()
            return None

    def get_lastfm_url(self,artist,album):
        album_object = self.network.get_album(artist, album)
        try:
            cover_url = None
            sizes = [3,2,1,0,4]
            for size in sizes:
                cover_url = album_object.get_cover_image(size)
                if cover_url != None:
                    return cover_url
            return None
        except:
            return None

    def get_cover_urls(self,artist,album):
        urls = []
        url = self.get_lastfm_url(artist,album)
        if url != None:
            urls.append(url)
        url = self.get_google_url(artist,album)
        if url != None:
            urls.append(url)
        return urls

def fetch_image(url):
    image_file = urllib.urlopen(url)
    extension = url.split('.')[-1]
    data = image_file.read()
    if len(data) < 1024: raise Exception("Corrupted Image")
    return [extension, data]

class FetchThread(Thread):
    def __init__(self,coverid,urls):
        Thread.__init__(self)
        self.coverid = coverid
        self.urls = urls
        self.cover = None

    def run(self):
        for url in self.urls:
            try:
                self.cover = fetch_image(url)
                print "Fetched cover ", self.coverid
                break
            except:
                print "Error fetching ", self.coverid, " from ", url
                continue


def retrieve_covers(songlist, usealbum = False, fillalbum = False):
    getter = CoverGetter()
    covers = {}
    albums = {}
    songs = {}
    threads = []
    for song in songlist:
        try:
            print "Looking for cover for ", song
            meta = ID3(song)
            artist = str(meta["TPE1"])
            artist = re.sub('Featuring.*$','', artist)
            artist = re.sub('featuring.*$','', artist)
            artist = re.sub('Ft\..*$','', artist)
            artist = re.sub('ft\..*$','', artist)
            artist = artist.strip()
            track = str(meta["TIT2"])
            track = re.sub('\(.*?\)', '', track)
            album = None
            if usealbum:
                try:
                    album = str(meta["TALB"])
                except:
                    pass
            if album == None:
                album = getter.get_album(artist, track)
                album = album.encode("iso-8859-1","ignore")
            cover_id = artist+" "+album
            songs[song] = cover_id
            if cover_id not in covers:
                try:
                    albums[cover_id] = unicode(album)
                except:
                    try:
                        albums[cover_id] = album.decode('latin-1')
                    except:
                        albums[cover_id] = album.decode('utf-8')
                covers[cover_id] = None
                cover_urls = getter.get_cover_urls(artist, album)
                if len(cover_urls) > 0:
                    print "Fetching cover for ", cover_id
                    thread = FetchThread(cover_id,cover_urls)
                    thread.start()
                    threads.append(thread)
                else:
                    print "Error no cover found for ", cover_id
        except:
            print "Unexpected error processing", song
            traceback.print_exc()

    print "Waiting to fetch all covers."
    for thread in threads:
        thread.join()
        covers[thread.coverid]=thread.cover

    print "Writing all covers"
    for song in songs.keys():
        cover_id = songs[song]
        cover = covers[cover_id]
        try:
            if cover != None:
                print "Writing cover for ", song
                meta = ID3(song)
                if fillalbum: meta["TALB"] = TALB(encoding=3, text=albums[cover_id])
                meta.delall('APIC')
                meta.add(
                    APIC(
                        encoding=3,
                        mime="image/%s"%cover[0],
                        type=3,
                        desc=u'Front Cover',
                        data=cover[1]
                    )
                )
                meta.save()
        except:
            print "Error writing cover for ", song
            traceback.print_exc()

if __name__ == "__main__":
    retrieve_covers(sys.argv[1:], usealbum = True, fillalbum = True)
