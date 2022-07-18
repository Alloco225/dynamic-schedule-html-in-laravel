require('./bootstrap');


// Require Vue
window.Vue = require('vue').default;

// Register Vue Components
Vue.component('example-component', require('./components/ExampleComponent.vue').default);

Vue.component('app-estimation-component', require('./components/AppEstimation.vue').default);

// Initialize Vue
const appEstimation = new Vue({
    el: "#vue-app",
});
