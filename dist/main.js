/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, {
/******/ 				configurable: false,
/******/ 				enumerable: true,
/******/ 				get: getter
/******/ 			});
/******/ 		}
/******/ 	};
/******/
/******/ 	// define __esModule on exports
/******/ 	__webpack_require__.r = function(exports) {
/******/ 		Object.defineProperty(exports, '__esModule', { value: true });
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";
/******/
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = "./public/src/index.js");
/******/ })
/************************************************************************/
/******/ ({

/***/ "./public/src/index.js":
/*!*****************************!*\
  !*** ./public/src/index.js ***!
  \*****************************/
/*! no static exports found */
/***/ (function(module, exports) {

eval("var CalendarEventsIndexPage = {\n  template: \"#calendar_events-index-page\",\n  data: function() {\n    return {\n      calendar_events: []\n    };\n  },\n  created: function() {\n    axios.get(\"/calendar_events\")\n      .then(function(response) {\n        this.calendar_events = response.data;\n      }.bind(this));\n  },\n  methods: {},\n  computed: {}\n};\n\nvar CalendarEventsNewPage = {\n  template: \"#calendar_events-new-page\",\n  data: function() {\n    return {\n      name: \"\",\n      eventTime: \"\",\n      eventDate: \"\",\n      location: \"\",\n      home: \"\",\n      category: \"\",\n      errors: []\n    };\n  },\n  methods: {\n    submit: function() {\n      var params = {\n        name: this.name,\n        event_date: this.eventDate,\n        event_time: this.eventTime,\n        location: this.location,\n        home: this.home,\n        forecast: this.forecast,\n        category: this.category\n\n      };\n      axios\n        .post(\"/calendar_events\", params)\n        .then(function(response) {\n          router.push(\"/\");\n        })\n        .catch(\n          function(error) {\n            this.errors = error.response.data.errors;\n            router.push(\"/login\");\n          }.bind(this)\n        );\n    }\n  }\n};\n\nvar CalendarEventsShowPage = {\n  template: \"#calendar_event-show-page\",\n  data: function() {\n    return {\n       calendar_event: {\n          id: \"\", \n          name: \"\",\n          pretty_event_date: \"\",\n          pretty_event_time: \"\",\n          location: \"\",\n          home: \"\",\n          category: \"\"\n        }\n    };\n  },\n  created: function() {\n    axios.get(\"/calendar_events/\" + this.$route.params.id)\n      .then(function(response) {\n        this.calendar_event = response.data;\n      }.bind(this));\n  },\n  methods: {},\n  computed: {}\n};\n\nvar ProductsEditPage = {\n  template: \"#calendar_events-edit-page\",\n  data: function() {\n    return {\n      name: \"\",\n      date: \"\",\n      time: \"\",\n      location: \"\",\n      home: \"\",\n      category: \"\",\n      errors: []\n    };\n  },\n  created: function() {\n    axios\n      .get(\"/calendar_events/\" + this.$route.params.id)\n      .then(function(response) {\n        console.log(response.data);\n        var calendar_event = response.data;\n        this.name = calendar_event.name\n        this.date = calendar_event.event_date\n        this.time = calendar_event.event_time\n        this.location = calendar_event.location\n        this.home = calendar_event.home\n        this.category = calendar_event.category\n      }.bind(this));\n  },\n  methods: {\n    submit: function() {\n      var params = {\n        name: this.name,\n        event_date: this.date,\n        event_time: this.time,\n        location: this.location,\n        home: this.home,\n        category: this.category\n      };\n      axios\n        .patch(\"/calendar_events/\" + this.$route.params.id, params)\n        .then(function(response) {\n          router.push(\"/calendar_events/\" + response.data.id);\n        }.bind(this))\n        .catch(\n          function(error) {\n            this.errors = error.response.data.errors;\n            router.push(\"/login\");\n          }.bind(this)\n        );\n    }\n  }\n};\n\nvar SignupPage = {\n  template: \"#signup-page\",\n  data: function() {\n    return {\n      name: \"\",\n      email: \"\",\n      password: \"\",\n      passwordConfirmation: \"\",\n      errors: []\n    };\n  },\n  methods: {\n    submit: function() {\n      var params = {\n        name: this.name,\n        email: this.email,\n        password: this.password,\n        password_confirmation: this.passwordConfirmation\n      };\n      axios\n        .post(\"/users\", params)\n        .then(function(response) {\n          router.push(\"/login\");\n        })\n        .catch(\n          function(error) {\n            this.errors = error.response.data.errors;\n          }.bind(this)\n        );\n    }\n  }\n};\n\nvar LoginPage = {\n  template: \"#login-page\",\n  data: function() {\n    return {\n      email: \"\",\n      password: \"\",\n      errors: []\n    };\n  },\n  methods: {\n    submit: function() {\n      var params = {\n        auth: { email: this.email, password: this.password }\n      };\n      axios\n        .post(\"/user_token\", params)\n        .then(function(response) {\n          axios.defaults.headers.common[\"Authorization\"] =\n            \"Bearer \" + response.data.jwt;\n          localStorage.setItem(\"jwt\", response.data.jwt);\n          router.push(\"/\");\n        })\n        .catch(\n          function(error) {\n            this.errors = [\"Invalid email or password.\"];\n            this.email = \"\";\n            this.password = \"\";\n          }.bind(this)\n        );\n    }\n  }\n};\n\nvar LogoutPage = {\n  created: function() {\n    axios.defaults.headers.common[\"Authorization\"] = undefined;\n    localStorage.removeItem(\"jwt\");\n    router.push(\"/\");\n  }\n};\n\n\nvar router = new VueRouter({\n  routes: [\n        { path: \"/\", component: CalendarEventsIndexPage },\n        { path: \"/calendar_events\", component: CalendarEventsIndexPage },\n        { path: \"/calendar_events/new\", component: CalendarEventsNewPage},\n        { path: \"/calendar_events/:id\", component: CalendarEventsShowPage },\n        { path: \"/signup\", component: SignupPage },\n        { path: \"/login\", component: LoginPage },\n        { path: \"/logout\", component: LogoutPage }\n\n        ],\n  scrollBehavior: function(to, from, savedPosition) {\n    return { x: 0, y: 0 };\n  }\n});\n\nvar app = new Vue({\n  el: \"#vue-app\",\n  router: router,\n  created: function() {\n    var jwt = localStorage.getItem(\"jwt\");\n    if (jwt) {\n      axios.defaults.headers.common[\"Authorization\"] = jwt;\n    }\n  }\n});\n\n\n//# sourceURL=webpack:///./public/src/index.js?");

/***/ })

/******/ });