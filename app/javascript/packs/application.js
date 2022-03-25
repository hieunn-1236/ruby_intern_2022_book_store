// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
console.log('Hello from application.js')
require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")
import "@fortawesome/fontawesome-free/css/all.css";
import "bootstrap"
import "../stylesheets/application"
require("packs/show_product.js")
require("@nathanvda/cocoon")
require("jquery")
require("packs/select2setup")
global.toastr = require("toastr")
import JQuery from "jquery";
window.$ = window.JQuery = JQuery;
// require("packs/bootstrap.js")
// require("packs/product.js")
// require("packs/sb-admin-2.min.js")
// require("custom.js")
// require("ion.rangeSlider.min.js")
// require("jquery-3.4.1.min.js")
// require("datatables-demo.js")
// require("bootstrap.bundle.min.js")
// require("jquery.easing.min.js")
// require("jquery.dataTables.min.js")
// require("dataTables.bootstrap4.min.js")
// require("packs/jquery.min.js")
// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
//= require jquery
//= require bootstrap
//= require jquery_ujs
//= require turbolinks
//= require_tree .
