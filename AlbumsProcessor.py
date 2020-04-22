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
        self.filesNames = sys.stdin.readlines()
        self.albums = {"albums":[]}

    def process(self):
        """
        Return a AlbumsProcessor
        procesa los nombres de los archivos y los establece en self.albums
        
        """
        self.albums["albums"] = list(
            set(
                map(
                    lambda x: x.split("_")[1],
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