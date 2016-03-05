####Almost Funded

Django 1.8 app featuring "Almost Funded" projects from Kickstarter, IndieGogo, GoFundMe.  

###Generating CSS with Bourbon

To add a template to a view, ensure proper directories are loaded in `settings.py` file.

Add a `static` folder to your `app` e.g. `campaigns/static`.

Follow these steps to install Bourbon for Non-Rails Apps:
```
gem install bourbon
cd campaigns/static
mkdir stylesheets # If doesn't exist, in this case it does
bourbon install
mkdir sass # If doesn't exist, in this case it does
mv bourbon sass/bourbon
sass --watch stylesheets/sass:stylesheets# Have Bourbon watch as create .scss file to generate .css files
vi main.scss # Start a .scss file
```
As resulting `.css` files are created can add them to templates. 

To find static assets and load in a template, in the template (e.g. `index.html`) use the `static` block:

```
{% load staticfiles %}

<link rel="stylesheet" type="text/css" href="{% static 'stylesheets/main.css' %}">
```

Tiles found from this [Bootstrap snippet](http://codepen.io/ace-subido/pen/ybxKJ).
