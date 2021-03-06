@ssl
Feature: Service Should Access Basic Resources via SSL using a self-signed certificate

Scenario: Service should respond to valid collections
  Given a HTTPS BasicAuth ODataService exists using self-signed certificate and username "admin" and password "passwd"
  And blueprints exist for the service
  Then I should be able to call "Products" on the service

Scenario: Entity should fill values on protected resource
  Given a HTTPS BasicAuth ODataService exists using self-signed certificate and username "admin" and password "passwd"
  And blueprints exist for the service
  Given I call "AddToCategories" on the service with a new "Category" object with Name: "Auth Test Category"
  And I save changes
  And I call "Categories" on the service with args: "1"
  When I run the query
  Then the method "Id" on the first result should equal: "1"
  And the method "Name" on the first result should equal: "Auth Test Category"

# TODO: Commented this scenario out because it requires the server to be online in order for the tests to run. Would like to move this to a mocked test that would accomplish the same thing...
# Scenario: Should get SSL failure if SSL used with self-signed certificate and not passing "false" as :verify_ssl option
#   Given a HTTPS BasicAuth ODataService exists it should throw an exception with message containing "SSL Verification failed"
