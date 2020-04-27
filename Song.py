#-*-coding:utf-8-*-
import re

class Song:
    def __init__(self,fileName):
        self.fileName = fileName
        fileNameSplited = fileName.split("_")

        self.name = fileNameSplited[0]
        self.album = fileNameSplited[1]
        self.artist = re.sub(r"\.((mp3)|(ogc))\n?","",fileNameSplited[2])

        del(fileNameSplited)

    def toDict(self):
        return {"fileName":self.fileName,"name":self.name,"album":self.album,"artist":self.artist}
