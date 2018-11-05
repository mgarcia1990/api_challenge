# README

MDB api challenge endpoints notes and documentation

Quick notes:

* Both people & movies support all CRUD operations through standard RoR routes & conventions.

* Every model and controller action were properly tested using rspec framework.

* For time purposes user endpoints were not implemented.

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
