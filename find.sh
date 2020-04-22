#Nombra los archivos existentes en Library usa pipeline
#para filtrarlos con grep y los transfiere a un proceso de python
ls -1 Library | grep $1 | python3 SearchProcessor.py $1