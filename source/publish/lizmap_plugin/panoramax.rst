.. include:: ../../substitutions.rst

.. _panoramax:

Panoramax — Street-level imagery
================================

.. contents::
   :depth: 3

Principle
---------

`Panoramax <https://panoramax.fr>`__ is a free and open-source alternative to share and browse street-level
pictures. Lizmap Web Client can display a Panoramax viewer next to the map, to browse the geolocated pictures
of a Panoramax instance.

The web browser of the user requests the pictures directly to the Panoramax instance. No configuration is needed on
QGIS Server.

Configuring the tool
--------------------

In the Lizmap plugin, open the :guilabel:`Panoramax` panel:

* Check :guilabel:`Enable Panoramax`.
* Choose the :guilabel:`Location` of the viewer in Lizmap Web Client: ``dock``, ``bottom-dock``, ``mini-dock`` or
  ``right-dock``.
* Optionally, set the :guilabel:`API URL` of the Panoramax instance to use. If empty, the public instance
  ``https://panoramax.openstreetmap.fr/api`` is used. A
  `list of Panoramax instances <https://explore.panoramax.fr/fr/instances>`_ is available.

Usage in Lizmap Web Client
--------------------------

When the :guilabel:`Panoramax` panel is opened:

* the coverage of the Panoramax instance is displayed on the map, as a ``Panoramax`` group in the legend,
* a click on the map displays the nearest picture in the viewer, and an arrow on the map shows the direction of the
  picture,
* the pictures can be filtered by date, by type (classic or 360°) and by account,
* the coverage can be styled by capture date,
* a link opens the current picture on the Panoramax website.
