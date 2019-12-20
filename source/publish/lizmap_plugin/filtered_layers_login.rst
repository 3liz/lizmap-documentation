Filtered layer by user
======================

Principle
---------

Usually, the management of projects Lizmap access rights is via directory. Configuration is done in this case in the Lizmap Web Client administration interface. See :ref:`define-group-rights`. This will completely hide some projects based on user groups, but requires a directory and project management.

Instead, the filtering feature presented here allows you to publish a single project QGIS, and filter the data displayed on the map based on the logged in user. It is possible to filter only vector layers because Lizmap uses a column in the attribute table.

Filtering currently uses the ID of the user group connected to the Web application. He is active for all requests to the QGIS server, and thus concerns:

* the vector layers images displayed on the map
* the popups
* the *Locate by layer* feature lists. See :ref:`locate-by-layer`
* drop-down lists of *Editing forms* from *Value relation*. See :ref:`lizmap-config-edition`
* upcoming features (the attribute table display, search features, etc.)

A video tutorial is available at: https://vimeo.com/83966790

Configuring the tool
--------------------

To use data filtering tool in Lizmap Web Client, you must:

* use **QGIS 2 and above** on the server
* have **access to the administration interface** of Lizmap Web Client

Here are the detailed steps to configure this feature:

* **Knowing the identifiers of user groups** configured in the Lizmap Web Client administration interface. For this, you must go to the administration interface :menuselection:`SYSTEM --> Groups of users for rights`: ID appears in parentheses after the name of each group (under the title *Groups of new users*)
* In Lizmap Web Client administration, in the repository properties, be sure that *anonymous* and other relevant groups are not checked
  for *Always see complete layers data, even if filtered by login*. See :ref:`define-group-rights`.
* For all vector layers which is desired filter data, just add a text column that will hold the group ID for each line (not the name !!) who has the right to display this line.
   - *Fill this column* for each line of the attribute table with the identifier of the group who has the right to see the line (using the calculator, for example).
   - It is possible to set **all** as the value in some lines to disable the filter: All users will see the data from these lines.
   - If the value in this column for a row does not correspond to a user group, then the data will be displayed for no user.

* Add the layer in the table **Filter Data by User** located in the plugin Lizmap *Tools* tab:

   - *Select layer* from the dropdown list
   - Select the field that contains the *group identifier* for the layer
   - Add the layer in the list with the button *Add layer*
   - To remove a layer of the table, click on it and click the button *Delete the layer*

* **Disable the client cache and cache server** for all filtered layers. Otherwise, the data displayed will not be updated between each connection or user logout!
