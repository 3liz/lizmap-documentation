
QGIS Expression
===============

As in QGIS Desktop, Lizmap can use `QGIS expression <https://docs.qgis.org/latest/en/docs/user_manual/working_with_vector/expression.html>`_ .

Project level
-------------

At the project level, Lizmap will set two variables in QGIS Server:

* ``@lizmap_user`` : *string*, the current user connected in Lizmap. It might be empty.
* ``@lizmap_user_groups`` : *array*, the current user groups as a list. It might be empty.

.. note::
    It's possible use these variables in a symbology for instance, to set a different color for a given user,
    or to print the current Lizmap user in a layout.

Advanced forms
--------------

For editing, it's possible to use expressions for constraints, default value, group visibility.
Read :ref:`edition-expressions`.

Layouts
-------

It's possible to use expressions in layouts, for dates, path of a Lizmap media.

In a layout, the expression ``map_credits`` or
`more complex expressions <https://docs.qgis.org/latest/en/docs/user_manual/print_composer/composer_items/composer_label.html#exploring-expressions-in-a-label-item>`_
are useful.
