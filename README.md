A builder that generates classes to convert objects to key-value maps and vise versa 

e.g. for:
* JSON conversions
* YAML conversions 
* Key-value databases

This package was inspired by: json_serializable

Believing that:
The domain layer should have no direct dependencies with specific technologies 
such as frameworks, user interfaces, web services or databases, so that:
* The domain layer is not soiled with outer layer responsibilities
* The domain layer is easy to test
* The technology in the outside layers are relatively easy to change out with a different technology.

Therefore this package:
* Does not use annotations in the domain class. 
  (TODO explain how configuration is done)
* Generates map converter functions inside separate dart file 
  (no .g.dart files that need to be added as part of a domain class file). 
  The destination of the generated files can be configures. 
  (TODO explain how configuration is done) 

Examples:
TODO link to examples

