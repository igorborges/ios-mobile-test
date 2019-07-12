
# The "Open app" scenario and all of the steps were made in order to keep the pattern used on Android, so we can reuse the features of one platform into the other
Feature: Browse and buy an item with success at lease 2 different itens

Scenario: Open app
Given that the app is opened

Scenario: Add first item to the cart
When I click on text "List"
And I click on text "D.Va Headset"
When I click on button "btAddToCart"
Then I will assert that the text "Successful" is visible
And I will assert that the text "Item added to cart." is visible
And I wait 2 seconds

Scenario: Add second item to the cart
When I click on button "LIST"
And I click on text "Scout's Gun"
When I click on button "btAddToCart"
Then I will assert that the text "Successful" is visible
And I will assert that the text "Item added to cart." is visible
And I wait 2 seconds

Scenario: Checkout
When I click on button "LIST"
And I click on button "SHOPPING APP"
And I click on text "Cart"
And I click on button "CHECKOUT"
When I fill in the field "etCardNumber" with the text "4685878128604587"
And I fill in the field "etExpiryMonth" with the text "11"
And I fill in the field "etExpiryYear" with the text "2022"
And I fill in the field "etCVV" with the text "675"
And I choose the value "87/93 Main North Rd, Nailsworth" in the picker wheel
Then I will assert that the text "D.Va Headset" is visible
And I will assert that the text "Scout's Gun" is visible
And I will assert that the id "tvTotal" has the text "$158.00"

Scenario: Finish Pay
When I click on button "PAY NOW"
Then I will assert that the text "Pay $158.00" is visible
When I click on button "Pay"
Then I will assert that the text "Thank you for shopping!" is visible
And I will assert that the text "Your order has been placed." is visible

Scenario: close app
Then the app will be closed
