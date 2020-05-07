/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

import { initSortable } from '../plugins/init_sortable';
import Rails from '@rails/ujs'

// ----------------------------------------------------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------

// External imports
import "bootstrap";

// Internal imports, e.g:
// import { initSelect2 } from '../components/init_select2';

document.addEventListener('turbolinks:load', () => {
  require("channels")
  $(function () {
    $('[data-toggle="popover"]').popover()
  })
  initSortable();
  const btn = document.querySelector('#dice-btn')
  if (btn) {
    btn.addEventListener('click', (event) => {
      // document.querySelector('iframe').style.height = '350px'
      document.querySelector('iframe').classList.toggle('d-none')
    })
  }
  const copy = () => {
    var copyText = document.querySelector("#share-link");
    copyText.select();
    document.execCommand("copy");
  }

  const shareBtn = document.querySelector("#share-btn")
  if (shareBtn) {
    shareBtn.addEventListener("click", copy);
  }

  const cursorForm = document.getElementById('cursor_place')
  let cursorValue = document.getElementById('cursor_place_id')
  const numbers = document.querySelectorAll('.numeric')
  numbers.forEach((number) => {
    number.addEventListener('focus', (event) => {
      event.currentTarget.style.backgroundColor = 'pink'
      cursorValue.value = event.currentTarget.id
      Rails.fire(cursorForm,'submit')
    });
    number.addEventListener('blur', (event) => {
      event.currentTarget.style.backgroundColor = ''
      cursorValue.value = ''
      Rails.fire(cursorForm,'submit')
    });
  });
  // const submissions = document.querySelectorAll('.submission');
  // const lastMessage = submissions[submissions.length - 1];
  // if (lastMessage !== undefined) {
  //   lastMessage.scrollIntoView();
  // }
});

import "controllers"
