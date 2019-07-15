
# The "Open app" scenario and all of the steps were made in order to keep the pattern used on Android, so we can reuse the features of one platform into the other
# Browse trough the search and buy one item changing the default Finish and Material and quantity in a different address
Feature: Buy Item changing its parameters

    Scenario: Open app
        Given that the app is opened

    Scenario: Add item through Search
        When I click on text "Search"
        And I fill in the search bar "Search Item" with the text "head"
        And I click on text "D.Va Headset"
        And I click on button "Painting"
        And I click on button "ABS"
        And I click on button "Increment"
        And I click on button "ADD TO CART"
        Then I will assert that the text "Successful" is visible
        And I will assert that the text "Item added to cart." is visible
        And I wait 2 seconds

    Scenario: Checkout
        When I click on button "SEARCH"
        And I click on button "SHOPPING APP"
        And I click on text "Cart"
        And I click on button "CHECKOUT"
        When I fill in the field "etCardNumber" with the text "4685878128604587"
        And I fill in the field "etExpiryMonth" with the text "11"
        And I fill in the field "etExpiryYear" with the text "2022"
        And I fill in the field "etCVV" with the text "675"
        And I choose the value "87/93 Main North Rd, Nailsworth" in the picker wheel
        Then I will assert that the text "D.Va Headset" is visible
        And I will assert that the id "tvTotal" has the text "$198.00"

    Scenario: Finish Pay
        When I click on button "PAY NOW"
        Then I will assert that the text "Pay $198.00" is visible
        When I click on button "Pay"
        Then I will wait 2 seconds
        And I will assert that the text "Thank you for shopping!" is visible
        And I will assert that the text "Your order has been placed." is visible

    Scenario: close app
        Then the app will be closed



