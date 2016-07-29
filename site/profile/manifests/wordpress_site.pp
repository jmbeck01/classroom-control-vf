class wordpress_site {

  include apache
  include wordpress
  include mysql::server
  
}
