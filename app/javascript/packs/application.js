// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
import jQuery from 'jquery';
window.jQuery = jQuery;
window.$ = jQuery;

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import 'jquery'//スライドショーの追加
import "script.js"//スライドショーの追加
import Swiper from 'swiper/swiper-bundle.js';//スライドショーの追加
import 'swiper/swiper-bundle.css';//スライドショーの追加


import "popper.js";
import "bootstrap";
import "../stylesheets/application";

//= require jquery
//= require rails-ujs

Rails.start()
Turbolinks.start()
ActiveStorage.start()

