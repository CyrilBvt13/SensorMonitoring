API Microservice
=======

*Coded by Cyril Bouvart*

Description
-----------

This is a Python API microservice.

Setup
-----------

1. install python
2. download this repository
3. install the requirements of the repository ``pip install -r requirements.txt``
4. start a python interpreter inside of the folder
5. have fun

Quick Start
-----------

First set the project name:

.. code-block:: python

    project = "pigarden"
    
The database name and the api route will depend on that name. For exemple, with the name set here ``pigarden``, the database will be named ``pigarden.json`` and the route will be ``http://localhost:5000/pigarden``.

By default, the app will be served in local. To make it accessible to other devices, just change the ``host='0.0.0.0'`` to your IP adress :

.. code-block:: python

    app.run(host='0.0.0.0', debug=False)

You can also set the debug mode to ``True`` for a more verbose mode.

Once this is done, you can set the blueprint of the objects that you will store in the database. In this exemple, we want to store a timestamp, a temperature, a pressure level and a humidity level. 

.. code-block:: python

    pigarden_args.add_argument("timestamp", type=str, help="Timestamp is missing", required=True)
    pigarden_args.add_argument("temperature", type=int, help="Temperature is missing", required=True)
    pigarden_args.add_argument("pressure", type=int, help="Pressure is missing", required=True)
    pigarden_args.add_argument("humidity", type=int, help="Humidity is missing", required=True)
    
By default, the parser reads command-line arguments in as simple strings. However, quite often the command-line string should instead be interpreted as another type, such as a float or int. The type keyword for add_argument() allows any necessary type-checking and type conversions to be performed. For more informations, check `argparse <https://docs.python.org/3/library/argparse.html#type>`_ documentation.

At this point you should have your API microservice configurated. Now you can play with it as show in the ``test.py`` python example. This API allows you to make CRUD operations (create, read, update, delete) and store your datas in a TinyDB document oriented database. To learn more about this cutie check `argparse <https://tinydb.readthedocs.io/en/latest/>`_ documentation.

Let's give you an example in Python :

* To insert data :

.. code-block:: python

    response = requests.put("http://localhost:5000/<your_project_name>/, {json dictionnary})

* To get all datas :

.. code-block:: python

    response = requests.get("http://localhost:5000/<your_project_name>/)

* To get one data :

.. code-block:: python

    response = requests.get("http://localhost:5000/<your_project_name>/<id>)

* To update data :

.. code-block:: python

    response = requests.patch("http://localhost:5000/<your_project_name>/<id>, {json dictionnary})

* To delete data :

.. code-block:: python

    response = requests.delete("http://localhost:5000/<your_project_name>/<id>)

Note that this is a basic API for now! There is still a lot of improvements to do as authentication, errors handling, etc... this will came up in the next version!

Have fun!
