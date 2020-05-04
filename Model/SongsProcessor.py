#-*- conding:utf-8 -*-
import re, sys
from Song import Song

class SongsProcessor:
    """
        Objeto encargado de procesar los nombres de 
        todos los archivos dados a través de la entrada estandar
        para convertirlos en un formato JSON
    """

    def __init__(self):
        """ 
        Constructor lee la entrada estandar

            filesName -> list Nombre de todas los archivos pasador por la entrada estandar estos debe cumplir con la nomenclatura adecuada.

            processd -> dict Diccionario con todos los nombres de archivos procesados y dispuestos en un protocolo acordado por los desarrolladores.
        """
        self.filesName = self.readStdin()
        self.processed = {}

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
            return a SongsProcessor object
            procesa los nombres de archivos existentes en filesName y crea un dict con la nomenclatura establecida.
        """
        songs = {"songs":[]}
        for i in self.filesName:
            songs["songs"].append(Song(i).toDict())
        self.processed = songs
        return self

    def printProcessed(self):
        """
            return a SongsProcessor
            imprime en la salida estandar el diccionario en processed
        """
        print(self.processed)

SongsProcessor().process().printProcessed()
