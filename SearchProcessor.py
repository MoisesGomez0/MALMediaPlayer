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
            Clasifica los nombres de los archivos por
            nombre de canción, con album y/o artista
        """
        albums = set()
        artists = set()
    
        for i in self.filesMatched:
            self.organizedSongs["songs"].append(Song(i).toDict())
            albums.add(i.split("_")[1])
            artists.add(i.split("_")[0])

        self.organizedSongs["albums"] = list(albums)
        self.organizedSongs["artists"] = list(artists)
        
        return self

FileProcessor().organize().printProcessed()