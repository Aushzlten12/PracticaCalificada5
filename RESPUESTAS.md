# Practica Calificada 5

## Primer Grupo de Preguntas

- **En las actividades relacionados a la Introducción de Rails los métodos actuales del controlador no son muy robustos: si el usuario introduce de manera manual un URI para ver (Show) una película que no existe (por ejemplo /movies/99999), verás un mensaje de excepción horrible. Modifica el método show del controlador para que, si se pide una película que no existe, el usuario sea redirigido a la vista Index con un mensaje más amigable explicando que no existe ninguna película con ese.**

```ruby
def show
  set_movie
end

def set_movie
  begin
  @movie = Movie.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:notice] = "La pelicula con el ID #{params[:id]} no ha sido creado"
    redirect_to action: 'index' 
  end
end
```

El método *show* usa un método privado *set_movie*, este método encuentra la pelicula cuyo ID se ingresa en el URI. Si no existe esa pelicula guarda un mensaje "amigable" y redirije a index.

- **En las actividades relacionados a Rails Avanzado, si tenemos el siguiente ejemplo de código que muestra cómo se integra OmniAuth en una aplicación Rails:**

Creando un metodo protected para obtener lo que se retorna usando 'onmiauth-auth'

```ruby
protected 
def auth_hash
  request.env['omniauth.auth']
end	
```
El cual retorna un valor que se usará tanto para crear o encontrar un usuario, pienso que `request.env['omniauth.auth']` esta en su propio método para manejar excepciones o posibles retornos de valores no esperados.

- **En las actividades relacionados a JavaScript, Siguiendo la estrategia del ejemplo de jQuery utiliza JavaScript para implementar un conjunto de casillas de verificación (checkboxes) para la página que muestra la lista de películas, una por cada calificación (G, PG, etcétera), que permitan que las películas correspondientes permanezcan en la lista cuando están marcadas. Cuando se carga la página por primera vez, deben estar marcadas todas; desmarcar alguna de ellas debe esconder las películas con la clasificación a la que haga referencia la casilla desactivada.**

Creo un archivo javascript para la verificacion de casillas marcadas.

```javascript
var VerificationCheck = {
  verificar_campos: function(){
    let g_check = $("#ratings_G");
    if (!g_check.is(":checked")) {
      $(".G").hide();
    }
    let pg_check = $("#ratings_PG");
    if (!pg_check.is(":checked")) {
      $(".PG").hide();
    }
    let pg13_check = $("#ratings_PG-13");
    if (!pg13_check.is(":checked")) {
      $(".PG-13").hide();
    }
    let r_check = $("#ratings_R");
    if (!r_check.is(":checked")) {
      $(".R").hide();
    }
  },
  setup: function () {
    $(document).on('submit', '#rating_submit', VerificationCheck.verificar_campos);
  },
};
$(VerificationCheck.setup);

```
Adicionalmente agrego clases como `P,G,PG-13,R` a cada fila para usar el metodo `hide` sino se ha marcado.

```
<div class="row <%=movie.rating%>">
  <div class="col-8"> <%= link_to movie.title, movie_path(movie), data: { method: 'get' } %> </div>
  <div class="col-2"> <%= movie.rating %></div>
  <div class="col-2"> <%= movie.release_date.strftime('%F') %> </div>
</div>
```

- **De la actividad relacionada a BDD e historias de usuario crea definiciones de pasos que te permitan escribir los siguientes pasos en un escenario de RottenPotatoes:**

```
Given the movie "Inception" exists
And it has 5 reviews
And its average review score is 3.5
```

En movie_steps 
```ruby
Given /the movie "(.*) exists"/ do |movietitle|
  @movie = Movie.find_by(title: movietitle)
end
```

## Segundo grupo de Preguntas

Para esta parte usaremos el repositorio de Introduccion a Rails. Contando con el archivo movie_steps.rb, web.steps.rb y los features `filster_movie_list` y `sort_movie_list`

En la primera ejecucion de `bundle exec cucumber` contamos con 14 eliminando los pending

```
4 scenarios (1 undefined, 3 passed)
14 steps (14 passed)
0m0.289s
```

1. **Completa el escenario restrict to movies with PG or R ratings in filter_movie_list.feature. Puedes utilizar las definiciones de pasos existentes en web_steps.rb para marcar y desmarcar las casillas correspondientes, enviar el formulario y comprobar si aparecen las películas correctas (y, lo que es igualmente importante, no aparecen las películas con clasificaciones no seleccionadas).**

