#-*- coding:utf-8 -*-
import sys
import re
from Song import Song

class FileProcessor:
    """
    Clasifica nombres de archivos y escribe un Dict con la
    información clasificada en la salida estandar
    para que este sea casteado como JSON en controlador y transmitido
    a la vista.
    """
    def __init__(self):
        """
            Establece parametros necesarios para la clasificación.
        """
        self.filesMatched = self.readStdin()
        self.param = sys.argv[1]
        self.organizedSongs = {"songs":[],"albums":[],"artists":[]}

    def printProcessed(self):
        """
            Return a FileProcessor
            Imprime en la salida estandar el diccionario
            del atributo self.organized
        """
        print(self.organizedSongs)
        return self

    def readStdin(self):
        """
            Return a list
            Lee la entrada estandar donde se espera los nombres de los archivos
            y solo toma los archivos con extensión .mp3 y .ogg
        """
        return [x[:-1] for x in sys.stdin.readlines() if x[-5:] == ".mp3\n" or x[-5:] == ".ogg\n"]

    def organize(self):
        """
            return a FileProcessor
            Clasifica los nombres de los archivos por tipo de match
            si hace match con nombre de canción, con album y/o artista
        """
        albums = set()
        artists = set()
        for i in self.filesMatched:
            matchType = self.matchType(i)

            if "#song#" in matchType:
                self.organizedSongs["songs"].append(Song(i).toDict())

            if "#album#" in matchType:
                fileName = i.split("_")
                albums.add(
                    "%s by %s" 
                    %(
                        fileName[1], 
                        re.sub(r"\.((mp3)|(ogc))\n?","",fileName[2])
                    )
                )

            if "#artist#" in matchType :
                artistName = re.sub(r"\.((mp3)|(ogc))\n?","",i.split("_")[2])
                artists.add(artistName)

        self.organizedSongs["albums"] = list(albums)
        self.organizedSongs["artists"] = list(artists)
        
        return self

    def matchType(self,fileName):
        """
            Return a list
            Determina el tipo de match que hizo el nombre
            del archivo, si el archivo hizo match con nombre de
            canción y album este retornará ["#song#","#album#"]
        """
        fileName = fileName.split("_")

        if re.search(self.param,fileName[0]):
            fileName[0] = "#song#"
        if re.search(self.param,fileName[1]):
            fileName[1] = "#album#"
        if re.search(self.param,fileName[2]):
            fileName[2] = "#artist#"

        return fileName

FileProcessor().organize().printProcessed()