# To achieve step-by-step report updates for a test case in Robot Framework, you need to:

# Accumulate steps for each test case in a variable (e.g., a list or string).
# Only write the test case header and footer once, and append steps as you go.
# At the end of the test case, write the accumulated HTML to the report.
# Here’s a Robot Framework-compatible approach using variables and custom keywords:
# Add Step To Variable accumulates each step’s HTML in ${report_test_steps} .
# REPORT_HTMLFILE_Write Testcase To Report writes the header, all steps, and the footer to the report, then resets ${report_test_steps}  for the next test case.
# You can adapt this pattern for your needs and expand it for multiple test cases. Let me know if you want this implemented in your workspace!
*** Settings ***
Resource    ukw_Common.robot

*** Keywords ***
Add Step To Variable
    [Arguments]    ${steps}    ${step_name}    ${status}    ${screenshot}
    ${color}=    Run Keyword If    '${status}'.lower() == 'passed'    Set Variable    rgb(71, 75, 72)  ELSE    Set Variable    rgb(241, 72, 86)
    ${bgcolor}=    Run Keyword If    '${status}'.lower() == 'passed'    Set Variable    rgb(172, 235, 187)    ELSE    Set Variable    rgb(241, 72, 86)

    IF   '${screenshot}' == 'None'    #IF there is no screenshot required, then don't capture it
        # ${step_html}=    Evaluate    '<div step {status}"><span style="color:{color}; font-weight:bold;">{step_name} - {status}<br></div>'.format(step_name='${step_name}', status='${status}'.upper(), color='${color}')
       
        ${step_html}=    Evaluate    '<div class="step {status}" style="display: flex; align-items: center;"><span style="flex: 1;"><span class="arrow" style="margin-right: 8px;">&#9654;</span><b>{step_name}</b> - <b style="color:black; font-weight:normal;background: {bgcolor};">{status}</b></span><div style="flex: 0 0 220px, text-align: right;"></div></div>'.format(step_name='${step_name}', status='${status}'.upper(), screenshot=r'${screenshot}', color='${color}', bgcolor='${bgcolor}')

    ELSE
        # ${step_html}=    Evaluate    '<div class="step {status}"><span style="color:{color}; font-weight:bold;">{step_name} - {status}</span><br><a href="{screenshot}" target="_blank"><img src="{screenshot}" alt="screenshot"></a></div>'.format(step_name='${step_name}', status='${status}'.upper(), screenshot=r'${screenshot}', color='${color}')
        # ${step_html}=    Evaluate    '<div class="step {status}" style="display: flex; align-items: center;"><span style="flex: 1;"><b>{step_name}</b> - <b style="color:black; font-weight:normal;background: {bgcolor};">{status}</b></span><div style="flex: 0 0 220px, text-align: right;"><a href="{screenshot}" target="_blank"><img src="{screenshot}" alt="screenshot"></a></div></div>'.format(step_name='${step_name}', status='${status}'.upper(), screenshot=r'${screenshot}', color='${color}', bgcolor='${bgcolor}')
        ${step_html}=    Evaluate    '<div class="step {status}" style="display: flex; align-items: center;"><span style="flex: 1;"><span class="arrow" style="margin-right: 8px;">&#9654;</span><b>{step_name}</b> - <b style="color:black; font-weight:normal;background: {bgcolor};">{status}</b></span><div style="flex: 0 0 220px; text-align: right;"><a href="{screenshot}" target="_blank"><img src="{screenshot}" alt="screenshot"></a></div></div>'.format(step_name='${step_name}', status='${status}'.upper(), screenshot=r'${screenshot}', color='${color}', bgcolor='${bgcolor}')

    END
    
    ${steps}=    Set Variable    ${steps}${step_html}
    RETURN   ${steps}



Write Testcase To Report
    [Arguments]    ${steps}    ${idx}    ${testname}
    ${test_status}=    Run Keyword If    'failed' in '${steps.lower()}'    Set Variable    "failed"    ELSE    Set Variable    "passed"
    ${header}=    Evaluate    '<div class="test-row" onclick="toggleDetails({})"><div class="test-header {}"><span id="arrow-{}" class="arrow">&#9654;</span>{} - {}</div><div class="test-details" id="details-{}">'.format(${idx}, ${test_status}, ${idx}, ${testname}, '${test_status}'.upper(), ${idx})
    ${footer}=    Set Variable    </div></div>
    Append To File    ${REPORT_HTMLFILE}    ${header}${steps}${footer}

REPORT_HTMLFILE_Generate Testcase Report 
    [Arguments]    ${idx}    ${testname}    ${steps_data}
    ${steps}=    Set Variable
    ${steps_count}=    Get Length    ${steps_data}
    FOR    ${i}    IN RANGE    0    ${steps_count} 
        ${all_steps}=    Get From List    ${steps_data}    ${i}        
        FOR    ${j}    IN RANGE    0    3    3
        ${steps}=    Set Test Step    ${all_steps}    ${j}    ${steps}
        END
    END
    
    Write Testcase To Report    ${steps}    ${idx}    ${testname}

Set Test Step
    [Arguments]    ${steps_data}    ${i}    ${steps}
    ${step_name}=    Set Variable    ${steps_data}[${i}]
    ${status}=       Set Variable    ${steps_data}[${i+1}]
    ${screenshot}=   Set Variable    ${steps_data}[${i+2}]
    ${steps}=    Add Step To Variable    ${steps}    ${step_name}    ${status}    ${screenshot}
    RETURN   ${steps}

REPORT_HTMLFILE_Create Html Header
    [Documentation]    Creates the HTML header for the sanity test report.
    ${now}=    Get Time    format=%Y-%m-%d %H:%M:%S
    ${header}=    Catenate    SEPARATOR=\n    <html>    <head>    <title>Sanity Test Report for ${TEST_ENV}</title>    <style>    body { font-family: Arial, sans-serif; background: #f4f4f4; }    .test-row { cursor: pointer; background: #fff; border: 1px solid #ccc; margin-bottom: 10px; border-radius: 5px; }    .test-header { padding: 15px; font-size: 18px; display: flex; align-items: center; }    .test-header.passed { color: #155724; background: #d4edda; }    .test-header.failed { color: #721c24; background: #f8d7da; }    .test-details { display: none; padding: 15px; border-top: 1px solid #ccc; }    .step { margin-bottom: 10px; display: flex; align-items: center; }    .step.passed { color: #155724; }    .step.failed { color: #721c24; }    .step img { max-width: 200px; max-height: 120px; margin-left: 20px; border: 1px solid #ccc; border-radius: 3px; }    .arrow { margin-right: 10px; transition: transform 0.2s; }    .arrow.expanded { transform: rotate(90deg); }    </style>    <script>    function toggleDetails(id) {    var details = document.getElementById('details-' + id);    var arrow = document.getElementById('arrow-' + id);    if (details.style.display === 'block') {    details.style.display = 'none';    arrow.classList.remove('expanded');    } else {    details.style.display = 'block';    arrow.classList.add('expanded');    }    }    </script>    </head>    <body>    <h1>Sanity Test Report for ${TEST_ENV}</h1>    <p>Generated: ${now}</p>
          
    Append To File    ${REPORT_HTMLFILE}    ${header}  

Add Html Footer
    [Documentation]    Appends a footer to the HTML report with the count of passed and failed tests.
    ${html}=    Get File    ${REPORT_HTMLFILE}
    ${passed}=    Set Variable    0
    ${failed}=    Set Variable    0
    ${failed}=    Get Count    ${html}    <div class="test-header failed">
    ${passed}=    Get Count    ${html}    <div class="test-header passed">
    
    ${footer}=    Catenate    SEPARATOR=\n    <hr>    <div style="display: flex; justify-content: center; margin: 30px 0;">    <div style="background: #d4edda; color: #155724; border: 2px solid #155724; border-radius: 8px; padding: 20px 40px; margin-right: 30px; font-size: 22px; font-weight: bold; box-shadow: 2px 2px 8px #b2b2b2;">    &#10004; Passed: ${passed}    </div>    <div style="background: #f8d7da; color: #721c24; border: 2px solid #721c24; border-radius: 8px; padding: 20px 40px; font-size: 22px; font-weight: bold; box-shadow: 2px 2px 8px #b2b2b2;">    &#10008; Failed: ${failed}    </div>    </div>    </body>    </html>
    Append To File    ${REPORT_HTMLFILE}    ${footer}
    
Teardown_Update Report
    REPORT_HTMLFILE_Generate Testcase Report   ${temp_reportstep_ifTestFails}[0]    ${temp_reportstep_ifTestFails}[1]     ${finalreport_templist}    

Custom Report Settings Before Execution
    [Arguments]    ${report_index_counter}    ${tstname_to_show_on_report}
    
    @{temp_reportstep_ifTestFails}=     Create list     ${report_index_counter}     ${tstname_to_show_on_report}
    Set Suite Variable    ${temp_reportstep_ifTestFails}