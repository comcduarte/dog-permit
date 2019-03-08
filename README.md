# Dog Permit Application
## Installation
- Add required Sub Modules to project.  These include Midnet, Dog, Annotation, and User.  Update modules.conf.php to indicate the additional modules.

```
return [
	'Application',
	'Midnet',
	'Dog',
	'Annotation',
	'User',
];
```

- Add additional submodules to autoload in composer.

```
"autoload" : {
		"psr-4" : {
			"Application\\" : "module/Application/src/",
			"Annotation\\" : "module/Annotation/src/",
			"Midnet\\" : "module/Midnet/src/",
			"Dog\\" : "module/Dog/src/",
			"User\\" : "module/User/src/"
		}
	},
```

## Prerequistes
* zend-db
* zend-form
* zend-paginator
* zend-crypt
* zend-authentication
* zend-session
* zend-I18n

