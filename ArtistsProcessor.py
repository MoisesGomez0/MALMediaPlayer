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
        self.filesNames = sys.stdin.readlines()
        self.artists = {"artists":[]}

    def process(self):
        """
        Return a ArtistsProcessor
        procesa los nombres de los archivos y los establece en self.artists
        
        """
        self.artists["artists"] = list(
            set(
                map(
                    lambda x: re.sub(r"\.((mp3)|(ogc))\n","",x.split("_")[2]),
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