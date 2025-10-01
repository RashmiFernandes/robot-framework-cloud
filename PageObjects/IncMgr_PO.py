loc_IncMgr_Username = "xpath = //input[@id='UserName']"
loc_IncMgr_Password = "xpath = //input[@id='Password']"
loc_IncMgr_Login =    "id=submit-button"

# Customer Information
loc_IncMgr_Search=  "xpath=//div[@id='tabs-search-footer']//input[@value='Search']"

# Customers Table
loc_IncMgr_CreateCall_SelectRow=  "xpath=//table[@id='customer-query-customers-grid']//tr[9]//span[@title='Create call']"

# TopMenu
loc_IncMgr_Calls=    "xpath=//input[@id='button-customer-query']"
loc_IncMgr_Incidents=    "xpath=//input[@id='button-incident']"
loc_IncMgr_Maps=    "xpath=//input[@id='button-map']"
loc_IncMgr_Connectivity=    "xpath=//input[@id='button-connectivity']"
loc_IncMgr_SwitchingPlans=    "xpath=//input[@id='button-switching-plan']"
loc_IncMgr_LogOff=    "xpath=//button[@id='logout-button']"


# Map tab
loc_IncMgr_Maps_ZoomIn=    "xpath=//img[@id='OpenLayers_Control_PanZoomBar_5_zoomin_innerImage']"

# Connectivity tab
loc_IncMgr_Connectivity_CircuitDescription=    "xpath=//input[@id='CircuitDescription']"

# SwitchingPlans tab
loc_IncMgr_SwitchingPlans_Table=    "xpath=//table[@id='switching-plan-list-grid']"


#PWEB_Incident
loc_IncMgr_IncidentList_ColumnHeader=    "xpath=//div[@id='jqgh_incident-list-grid_IncidentId']"
loc_IncMgr_IncidentList_TableRow1=    "xpath=//table[@id='incident-list-grid']/tbody[1]/tr[2]"

loc_IncMgr_Incident_SelectFilter=    "xpath=//div[@id='div-incident-list-filter']//select[@id='selectedFilter']"

loc_IncMgr_Incident_Address=    "xpath=//table[@id='incident-list-grid']/tbody//td[contains(@title,'${IncidentServiceAddress}') and @aria-describedby='incident-list-grid_LocationDescription']"   #Override address
loc_IncMgr_TableSelectAll=    "xpath=//input[@id='cb_incident-list-grid']"
loc_IncMgr_Status=    "xpath=//td[@aria-describedby='incident-list-grid_StatusDescription']"
# loc_IncMgr_IncidentID=    "xpath=//table[@id='incident-list-grid']/tbody//td[contains(@title,'@!') and @aria-describedby='incident-list-grid_LocationDescription']//preceding-sibling::td[@aria-describedby='incident-list-grid_IncidentId']" #Override address
loc_IncMgr_IncidentID=    "xpath=//table[@id='incident-list-grid']/tbody//tr[2]"
loc_IncMgr_CADID_IncidentTable=    "xpath=//table[@id='incident-list-grid']/tbody//td[contains(@title,'@!') and @aria-describedby='incident-list-grid_ComplexCadId']"   #Override address
loc_IncMgr_IncidentID_Checkbox=    "xpath=//tr[@id='${IncidtentID}']/td[1]"

# Incident bottom Table
loc_IncMgr_LocationID_BottomTable=    "xpath=//td[@aria-describedby='incident-location-grid_LocId']"
loc_IncMgr_CADID_BottomTable=    "xpath=//table[@id='incident-location-grid']/tbody//td[contains(@title,'${LocationID}')]/following-sibling::td[@aria-describedby='incident-location-grid_CadId']"   #Override locationid
loc_IncMgr_Status_BottomTable=    "xpath=//td[@aria-describedby='incident-location-grid_Status']"

# Footer icons
loc_IncMgr_ReleaseToCAD=    "xpath=//td[@id='buttonReleaseToCad']"
loc_IncMgr_Refresh=    "xpath=//td[@id='refresh_incident-list-grid']"


# Popup
loc_IncMgr_Yes=    "xpath=//button[contains(text(),'Yes')]"
loc_IncMgr_Close=    "xpath=//div[@class='ui-dialog-buttonset']//*[text()='Close']"



#PWEBD_Calls
loc_IncMgr_CreateNonConnectedCall=    "xpath=//div[@id='tabs-search-footer']/input[@value='Create Non Connected Call']"
loc_IncMgr_CustomerName=    "xpath=//div[@id='customer-info']//input[@id='CustomerName']"
loc_IncMgr_Phone=    "xpath=//div[@id='customer-info']//input[@id='CustomerPhone']"
loc_IncMgr_ServiceAddress=    "xpath=//div[@id='customer-info']//input[@id='ServiceAddress']"
loc_IncMgr_City=    "xpath=//div[@id='customer-info']//select[@id='selectCustomerCity']"
loc_IncMgr_Structure=    "xpath=//div[@id='customer-info']//input[@id='StructureNumber']"
loc_IncMgr_District=    "xpath=//div[@id='customer-info']//select[@id='DistrictCode']"
loc_IncMgr_CallType=    "xpath=//select[@id='CallType']"
loc_IncMgr_ProblemCode1=    "xpath=//select[@id='comboProblemCodeOne']"
loc_IncMgr_ContactInfoSame=    "xpath=//div[@id='customer-contact']//input[@id='checkboxContactSame']"
loc_IncMgr_Remarks=    "xpath=//textarea[@id='Remarks']"
loc_IncMgr_Directions=    "xpath=//textarea[@id='Directions']"
loc_IncMgr_CallSaved=    "xpath=//*[contains(text(),'Call saved')]"



loc_IncMgr_Account=    "xpath=//input[@id='CustomerAccountNumber']"

loc_IncMgr_Calls_Address=    "xpath=//div[@id='customer-info']//input[@id='ServiceAddress']"

loc_IncMgr_Save=    "xpath=//div[@id='customer-footer']//input[@id='saveButton']"
loc_IncMgr_Yes=    "xpath=//button[contains(text(),'Yes')]"


