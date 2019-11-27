import $ from 'jquery';

// active nav
const activeLink = () => {
  // get current url path name
  const slug = window.location.pathname;
  // remove active class from all link
  $(".navbar .nav-item").removeClass('active');
  // add active class to nav-link that matches active url
  $(".nav-item > a[href='"+slug+"']").addClass('active');
}

console.log('test');

export { activeLink };
