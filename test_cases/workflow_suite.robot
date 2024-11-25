*** Settings ***
Documentation    This suite tests all workflow test cases related
...              to all website functionalities
Resource         ../resources/bugbank_resources.robot
Suite Setup      Open Bugbank Browser   

*** Test Cases ***
Registration with valid credentials and Balance ON
    [Documentation]    Tests registration using valid credentials 
    ...                and enabling Balance during registration
    [Tags]             registration 
    Given the user is on the registration page
    When the user enters valid credentials
    Then the user should see the account number

Login with valid credentials
    [Documentation]    Tests the login feature using valid credentials
    ...                based on the previous test case
    [Tags]             login
    Given the user is on the login page
    When the user inputs valid login credentials
    Then the user should be redirected to the home page

Transaction using invalid information
    [Documentation]    Tests the transaction feature using a 
    ...                transaction value of 500
    [Tags]             transaction

    Given the user is on the home page
    When the user clicks the transaction button
    And inputs the valid information
    Then the user should see a transaction failed message

Checking statement functionality
    [Documentation]    Tests the Statement functionality
    ...                Verifying if the account was created
    ...                With a 1000 balance
    [Tags]             statement
    Given the user is on the home page
    When the user clicks the statement button
    Then he should see the statement details

Logout of a session
    [Documentation]    Tests the logout capabilities
    [Tags]             logout
    Given the user is on the home page
    When the user clicks the Logout button
    Then the user should be redirected to the login page
