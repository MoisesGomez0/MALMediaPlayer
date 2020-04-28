#-*- coding:utf-8 -*-
import sys

class AlbumsProcessor:
    """
    Recibe por la entrada estandar los nombres de los archivos 
    los procesa y los convierte a una notación establecida por los desarrolladores.
    """
    def __init__(self):
        """
        filesName -> list Nombres de archivos leidos de la entrada estandar.
        albums -> dict Nombres de albumes en nomenclatura acordada.
        """
        self.filesNames = self.readStdin()
        self.albums = {"albums":[]}

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
        Return a AlbumsProcessor
        procesa los nombres de los archivos y los establece en self.albums
        
        """
        self.albums["albums"] = list(
            set(
                map(
                    lambda x: "%s by %s" % (x.split("_")[1], x.split("_")[2]),
                    self.filesNames
                )
            )
        )

        return self


    def printProcessed(self):
        """
        Imprime en la salida estandas la lista de albumes
        """
        print(self.albums)

AlbumsProcessor().process().printProcessed()