*** Settings ***
Resource    ../Keywords/ukw_Common.robot


*** Keywords ***
ukw_Set locator values for GDM

   
    #GDM Sub query
    IF    '${TEST_ENV}' == 'sprints-PREDEV'
        Set Global Variable   ${loc_GDM_QueryFilter_SubQuery}     dom:document.querySelector("#the-gdm").shadowRoot.querySelector("#${GDM_MainQuery}> div > a:nth-child(2)")
    ELSE
        Set Global variable  ${loc_GDM_QueryFilter_SubQuery}      dom:document.querySelector("#the-gdm").shadowRoot.querySelector("#${GDM_MainQuery}> div > a:nth-child(1)")
    END

    # GDM icons
    Set Global Variable   ${loc_GDM_Icon_FilterFunnel}    dom:document.querySelector("#the-gdm").shadowRoot.querySelector("div > div.gdm-menu > div.gdm-menu-left > div.gdm-menu-button > div[title='NONE']")
    Set Global Variable   ${loc_GDM_Icon_QueryBuilder}    dom:document.querySelector("#the-gdm").shadowRoot.querySelector("div > div.gdm-menu > div.gdm-menu-left > div.gdm-menu-button > div[title='Query Builder']")
    Set Global Variable    ${loc_GDM_Icon_Calendar}    dom:document.querySelector("#the-gdm").shadowRoot.querySelector("div > div.gdm-menu > div.gdm-menu-left > div[title='Calendar']")
    Set Global Variable    ${loc_GDM_Icon_Calendar_Cancel}    dom:document.querySelector("#the-gdm").shadowRoot.querySelector("div > div.gdm-menu > div.gdm-menu-left > div[title='Calendar'] > div.calendar > cgi-calendar.hydrated").shadowRoot.querySelector("div > div.footer > button[id='cancel-button'")
    Set Global Variable    ${loc_GDM_Icon_Calendar_Close}    dom:document.querySelector("#the-gdm").shadowRoot.querySelector("div > div.gdm-menu > div.gdm-menu-left > div[title='Calendar'] > div.calendar > cgi-calendar.hydrated").shadowRoot.querySelector("div > div.footer > button[id='close-button'")

    Set Global Variable    ${loc_GDM_Icon_MultiRoute}    dom:document.querySelector("#the-gdm").shadowRoot.querySelector("div > div.gdm-menu > div.gdm-menu-left > div.gdm-menu-button > button[title='Multi route']")
    Set Global Variable    ${loc_GDM_Icon_LineInfo}    dom:document.querySelector("#the-gdm").shadowRoot.querySelector("div > div.gdm-menu > div.gdm-menu-left > div.gdm-menu-button > button[title='LineInfo Detail']")
    Set Global Variable    ${loc_GDM_Icon_JobDetails}    dom:document.querySelector("#the-gdm").shadowRoot.querySelector("div > div.gdm-menu > div.gdm-menu-left > div.gdm-menu-button > button[title='Job details']")
    Set Global Variable    ${loc_GDM_Icon_ZoomIn}    dom:document.querySelector("#the-gdm").shadowRoot.querySelector("div > div.gdm-menu > div.gdm-menu-left > div.gdm-menu-button > button[title='Zoom In']")
    Set Global Variable    ${loc_GDM_Icon_ZoomOut}    dom:document.querySelector("#the-gdm").shadowRoot.querySelector("div > div.gdm-menu > div.gdm-menu-left > div.gdm-menu-button > button[title='Zoom Out']")
    Set Global Variable    ${loc_GDM_Icon_ZoomToFit}    dom:document.querySelector("#the-gdm").shadowRoot.querySelector("div > div.gdm-menu > div.gdm-menu-left > div.gdm-menu-button > button[title='Zoom To Fit']")
    Set Global Variable    ${loc_GDM_Icon_ShowonMap}    dom:document.querySelector("#the-gdm").shadowRoot.querySelector("div > div.gdm-menu > div.gdm-menu-left > div.gdm-menu-button > button[title='Show on Map']")
    Set Global Variable    ${loc_GDM_Icon_RefreshData}    dom:document.querySelector("#the-gdm").shadowRoot.querySelector("div > div.gdm-menu > div.gdm-menu-left > div.gdm-menu-button > button[title='Refresh data']")
    Set Global Variable    ${loc_GDM_CalendarGrid_DateHeader}    dom:document.querySelector("#the-gdm").shadowRoot.querySelector("div > div.gdm-menu > div.gdm-menu-left > div.gdm-menu-button > button[title='Refresh data']")
    Set Global Variable    ${loc_GDM_Settings}    dom:document.querySelector("#the-gdm").shadowRoot.querySelector("div > div.gdm-menu > div.gdm-menu-right > div.gdm-menu-button > cgi-gear-icon")
    

    
    #Crew row
    Set Global Variable    ${loc_GDM_SelectCrew_Row_GDMCrew1}    dom:document.querySelector("#the-gdm").shadowRoot.querySelector("div > div.gdm-container > div.gdm-container-lineinfo > table > tbody > tr[data-cgi-lineinfo-name='${GDM_CREW1}'")
    Set Global Variable    ${loc_GDM_SelectCrew_GDMCrew1}    dom:document.querySelector("#the-gdm").shadowRoot.querySelector("div > div.gdm-container > div.gdm-container-lineinfo > table > tbody > tr[data-cgi-lineinfo-name='${GDM_CREW2}'")

    Set Global Variable    ${loc_GDM_SelectCrew_Row1}    dom:document.querySelector("#the-gdm").shadowRoot.querySelector("div > div.gdm-container > div.gdm-container-lineinfo > table > tbody > tr:nth-child(3)")
    Set Global Variable    ${loc_GDM_SelectCrew_Row2}     dom:document.querySelector("#the-gdm").shadowRoot.querySelector("div > div.gdm-container > div.gdm-container-lineinfo > table > tbody > tr:nth-child(4)")
