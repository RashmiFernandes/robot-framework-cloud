*** Settings ***
Library         ../Resource/EnvironmentConfig.py
Library         OperatingSystem
Library         Collections
Library         SeleniumLibrary
Library         DateTime

*** Variables ***
${DEFAULT_ENV}    A

*** Keywords ***
Local Suite Setup
    [Documentation]    Setup for local test execution (no Docker)
    [Arguments]    ${environment}=${DEFAULT_ENV}
    
    Log    Setting up local test environment: ${environment}
    
    # Load environment-specific configuration
    Load Environment Config    ${environment}
    
    # Set browser options for local execution
    Set Browser Options For Local
    
    # Create screenshots directory
    Create Directory    ${OUTPUT_DIR}/screenshots
    
    # Set global test environment variable
    Set Global Variable    ${TEST_ENV}    ${environment}
    
    Log    Local setup completed for environment: ${environment}

Local Suite Teardown
    [Documentation]    Cleanup after local test execution
    
    Log    Starting local test cleanup
    
    # Close all browsers
    Close All Browsers
    
    # Generate custom reports if needed
    Run Keyword And Ignore Error    Generate Local Test Report
    
    Log    Local test cleanup completed

Set Browser Options For Local
    [Documentation]    Set browser options for local execution
    
    # Check if running headless
    ${headless}=    Get Variable Value    ${HEADLESS}    false
    
    ${chrome_options}=    Create List
    
    # Add headless option if specified
    Run Keyword If    '${headless}' == 'true'    
    ...    Append To List    ${chrome_options}    --headless
    
    # Add other useful options for local testing
    Append To List    ${chrome_options}    --no-sandbox
    Append To List    ${chrome_options}    --disable-dev-shm-usage
    Append To List    ${chrome_options}    --disable-gpu
    Append To List    ${chrome_options}    --window-size=1920,1080
    Append To List    ${chrome_options}    --start-maximized
    
    Set Global Variable    ${CHROME_OPTIONS}    ${chrome_options}
    
    Log    Browser options configured for local execution

Open Browser For Local
    [Documentation]    Open browser with local-specific configurations
    [Arguments]    ${url}    ${browser}=chrome    ${alias}=None
    
    # Get chrome options
    ${chrome_options}=    Get Variable Value    ${CHROME_OPTIONS}    []
    
    # Create browser options
    ${options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys, selenium.webdriver
    
    # Add each option
    FOR    ${option}    IN    @{chrome_options}
        Call Method    ${options}    add_argument    ${option}
    END
    
    # Create desired capabilities
    ${capabilities}=    Create Dictionary    
    ...    browserName=chrome
    ...    goog:chromeOptions=${options}
    
    # Open browser
    Open Browser    ${url}    ${browser}    alias=${alias}    options=${options}
    
    # Set timeouts
    Set Browser Implicit Wait    30
    Set Selenium Timeout    60
    
    # Maximize window
    Maximize Browser Window

Generate Local Test Report
    [Documentation]    Generate additional reports for local execution
    
    ${timestamp}=    Get Current Date    result_format=%Y%m%d_%H%M%S
    ${report_file}=    Set Variable    ${OUTPUT_DIR}/local_summary_${timestamp}.html
    
    ${test_env}=    Get Variable Value    ${TEST_ENV}    Unknown
    
    ${html_content}=    Catenate    SEPARATOR=
    ...    <!DOCTYPE html><html><head><title>Local Test Summary</title></head><body>
    ...    <h1>Robot Framework - Local Test Summary</h1>
    ...    <h3>Test Environment Information</h3>
    ...    <p>Environment: ${test_env}</p>
    ...    <p>Execution Time: ${timestamp}</p>
    ...    <p>Execution Type: Local (No Docker)</p>
    ...    <p>Machine: Windows 10 Enterprise</p>
    ...    <h3>Available Reports</h3>
    ...    <ul><li><a href="report.html">Test Report</a></li>
    ...    <li><a href="log.html">Detailed Log</a></li>
    ...    <li><a href="output.xml">Raw XML Output</a></li></ul>
    ...    </body></html>
    
    Create File    ${report_file}    ${html_content}
    
    Log    Local test report generated: ${report_file}

Check Local Environment
    [Documentation]    Check if local environment is properly set up
    
    # Check if Python virtual environment is active
    ${python_path}=    Get Environment Variable    VIRTUAL_ENV    ${EMPTY}
    
    Run Keyword If    '${python_path}' == '${EMPTY}'
    ...    Log    Warning: Virtual environment might not be active    WARN
    ...    ELSE
    ...    Log    Virtual environment active: ${python_path}
    
    # Check if required libraries are available
    ${rf_version}=    Get Library Instance    BuiltIn
    Log    Robot Framework instance available
    
    # Verify browser drivers
    Run Keyword And Ignore Error    Check Browser Driver Availability

Check Browser Driver Availability
    [Documentation]    Verify that browser drivers are available
    
    ${browser}=    Get Variable Value    ${BROWSER}    chrome
    
    Run Keyword If    '${browser}' == 'chrome'    Check Chrome Driver
    Run Keyword If    '${browser}' == 'firefox'    Check Firefox Driver
    Run Keyword If    '${browser}' == 'edge'    Check Edge Driver

Check Chrome Driver
    [Documentation]    Check if Chrome and ChromeDriver are available
    
    ${result}=    Run And Return RC    chromedriver --version
    
    Run Keyword If    ${result} == 0
    ...    Log    ✅ ChromeDriver is available
    ...    ELSE
    ...    Log    ⚠️ ChromeDriver not found. It will be downloaded automatically.    WARN

Check Firefox Driver
    [Documentation]    Check if Firefox and GeckoDriver are available
    
    ${result}=    Run And Return RC    geckodriver --version
    
    Run Keyword If    ${result} == 0
    ...    Log    ✅ GeckoDriver is available  
    ...    ELSE
    ...    Log    ⚠️ GeckoDriver not found. Please install Firefox and GeckoDriver.    WARN

Check Edge Driver
    [Documentation]    Check if Edge and EdgeDriver are available
    
    ${result}=    Run And Return RC    msedgedriver --version
    
    Run Keyword If    ${result} == 0
    ...    Log    ✅ EdgeDriver is available
    ...    ELSE  
    ...    Log    ⚠️ EdgeDriver not found. Please install Microsoft Edge WebDriver.    WARN