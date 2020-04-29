#-*- coding:utf-8 -*-
import sys, re

class ArtistsProcessor:
    """
    Recibe por la entrada estandar los nombres de los archivos 
    los procesa y los convierte a una notación establecida por los desarrolladores.
    """
    def __init__(self):
        """
        filesName -> list Nombres de archivos leidos de la entrada estandar.
        artists -> dict Nombres de los artistas en nomenclatura acordada.
        """
        self.filesNames = self.readStdin()
        self.artists = {"artists":[]}

    def readStdin(self):
        """
            Return a list
            Lee la entrada estandar y toma solo los archivos que corresponden
            con una canción.
        """
        return [
            x[:-5] for x in sys.stdin.readlines() 
            if x[-5:] == ".mp3\n" or x[-5:] == ".ogg\n"
        ]


    def process(self):
        """
        Return a ArtistsProcessor
        procesa los nombres de los archivos y los establece en self.artists
        
        """
        self.artists["artists"] = list(
            set(
                map(
                    lambda x: x.split("_")[0],
                    self.filesNames
                )
            )
        )

        return self


    def printProcessed(self):
        """
        Imprime en la salida estandar la lista de artistas
        """
        print(self.artists)

ArtistsProcessor().process().printProcessed()