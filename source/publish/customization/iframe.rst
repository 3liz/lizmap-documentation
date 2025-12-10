Iframe
======

.. contents::
   :depth: 3

Principle
---------

It's possible to embed Lizmap in another webpage by using a iframe. We suggest you to change the view ``map`` by
``embed`` in the URL to have lighter version of the interface.

For instance, use this URL : ``/index.php/view/embed/?repository=my_repo&project=my_project``.

Configuration
-------------

To prevent security issues, you need to explicitly declare websites allowed to embed your Lizmap iframe.
Fill the :guilabel:`List of websites allowed to embed iframe` field that can be defined for each the repository in :guilabel:`Maps management`.

.. warning::

   Ensure the ``referrer`` is provided to the iframe (you can use the ``referrerpolicy`` attribute : ``<iframe src="....." referrerpolicy="strict-origin-when-cross-origin" ></iframe>`` )

Example
-------

You can visit both links to see the difference :

* https://demo.lizmap.com/lizmap/index.php/view/map?repository=javascript&project=lampadaires
* https://demo.lizmap.com/lizmap/index.php/view/embed/?repository=javascript&project=lampadaires
