# Fair Catch

Juego donde el objetivo es conseguir el máximo número de puntos capturando peces. Las capturas afectan al equilibrio del ecosistema, lo que hace que determinadas ocasiones sea conveniente capturar una especie, devolverla al mar o capturar otra.

## Mecánica del juego

Si un animal no come en un cierto tiempo, muere de hambre.

El mar está dividido verticalmente en tres zonas:
* Zona alta
* Zona media
* Zona baja

### Tipos de peces

* **Tiburones**: comen pulpos, peces carnívoros y nuestras capturas. 0 puntos. Solo existen de tamaño 3. Máximo uno en pantalla. Aparece de la nada. Pueden moverse por todas las zonas. 
* **Lubinas**: Inicialmente hay 2 de tamaño 1 y 2 de tamaño 2. Tienen 4 crías. Se mueven por todas las zonas.
* **Sardinas**: Inicialmente hay 2 de tamaño 1, 2 de tamaño 2 y 2 de tamaño 3. Tienen 5 crías. Crecen rápido. Se mueven solo en la zona alta.
* **Pulpos**: comen nécoras. Inicialmente hay 2 de tamaño 2. Tienen 3 crías. Dan bastantes puntos. Al posarse, las algas se levantan del fondo para volver a caer poco a poco. Se mueven solo en la zona baja.
* **Nécoras**. Inicialmente hay 1 de tamaño 1, 1 de tamaño 2 y 1 de tamaño 3. Tienen 3 crías. Crecen despacion. Se mueven a ras de suelo.
* **Algas**. Solo hay un tamaño. Se reproducen de forma asexual, tienen un único tamaño y no mueren ni por edad ni al reproducirse. Están en posiciones fijas reflejadas en dos arrays: uno para el suelo y otro para el poste del muelle (zona alta). Tras cierto tiempo, pueden tener un alga hija aleatoriamente en una de sus posiciones adyacentes. Inicialmente hay 6 en la zona inferior y 3 en el poste.


## Entorno de Desarrollo

Para colaborar en el proyecto:

1. Instala [Love Game Framework](https://love2d.org/)
2. Clona este repositorio
3. Abre la carpeta "src" en Visual Studio Code

### Configuración de Visual Studio Code

Extensiones de utilidad:
* [LOVE](https://marketplace.visualstudio.com/items?itemName=bschulte.love)
* [Local Lua Debugger](https://marketplace.visualstudio.com/items?itemName=tomblind.local-lua-debugger-vscode)

## Enlaces de Interés

* [Documentación LÖVE Game Framework](https://love2d.org/wiki/Main_Page)
* [Markdown Basic Syntax](https://www.markdownguide.org/basic-syntax)
* [How to Write Better Git Commit Messages](https://www.freecodecamp.org/news/how-to-write-better-git-commit-messages/)

## Misc

* [Learn Lua in 15 Minutes](https://tylerneylon.com/a/learn-lua)
* [Paleta Woodspak](https://lospec.com/palette-list/woodspark)
* [Paleta Urbex 16](https://lospec.com/palette-list/urbex-16)
* [Paleta Jobs H16DA](https://lospec.com/palette-list/h16da)
* [Paleta Jobs Darkseed 16](https://lospec.com/palette-list/darkseed-16)
