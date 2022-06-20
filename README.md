primero creamos una carpeta con el nombre del proyecto

luego instalo un entorno virtual atraves del comando

```virtualenv -p python3 env```

y lo activamos 

```./env/scripts/activate```

luego instalamos Django

```pip install django```

e iniciamos un nuevo proyecto 

```django-admin startproject django_tailwind_htmx```

nos metemos en la carpeta del proyecto

```cd django_tailwind_htmx```

iniciamos una nueva app llamada core

```python manage.py startapp core```

inicialisamos el git

```git init```

nos metemos a  www.gitignore.io seleccionamos django y creamos el archvio para pegarlo en el archivo .gitignore 

iniciamos la instalacion via npm de tailwind

```npm install -D tailwindcss postcss postcss-cli autoprefixer```

ya que acavo la instalacion lo inicialisamos con 

```npx tailwindcss init```

ahroa abrimos el proyecto en viual studio 

```code .```

y dentro en el archivo tailwind.config.js ponemos esto para indicarle que todo lo html dentro de la carpeta de core usara tailwind

```
module.exports = {

 content: ['./core/templates/core/*.html'],

 theme: {

 extend: {},

 },

 plugins: [],

}
``` 

luego creamos un archivo llamado postcss.config.js y le ponemos esto 

```
module.exports = {

 plugins: {

 tailwindcss: {},

 autoprefixer: {}

 }

}
```
 
 luego creamos en la carpeta raiz el archivo "static/css/main.css" y dentro del el ponemos lo siguiente:
 
```
@tailwind base;

@tailwind components;

@tailwind utilities;
```

luego en el archivo package.json agregamos el siguiente script

```
"scripts": {

 "build": "postcss static/css/main.css -o static/css/main.main.css"

 }
```

ya con esto configurado corremos el comando en la terminal

```npm run build```

esto creara un archivo llamado main.main.css en la carpeta especidicada arriba en el script ("static\css")

y nos saldra algo asi, ya que no tenemos creado ningun template

![Pasted image 20220607200327](https://user-images.githubusercontent.com/93227096/172950249-412b61df-2c5b-4be8-add3-9c1e3e67bebb.png)


luego en /core/views.py agregamos una vista para poder usar index.html

```
from urllib import request

from django.shortcuts import render

  

def index(reques):

 return render(request, 'core/index.html')
```

hecho esto ahora devemos reflejarlo en  en "django_tailwind_htmx/urls.py" agregandolo en los "path"

```
from django.contrib import admin

from django.urls import path

  

from core.views import index

  

urlpatterns = [

 path('', index, name='index'),

 path('admin/', admin.site.urls),

]
```

ahora en sjango_tailwind_htmx/settings.py declaramos en INSTALLED_APPS  nuestra aplicacion 'core', asi

![Pasted image 20220607213331](https://user-images.githubusercontent.com/93227096/172950394-fd9e1eed-0e58-49d6-bcdb-2c953be0e68c.png)


corremos el servidor 
```python manage.py runserver```

nos aparecera un error ya que no tenemos el template creado de index.html, asi que lo creamos en "core/templates/core/index.html"

![Pasted image 20220607213839](https://user-images.githubusercontent.com/93227096/172950414-5fe32508-1d03-4e93-a277-f3eb48adec05.png)


ahora en ese archivo creamos un documento html normalito solo agregando tambien 
```{% load static %}```
al principio del documento
y en `<head>` ponerlo siguiente para mandar a llamar el ccs
```
<link rel="stylesheet" href="{% static 'css/main.min.css' %}">
```

![Pasted image 20220607214350](https://user-images.githubusercontent.com/93227096/172950428-a2547d6a-ecf8-45cc-a456-0721af6aac58.png)


ya agregado esto ahora si podemos parar el servidor y volver a correr el comando
```npm run build```

(aqui esta al final agregado el color azul)
![Pasted image 20220607215313](https://user-images.githubusercontent.com/93227096/172950484-d4c42f61-6d4c-42fd-a627-b6818df960d3.png)


ya creado nuevamente el css de solo lo que ocupamos y volvemops a iniciar el servidor

![Pasted image 20220607215018](https://user-images.githubusercontent.com/93227096/172950505-e3daa776-1876-4b23-83f4-cf400cbf1aa8.png)


ahora solo tenemos que ir a django_tailwind_htmx/settings.py y en la parte de abajo declarar que durectorio de 'static' vamos a usar

```
STATICFILES_DIRS = [

    BASE_DIR / 'static'

]
```

salvamos y ahora si recragamos el indice y podemos ver que ya toma todo el CSS en la consola de Chrome

![Pasted image 20220608142836](https://user-images.githubusercontent.com/93227096/172950530-52e08358-e2ff-4185-a476-7cb107e0ba50.png)


ahora instalaremos el srript watch para que cda que modifiquemos el archivo index.html se reescriba automaticamente el css, 

y en el archivo package.json añadimos este script
```
{

  "watch": {

    "build": ["core/templates/core/*.html"]

  },

  "scripts": {

    "build": "postcss static/css/main.css -o static/css/main.min.css",

    "watch": "npm-watch"

  },

  "devDependencies": {

    "autoprefixer": "^10.4.7",

    "postcss": "^8.4.14",

    "postcss-cli": "^9.1.0",

    "tailwindcss": "^3.0.24"

  },

  "dependencies": {

    "npm-watch": "^0.11.0"

  }

}
```

luego lo ejecutamos en la consola el siguiente comando
```npm install npm-watch```
![Pasted image 20220608164340](https://user-images.githubusercontent.com/93227096/172950563-3dfefffa-aa87-4848-936a-bf022854415e.png)


y en la terminal donde estamos corriendo el runserver la dividimos y corremos el script con el comando 
```npm run watch```
![Pasted image 20220608165116](https://user-images.githubusercontent.com/93227096/172950577-3f275608-bf26-4634-afa7-fd6500892611.png)


ahora podemos ir al archivo index.html y modificar el ccs a rojo
![Pasted image 20220608170714](https://user-images.githubusercontent.com/93227096/172950593-0cfec33b-7f3d-4425-90cf-2f3d04f2e0e2.png)


y al actualizar la pagina nos dara como resultado que se cambio a rojo automaticamente

![Pasted image 20220608170517](https://user-images.githubusercontent.com/93227096/172950611-7c3d2b6d-6a54-4920-b981-f69f5188a568.png)


ahora instalamos el siguiente comando en la terminal 
```npm install htmx.org```
y actualizamos el script de 'build' y 'watch' en /package.json para que queden de la siguiente manera
```
  "scripts": {

    "prebuild": "postcss static/css/main.css -o static/css/main.min.css",

    "build": "copy \"node_modules\\htmx.org\\dist\\htmx.min.js\" \"C:\\Users\\folkh\\Desktop\\Proyectos\\Django Htmx and Tailwind\\django_tailwind_htmx\\static\\js\\\"",

    "watch": "npm-watch"

  },
```

ahora en una terminal aparte dejamos corriendo el comando
```python manage.py runserver```
y en otra el comando 
```npm run watch```
para que quede escuchando a la espera de cualquier cambio en el CSS y o JS

![Pasted image 20220609155718](https://user-images.githubusercontent.com/93227096/172950791-4e9cb0a0-e24c-4367-9838-031e610808a0.png)


si hacemos cualquier cambio en el index automaticamente lo agregara a nuestros archivos de css y js

aqui añadimos varios colores de tailwind y al momento de guardar corre automaticamente el script 'build'
![Pasted image 20220609155929](https://user-images.githubusercontent.com/93227096/172950634-b230b5d2-cf54-4a03-b688-f83930dd0948.png)

![Pasted image 20220609160023](https://user-images.githubusercontent.com/93227096/172950646-97ac10e6-9367-460f-ac9c-3471287fb57d.png)


por ultimo agregamos un script para que nos muestre el la interfas de administrador al dar click con las siguientes lineas en index.html

```
<div hx-get="/admin/" hx-swap="outerHTML">ADMIN</div>

<script src="{% static 'js/htmx.min.js' %}"></script>
```

de la misma forma al guardarlo nos agregara el js al archivo htmx.min.js al que apuntamos mediante el script

![Pasted image 20220609160550](https://user-images.githubusercontent.com/93227096/172950667-ef99f106-97b9-4cbd-b542-8ef7baeedcc9.png)


Y listo, eso fue todo
