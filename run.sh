#Encargado de ejecutar los procesos en el modelo, para el tratamiendo de los datos
# sintaxis sh run.sh -[OPTION] [ARG]
# -f    Inicia rutina para la busqueda, requiere argumento para la busqueda
#       Nombra los archivos existentes en Library usa pipeline       
#       para filtrarlos con grep y los transfiere a un proceso de python
#
# -a    Imprime todos los nombres de los albumes en un formato JSON como una cadena.
#       no requiere argumentos adicionales

# -A    Imprime todos los nombres de los artistas en un formato JSON como una cadena.
#       no requiere argumentos adicionales

# -s    Imprime un cadena en formato JSON que contiene todas las canciones existentes.
#       no requiere argumentos

# -g    Devuelve la linea cual corresponda con un usuario, requiere un argumento que
#       corresponda con el nombre de usuario, esta debe ser una RegEx que tome en cuenta el
#       formato csv.

# -r    Concatena una linea de texto que representa la información de un nuevo 
#       usuario a el archivo que guarda tales datos. Requiere como parametro adicional 
#       el nombre de usuario y la contraseña separadas por una coma i.e.: user@example.com,password




getopts ":f:aAsg:r:" optname
    case "$optname" in
        "f")
            ls -1R Library/ | grep $OPTARG | python3 SearchProcessor.py $OPTARG
        ;;
        "a")
            ls -1R Library/ | python3 AlbumsProcessor.py
        ;;
        "A")
            ls -1R Library/ | python ArtistsProcessor.py
        ;;
        "s")
            ls -1R Library | python3 SongsProcessor.py 
        ;;
        "g")
            grep $OPTARG users.csv
        ;;
        "r")
            echo $OPTARG >> users.csv
        ;;
      "?")
        echo "No handled option $OPTARG"
        ;;
      ":")
        echo "Missing argument $OPTARG"
        ;;
      *)
        echo "Unknowing error ocurred"
        ;;
    esac