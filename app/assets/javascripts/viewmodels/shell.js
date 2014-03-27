define(['plugins/router', 'durandal/app'], function (router, app) {
  return {
    router: router,
    activate: function () {
      router.map([
          { route: '',     moduleId: 'viewmodels/idea_list', nav: true },
          { route: 'idea', moduleId: 'viewmodels/idea',      nav: true },
        ]).buildNavigationModel();

        return router.activate();
    },
  };
});
