.. include:: ../../substitutions.rst

QGIS Expression
===============

As in QGIS Desktop, Lizmap can use `QGIS expression <https://docs.qgis.org/latest/en/docs/user_manual/working_with_vector/expression.html>`_ .

Project level
-------------

At the project level, Lizmap will set two variables :

* ``lizmap_user`` : the current user connected in Lizmap otherwise a empty string
* ``lizmap_user_groups`` : the current user groups as a list

.. note::
    It's possible use these variables in a symbology for instance, to set a different color for a given user.

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
