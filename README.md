# This is sharing app for csc444 course

App is running on Heroku, it will automatically update when you will push to git repository 

* link is - https://easy-share-team.herokuapp.com
* updated link - https://easy-share2.herokuapp.com/

To get this application running
* git clone this repository
* bundle install
* rails server

Models are tested using rspec.
* Run <code> rspec </code> to run the tests

Photo resize in the item index view uses mini_magick gem, but this gem need ImageMagick or GraphicsMagick command-line 
tool has to be installed. To check run

<code>$ convert -version</code>

On mac ImageMagick can be installed using

<code>$ brew install imagemagick </code>

