Create a new table in the database to store the scuba dives.

Scuba Dives should have:
A dive number, date, location, total bottom time, bottom time this dive, accumulated time, PSI/BAR start, PSI/BAR end and dive comments (which can be written as one string containing all the notes).

Make sure you have a corresponding model for your dives.

In the dive_controller.rb, set up a controller action that will render a form to create a new dive. This controller action should create and save this new dive to the database.

Again in the dive_controller.rb, create a controller action that uses RESTful routes to display a single dive.

Create a third controller action that uses RESTful routes and renders a form to edit a single dive. This controller action should update the entry in the database with the changes, and then redirect to the dive show page.

Create a controller action (index action) that displays all the dives in the database.

Add to the dive show page a form that allows a user to delete a dive. This form should submit to a controller action that deletes the entry from the database and redirects to the index page.

=====================================================================================

GEMFILE AND ENVIRONMENT.RB
This project is supported by Bundler and includes a Gemfile.
Run bundle install before getting started on the project.
As this project has quite a few files, an environment.rb is included that loads all the code in your project along with Bundler. You do not ever need to edit this file. When you see require_relative ../config/environment, that is how your environment and code are loaded.

MODELS
You'll need to create two models in app/models, one User model and one Dive. Both classes should inherit from ActiveRecord::Base.

MIGRATIONS
You'll need to create two migrations to create the users and the dives table.
Users should have a username, email, and password, and have many dives.
Dives should have content, belong to a user.

ASSOCIATIONS
You'll need to set up the relationship between users and tweets. Think about how the user interacts with the dives, what belongs to who?
HOME PAGE
You'll need a controller action to load the home page. You'll want to create a view that will eventually link to both a login page and signup page. The homepage should respond to a GET request to /.

CREATE DIVE
You'll need to create two controller actions, one to load the create dive form, and one to process the form submission. The dive should be created and saved to the database. The form should be loaded via a GET request to dives/create_dove and submitted via a POST to /dives.

SHOW DIVE
You'll need to create a controller action that displays the information for a single dive. You'll want the controller action respond to a GET request to /dives/:id.

EDIT DIVE
You'll need to create two controller actions to edit a dive: one to load the form to edit, and one to actually update the dive entry in the database. The form to edit a dive should be loaded via a GET request to /dives/:id/edit. The form should be submitted via a POST request to /dives/:id.
You'll want to create an edit link on the dive show page.

DELETE DIVE
You'll only need one controller action to delete a dive. The form to delete a dive should be found on the dive show page.
The delete form doesn't need to have any input fields, just a submit button.
The form to delete a dive should be submitted via a POST request to dives/:id/delete.

SIGN UP
You'll need to create two controller actions, one to display the user signup and one to process the form submission. The controller action that processes the form submission should create the user and save it to the database.
The form to sign up should be loaded via a GET request to /signup and submitted via a POST request to /signup.
The signup action should also log the user in and add the user_id to the sessions hash.
Make sure you add the Signup link to the home page.

LOG IN
You'll need two more controller actions to process logging in: one to display the form to log in and one to log add the user_id to the sessions hash.
The form to login should be loaded via a GET request to /login and submitted via a POST request to /login.

LOG OUT
You'll need to create a controller action to process a GET request to /logout to log out. The controller action should clear the session hash

PROTECTING THE VIEWS
You'll need to make sure that no one can create, read, edit or delete any dives.
You'll want to create two helper methods current_user and logged_in?. You'll want to use these helper methods to block content if a user is not logged in.
It's especially important that a user should not be able to edit or delete the dives created by a different user. A user can only modify their own dives.
