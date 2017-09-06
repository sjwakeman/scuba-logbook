Create a new table in the database to store the scuba dives.

Scuba Dives should have:
A dive number, date, location, total bottom time, bottom time this dive, accumulated time, PSI/BAR start, PSI/BAR end and dive comments (which can be written as one string containing all the notes).

Make sure you have a corresponding model for your dives.

In the dive_controller.rb, set up a controller action that will render a form to create a new dive. This controller action should create and save this new dive to the database.

Again in the dive_controller.rb, create a controller action that uses RESTful routes to display a single dive.

Create a third controller action that uses RESTful routes and renders a form to edit a single dive. This controller action should update the entry in the database with the changes, and then redirect to the dive show page.

Create a controller action (index action) that displays all the dives in the database.

Add to the dive show page a form that allows a user to delete a dive. This form should submit to a controller action that deletes the entry from the database and redirects to the index page.
