#-*- coding:utf-8 -*-
import sys
import re
from Song import Song

class FileProcessor:
    def __init__(self):
        self.filesMatched = sys.stdin.readlines()
        self.param = sys.argv[1]
        self.organizedSongs = {"songs":[],"albums":[],"artists":[]}

    def printProcessed(self):
        print(self.organizedSongs)
        return self

    def organize(self):
        albums = set()
        artists = set()
        for i in self.filesMatched:
            matchType = self.matchType(i)

            if matchType == "song":
                self.organizedSongs["songs"].append(Song(i).toDict())

            elif matchType == "album":
                albumName = i.split("_")[1]
                albums.add(albumName)

            elif matchType == "artist":
                artistName = re.sub(r"\.((mp3)|(ogc))\n","",i.split("_")[2])
                artists.add(artistName)

        self.organizedSongs["albums"] = list(albums)
        self.organizedSongs["artists"] = list(artists)
        
        return self

    def matchType(self,fileName):
        fileName = fileName.split("_")

        if re.search(self.param,fileName[1]):
            return "album"
        elif re.search(self.param,fileName[2]):
            return "artist"
        elif re.search(self.param,fileName[0]):
            return "song"

        return None

    def processSongs(self):
        self.organize()
        return self

FileProcessor().processSongs().printProcessed()