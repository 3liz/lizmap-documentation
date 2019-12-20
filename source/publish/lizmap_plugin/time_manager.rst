Time Manager - animation of temporal vector layers
==================================================

Principle
---------

You can create animations of your vectors, provided you have at least a layer with a column with a valid date/time.

A video tutorial is available here: https://vimeo.com/83845949. It shows all the steps to use the functionality.

Demonstration site: http://demo.lizmap.3liz.com/index.php/view/?repository=rep6

Configuring the tool
--------------------

You should select from the plugin:

* at least one layer with the date/time
* the column with the date/time
* the number and type of time units for each step of the animation
* the duration, in milliseconds, of each step (the default is to display each 10 days block for one second)
* one field to display as a label when hovering with the mouse over the objects
* optionally, an ID and a title for groups of objects.

When ready, your web application will display the symbol of a watch; clicking on it will open a small panel that will allow you to move between steps, or paly the entire animation. At startup, the application will load the entire table, so if you have thousands of objects you may need to wait for several seconds before the application is available.

.. note:: Several different formats for date/time are acceptable (those supported by the JavaScript library `DateJS`). You can check whether your format is supported by entering it in this page: http://www.datejs.com/
