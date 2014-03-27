requirejs.config({
  baseUrl: '/assets',
  paths: {
    'text': 'text-2.0.10/text',
    'jquery': 'jquery-2.1.0',
    'knockout': 'knockout-3.1.0',
    'durandal': 'durandal-2.0.1/js',
    'plugins': 'durandal-2.0.1/js/plugins',
    'transitions': 'durandal-2.0.1/js/transitions',
  }
});

define(['durandal/system', 'durandal/app', 'durandal/viewLocator'],  function (system, app, viewLocator) {
    //>>excludeStart("build", true);
    system.debug(true);
    //>>excludeEnd("build");

    app.title = 'Vibes';

    app.configurePlugins({
        router: true,
        dialog: true,
        widget: true
    });

    app.start().then(function() {
        //Replace 'viewmodels' in the moduleId with 'views' to locate the view.
        //Look for partial views in a 'views' folder in the root.
        viewLocator.useConvention();

        //Show the app by setting the root view model for our application with a transition.
        app.setRoot('viewmodels/shell');
    });

    console.log("GOT HERE!");
});
