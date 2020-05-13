.. include:: ../../substitutions.rst

Form filtering - filter layer data based on field values
========================================================

Principle
---------

This tool displays a form in the left panel, based on some fields, and allow the users to search among the layer data with a variety of form inputs: combo boxes, checkboxes, text inputs with autocompletion, date selector with sliders between the min and max date, etc.

.. warning::
    It works only with **database** layers: PostgreSQL (recommended), Spatialite and GeoPackage.

Using SQL statements, Lizmap will query the data to retrieve:

* the total count of features for the current filter
* the unique values of some fields (for the Unique Values type for example)
* the minimum and maximum of the numeric fields or date fields
* the extent of the data for the current filter

Example
-------

You can see a video with an example: https://vimeo.com/331395259


Prerequisites
-------------

.. include:: ../../shared/wfs_layer.rst

Configuring the tool
--------------------

.. image:: /images/interface-add-form-filter.jpg
   :align: center

There is a new tab in the Lizmap plugin which lets you configure the filter inputs based on the layer fields. You can add one or more fields for one or more layer. If you add fields from 2 or more different layers, Lizmap Web Client will show a combo box to allow the user to choose the layer to filter. Selecting a layer will refresh the form and deactivate the current filter.

- You need to add a line in the plugin table for each field you need to add in the filter form. For each field, you need to configure some options:

    1. .. include:: ../../shared/add_layer.rst
    2. **Layer**: the source layer.
    3. **Title**: the title to give to the input, which will be displayed above the form input. For example "Choose a category" for a layer field called "category".
    4. **Type**: the type of the form input, among one of the following: **Text, Unique Values, Date, Numeric**.
    5. **Field**: the field name (in the database table). Only for the Text, Unique Values and Numeric types.
    6. **Min date**: the field containing the start date of your object (ex: "start_date" of an event). This is only needed for the **Date** type. If you have only one date field in your data, you should select it in the Min Date field.
    7. * **Max date**: the field containing the end date of your data. If you have 2 fields containing dates, one for the start date and another for the end date, you can differentiate them. If not, you need to use the same field name for **Min date** and **Max date**.
    8. * **Format**: the format of the **Unique values** type only. It can be **select**, which will show a combo box, or **checkboxes** which will show one checkbox for each distinct value. The distinct values are dynamically queried by Lizmap Web Client.
    9. **Splitter**: for the **Unique values** type only. Use if you want to split the field values by a separator. Ex: ``culture, environment`` can be split into ``culture`` and ``environment`` with the splitter **`, `**.

- .. include:: ../../shared/edit_layer.rst
- .. include:: ../../shared/remove_layer.rst
- .. include:: ../../shared/move_up_down_layer.rst

Description of the different form input types
---------------------------------------------

Text
____

This is the simplest type. With this type of input, the user will see a classical text input. You can type any text then validate. Autocompletion is enabled by default, which means Lizmap will retrieve the unique values for this field. This could be an option in the future if some datasets are too big and this autocompletion feature is too heavy.

The filter built will be like:

.. code-block:: sql

    "field" LIKE '%foo%'

Date
____

This input type will show a slider with 2 handles to allow to search between the two selected values. The two text inputs are also shown and can be used to manually set the min and max dates.

The date is "truncated" to a date (no time data such as hour, minutes or seconds yet).

The slider step is hard coded and equals to 86400 seconds, which means 1 day.

The filter built will be like:

.. code-block:: sql

    ( ( "field_date" >= '2017-04-23' OR  "field_date" >= '2017-04-23' ) AND ( "field_date" <= '2018-06-24' OR  "field_date" <= '2018-06-24' ) )

Numeric
_______

This input type will show a slider with 2 handles to allow to search between the two selected values. Two text inputs are also shown and can be used to manually set the min and max values.

The filter built will be like:

.. code-block:: sql

    ( ( "field" >= 100 ) AND ( "field_date" <= 200 ) )

Unique values
_____________

Lizmap will query the data to get the distinct values of the field. You can choose two different input types: **select** or **checkboxes**.

If you have specified a splitter text, for example **`, `**, Lizmap will find the unique values of the separated text values. For example the value of one feature ``culture, environment`` will be split into ``culture`` and ``environment`` with the splitter **`, `**. Selecting ``culture`` or ``environment`` in the form input will show this feature.

You can choose to show two different input types:

* **Combo box**: this type will show a combo box with the list of distinct values for the field. The user will be able to choose only one item among the values.
* **Checkboxes**: this type will show as many comboboxes as distinct values for the field. The data will be filtered with a ``UNION`` between checked items.

The filter built will be like:

.. code-block:: sql

    ( "field_thematique" LIKE '%Cuisine%'  OR "field_thematique" LIKE '%Ecocitoyen%'  )
