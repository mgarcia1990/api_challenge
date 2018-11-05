# README

MDB api challenge endpoints notes and documentation

Quick notes:

* Both people & movies support all CRUD operations through standard RoR routes & conventions.

* Every model and controller action were properly tested using rspec framework.

* For time purposes user endpoints were not implemented.
  However, authentication is requried and tested, so in order to access MDB sensible endpoints a User and token must be created using rails console.

People extra endpoints:

* `POST` /movies. Requires movie ID and role name. This will add the corresponding movie to the person filmography under the specified role.

* `DELETE` /movies. Requires movie ID and role name. This will remove the corresponding movie from the person filmography as the specified role.

* `GET` /movies_as_actor_actress. Returns the full list of movies starring the given person.

* `GET` /movies_as_director. Returns the full list of movies directed by the given person.

* `GET` /movies_as_producer. Returns the full list of movies produced by the given person.

Movies extra endpoints:

* `POST` /crew. Requires person ID and role name. This will add the corresponding stuff member to the movie crew under the specified role.

* `DELETE` /crew. Requires person ID and role name. This will remove the corresponding stuff member from the movie crew as the specified role.

* `GET` /casting. Returns the full list people starring in this movie.

* `GET` /directors. Returns the full list of directors.

* `GET` /producers. Returns the full list of producers.

Used libraries notes:

* `Devise & Tiddle` Devise was selected for authenticating as it is one of the msot standard RoR libraries for this, and provides and easy a quick way to implement robust auth.Tiddle wasusedon top it to add token based authentication.

* `Blueprinter` It was selected due to being the lightest of AMS suggestions as AMS is currently being under major changes. In case of having to deal with more complex models, JB or Netflix FastJson would probably had been use.
