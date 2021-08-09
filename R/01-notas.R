> 2 Ejercicio usando usethis, here y postcards

> Instructoras: Elisa Márquez Zavala, Citlali Gil Aguillon

>Contenido adaptado del Curso de RNASeq de Leonardo Collado Torres

>2.1 here

>Este paquete es bastante útil

>El directorio que toma como base será en el que nos encontremos al momento de cargar el paquete here, heuristicamente busca la raíz del proyecto y se posiciona en él.

# se descargó previamente, así que solo se carga
library("here") # busca la raiz del proyecto en el que se encuentre

>En ciertas ocasiones puede haber algun error, ya que puede chocar con otros paquetes (como plyr). para evitar esto podemos usar here::here (que básicamente aclara que la función solicitada es del paquete here)

here::here()

>Podemos checar en qué directorio nos encontramos con getwd(), si no es el que deseamos podemos cambiarlo con setwd()

getwd() # regresa la path en donde nos encontramos
setwd("direccion/deseada") # nos lleva a la path indicada

#####Pero con here podemos no especificar la path

getwd() # para checar en donde nos encontramos
here::here() # para checar dónde te encuentras

# nos movemos al subdirectorio R
setwd(here::here("R")) # podemos cambiar de directorio, aun así `here está en la raíz
A continuación ofrecemos algunos ejemplos de cómo podría emplearse here::here

# como ejemplo: vamos a guardar datos en archivo y cargarlos
a <- 1
c <- 23
save(a, c, file = here::here("datos-prueba.RData"))
# rm(a,c)
load(here::here("datos-prueba.RData"))

# creamos un directorio
dir.create(here::here("subdirectorio"), showWarnings = FALSE)
# podemos crear un archivo, indicando el subdirectorio, (en este caso el primer argumento)
file.create(here::here("subdirectorio", "nombrearchivo"))
# abrimos el nuevo archivo creado
file.show(here::here("subdirectorio", "nombrearchivo")) # podemos editarlo!!

# por ejemplo si quisieramos ver nuestros archivos del directorio
list.files(here::here(), recursive = TRUE)


> 2.2 usethis

>usethis puede ser más amigable, por ejemplo para la creación de nuevos archivos .R es capaz de agruparlos en la carpeta R (dando un orden al proyecto)

usethis::use_r("notas-prueba.R") # no importando en qué path estemos

>En el siguiente ejercicio veremos algunos usos de usethis

>2.3 Vinculando RStudio con Git y GitHub

>Ahora vamos a vincular nuestro proyecto de Rstudio con Github, esto es muy util para tener un control de nuestros archivos, poder compartirlos o usar el de otrxs

>2.3.1 Prerrequisitos

>Debemos tener una cuenta de Github. Si no tienes este es el momento para crear una cuenta!

>https://docs.github.com/es/github/getting-started-with-github/signing-up-for-github/signing-up-for-a-new-github-account
También debemos instalar git en nuestras computadoras ya que el paquete gitcreds lo requiere

>https://git-scm.com/book/en/v2/Getting-Started-Installing-Git
Y la instalación de los siguientes paquetes:

  # paquetes que vamos a requerir
  install.packages("gitcreds", "gert", "gh")

library("gitcreds", "gert", "gh")


>2.3.2 Creando token de acceso personal (PAT)

>Para conectar nuestro repositorio de Rstudio con Github solicitamos un token, esto para que github otorgue permiso a nuestra computadora

>Emplearemos el siguiente bloque de código para solicitar dicho token (elige un nombre significativo)

>Otra manera de solicitar el token es ingresando a https://github.com/settings/tokens, esta opción no dará una recomendación de los parámetros a seleccionar

>El parámetro de expiración del token puede cambiarse para que no expire (por seguridad no lo recomienda Github), de otra manera considera su tiempo de vigencia

>Una vez generado el token debes guardarlo, pues no volverá a aparecer.

>Siempre puedes volver a generar uno nuevo (no olvides borrar el token anterior)

# Para iniciar conexión con GitHub
usethis::create_github_token() # redirige a github donde eligiras nombre especifico del token
# copia el token para después ingresarlo con gitcreds_set()
gitcreds::gitcreds_set() # aquí colocas el token (NO tu contraseña de github!!!)  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

>El siguiente paso será configurar nuestro usuario de github en el archivo .gitconfig

# Configurar usuario de gitHub
usethis::edit_git_config() # que abre el archivo .gitconfig
# colocaremos nombre y correo de cuenta de github. SOLO borrar los # y respetar los demas espacios
# [user]
#   name = N O M B R E
#   email = correodeGithub
# Lo tenemos que guardar y cerrar y luego nos vamos a session y le ponemos restart R

>2.3.3 Inicializar repositorio de Git y Github

>Ahora vamos a inicializar el repositorio en Git (de manera local en tu computadora) y enseguida solicitamos que se conecte con los servidores de Github

# inicializar el repositorio de Git
usethis::use_git() #

# conectar tu repositorio local de Git con los servidores de GitHub
usethis::use_github()
Git es el software mientras que GitHub es la plataforma web (basada en Git) que permite la colaboración

>LISTO!!

>  Comando útil para checar configuración

gh::gh_whoami() # para checar cómo quedó la configuración

>2.3.4 Probar otros comandos de gert

>Una vez que ya vinculamos nuestro repositorio con github podemos seguir actualizandolo. Vamos a checar brevemente algunos de los comandos que son útiles para ello:

>  Checaremos git_add, git_commit, git_log y git_push

# escribimos un nuevo archivo e indicamos dónde lo queremos
writeLines("hola", "R/prueba.R")
# también podemos hacerlo así
usethis::use_r("archivo-prueba-github.R") # añade archivo al directorio R del proyecto actual

# Por ejemplo podríamos probar añadir algo nuevo
gert::git_add("R/archivo-prueba-github.R")

# añadimos commit de lo que se hizo
gert::git_commit("se subio archivo prueba")

# nos da info de los commits
gert::git_log()

# sube tus cambios del repo local a los de github
gert::git_push() # COMANDO IMPORTANTE

>Puede ser más amigable usar el recuadro de Git que aparece en RStudio para hacer todo lo anterior!

>  2.4 Ejercicio postcards

>Similar a https://pages.github.com/
>  postcards tiene 4 templados de páginas web https://github.com/seankross/postcards
>Tu página web debe describir decir algo sobre ti, tus intereses, y tus proyectos además de cómo contactarte
>Ejemplo https://amy-peterson.github.io/ vía https://github.com/amy-peterson/amy-peterson.github.com
>http://jtleek.com/ vía https://github.com/jtleek/jtleek.github.io
>http://aejaffe.com/ vía https://github.com/andrewejaffe/andrewejaffe.github.io



