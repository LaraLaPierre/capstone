

var CalendarEventsIndexPage = {
  template: "#calendar_events-index-page",
  data: function() {
    return {
      calendar_events: []
    };
  },
  created: function() {
    axios.get("/calendar_events")
      .then(function(response) {
        this.calendar_events = response.data;
      }.bind(this));
  },
  methods: {},
  computed: {}
};

var CalendarEventsNewPage = {
  template: "#calendar_events-new-page",
  data: function() {
    return {
      name: "",
      eventTime: "",
      eventDate: "",
      location: "",
      home: "",
      category: "",
      errors: []
    };
  },
  methods: {
    submit: function() {
      var params = {
        name: this.name,
        event_date: this.eventDate,
        event_time: this.eventTime,
        location: this.location,
        home: this.home,
        forecast: this.forecast,
        category: this.category

      };
      axios
        .post("/calendar_events", params)
        .then(function(response) {
          router.push("/");
        })
        .catch(
          function(error) {
            this.errors = error.response.data.errors;
            router.push("/login");
          }.bind(this)
        );
    }
  }
};

var CalendarEventsShowPage = {
  template: "#calendar_event-show-page",
  data: function() {
    return {
       calendar_event: {
          id: "", 
          name: "",
          pretty_event_date: "",
          pretty_event_time: "",
          location: "",
          home: "",
          category: ""
        }
    };
  },
  created: function() {
    axios.get("/calendar_events/" + "?date=" + app.selectedDate)
      .then(function(response) {
        this.calendar_event = response.data;
      }.bind(this));
  },
  methods: {},
  computed: {}
};

var CalendarEventsEditPage = {
  template: "#calendar_events-edit-page",
  data: function() {
    return {
        name: "",
        eventDate: "",
        eventTime: "",
        location: "",
        home: "",
        category: "",
        errors: []
      };
  },
  created: function() {
    axios
      .get("/calendar_events/" + this.$route.params.id)
      .then(function(response) {
        console.log(response.data);
        var calendar_event = response.data;
        this.name = calendar_event.name
        this.eventDate = calendar_event.event_date
        this.eventTime = calendar_event.event_time
        this.location = calendar_event.location
        this.home = calendar_event.home
        this.category = calendar_event.category
      }.bind(this));
  },
  methods: {
    submit: function() {
      var params = {
        name: this.name,
        event_date: this.eventDate,
        event_time: this.eventTime,
        location: this.location,
        home: this.home,
        category: this.category
      };
      axios
        .patch("/calendar_events/" + this.$route.params.id, params)
        .then(function(response) {
          router.push("/calendar_events/" + response.data.id);
        }.bind(this))
        .catch(
          function(error) {
            this.errors = error.response.data.errors;
            router.push("/login");
          }.bind(this)
        );
    }
  }
};

var CalendarEventsDestroyPage = {
  created: function() {
    axios.delete("/calendar_events/" + this.$route.params.id)
      .then(function(response) {
        router.push("/");
      });
  }
}

var SignupPage = {
  template: "#signup-page",
  data: function() {
    return {
      name: "",
      email: "",
      password: "",
      passwordConfirmation: "",
      errors: []
    };
  },
  methods: {
    submit: function() {
      var params = {
        name: this.name,
        email: this.email,
        password: this.password,
        password_confirmation: this.passwordConfirmation
      };
      axios
        .post("/users", params)
        .then(function(response) {
          router.push("/login");
        })
        .catch(
          function(error) {
            this.errors = error.response.data.errors;
          }.bind(this)
        );
    }
  }
};

var LoginPage = {
  template: "#login-page",
  data: function() {
    return {
      email: "",
      password: "",
      errors: []
    };
  },
  methods: {
    submit: function() {
      var params = {
        auth: { email: this.email, password: this.password }
      };
      axios
        .post("/user_token", params)
        .then(function(response) {
          axios.defaults.headers.common["Authorization"] =
            "Bearer " + response.data.jwt;
          localStorage.setItem("jwt", response.data.jwt);
          router.push("/");
        })
        .catch(
          function(error) {
            this.errors = ["Invalid email or password."];
            this.email = "";
            this.password = "";
          }.bind(this)
        );
    }
  }
};

var LogoutPage = {
  created: function() {
    axios.defaults.headers.common["Authorization"] = undefined;
    localStorage.removeItem("jwt");
    router.push("/");
  }
};


var router = new VueRouter({
  routes: [
        { path: "/", component: CalendarEventsIndexPage },
        { path: "/calendar_events", component: CalendarEventsIndexPage },
        { path: "/calendar_events/new", component: CalendarEventsNewPage},
        { path: "/calendar_events/:id", component: CalendarEventsShowPage },
        { path: '/calendar_events/:id/edit', component: CalendarEventsEditPage},
        { path: '/calendar_events/:id/delete', component: CalendarEventsDestroyPage },
        { path: "/signup", component: SignupPage },
        { path: "/login", component: LoginPage },
        { path: "/logout", component: LogoutPage }

        ],
  scrollBehavior: function(to, from, savedPosition) {
    return { x: 0, y: 0 };
  }
});

var app = new Vue({
  el: "#vue-app",
  router: router,
  data: {
    // Data used by the date picker
    mode: 'single',
    selectedDate: null,
  },
  created: function() {
    var jwt = localStorage.getItem("jwt");
    if (jwt) {
      axios.defaults.headers.common["Authorization"] = jwt;
    }
  }
});