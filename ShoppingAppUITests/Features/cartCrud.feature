# The "Open app" scenario and all of the steps were made in order to keep the pattern used on Android, so we can reuse the features of one platform into the other

Feature: Create, Read, Update and Delete from the cart

Scenario: Open app
    Given that the app is opened

Scenario Outline: Validate screen element <listText>
    Then I will assert that the id "<menuItemId>" has the text "<menuItemValue>"
    Examples:
        | menuItemId    | menuItemValue  |
        | menu_home     | Home           |
        | menu_list     | List           |
        | menu_search   | Search         |
        | menu_cart     | Cart           |
        | menu_finder   | Finder         |
        | menu_checkout | Checkout       |


Scenario: Add to the cart
    When I click on text "List"
    And I click on text "D.Va Headset"
    Then I will assert that the id "tvProductName" has the text "D.Va Headset"
    And I will assert that the id "tvPrice" has the text "$60.00"
    And I will assert that the id "tvProductDetails" has the text "A headset as worn by Hana Song in Overwatch"
    And I will assert that the id "tvCategory" has the text "Category: Overwatch"
    And I will assert that the id "tvQuantity" has the text "Quantity: 1"
    When I click on button "btAddToCart"


Scenario: Read from the cart
    When I click on button "LIST"
    And I click on button "SHOPPING APP"
    And I click on text "Cart"
    Then I will assert that the id "tvProductName" has the text "D.Va Headset"
    And I will assert that the id "tvPrice" has the text "$60.00"
    And I will assert that the id "tvQuantity" has the text "Quantity: 1"
    And I will assert that the id "tvFinish" has the text "Finish: No Paint"
    And I will assert that the id "tvMaterial" has the text "Material: PLA"
    And I will assert that the id "tvTotal" has the text "$60.00"


Scenario: Delete from the cart
    When I swipe left on the text "D.Va Headset"
    And I click on button "Delete"
    Then I will assert that the id "tvTotal" has the text "$0.00"

Scenario: close app
    Then the app will be closed
