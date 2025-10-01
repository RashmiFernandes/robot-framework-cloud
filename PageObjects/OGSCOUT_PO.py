#Loging
loc_OGSCOUT_Username = "xpath = //input[@id='UserName']"
loc_OGSCOUT_Password = "xpath = //input[@id='Password']"
loc_OGSCOUT_Agree =    "xpath = //*[@class='ui-icon ui-icon-checkbox-off ui-icon-shadow']"

loc_OGSCOUT_Login =    "id=submit-button"

#Home
loc_OGSCOUT_Home=    "xpath=//span[text()='Home']"
loc_OGSCOUT_AddDamage=    "xpath=//span[text()='Add Damage']"
loc_OGSCOUT_DamagesList=    "xpath=//span[text()='Damages List']"
loc_OGSCOUT_IncidentsList=    "xpath=//span[text()='Incidents List']"
loc_OGSCOUT_DevicesList=    "xpath=//span[text()='Devices List']"
loc_OGSCOUT_CoarseDamage=    "xpath=//span[text()='Coarse Damage']"
loc_OGSCOUT_LogOff=    "xpath=//span[contains(text(),'Logout')]"

# Add Damage
loc_OGSCOUT_Damage_AssetIdentifier=    "xpath=//div[@controlname='Damage_AssetIdentifier']"

#PSCOUT_AddDamage
loc_OGSCOUT_AddDamage_AssedID=    "xpath=//div[@controlname='Damage_AssetIdentifier']//input"
loc_OGSCOUT_AddDamage_AssedID_Data=    "xpath=//ul[@id='ui-id-1']/li[1]/div"
loc_OGSCOUT_AddDamage_AssetIdentifier_DamageType=    "xpath=//div[@controlname='Damage_DamageType']//select"
loc_OGSCOUT_AddDamage_AssetIdentifier_DamageType_Value=    "xpath=//div[@controlname='Damage_DamageType']//div[@class='ui-select']/div/span/span/span"
loc_OGSCOUT_AddDamage_Submit=    "xpath=//div[@controlname='AddDamageReport_Submit']/a"

#PSCOUT_CoarseDamage
loc_OGSCOUT_CoarseDamage_Table=    "xpath=//div[@id='DamageCoarseView-container']"

#PSCOUT_DamageList
loc_OGSCOUT_DamageList_AssetIdentifier=    "xpath=//div[@controlname='Damage_AssetIdentifier']"
loc_OGSCOUT_DamageList_DamageId=    "xpath=//div[@id='DamageList-parentdiv']/ul[2]/li[1]//div[@controlname='Damage_DamageId']/parent::td"
loc_OGSCOUT_DamageList_Type=    "xpath=//div[@id='DamageList-parentdiv']/ul[2]/li[1]//div[@controlname='Damage_DamageType']//div[@class='ui-select']/div/span/span[1]/span"
loc_OGSCOUT_DamageList_CreationDate=    "xpath=//div[@id='DamageList-parentdiv']/ul[2]/li[1]//div[@controlname='Damage_CreationDateTime']/parent::td" 

#PSCOUT_DevicesList
loc_OGSCOUT_DevicesList_DeviceTable=    "xpath=//div[@id='AbnormalDeviceList-parentdiv']" 

#PSCOUT_IncidentList
loc_OGSCOUT_IncidentList_IncidentId=    "xpath=//div[@id='_IncidentDetail-0']//input[contains(@id,'Incident_IncidentId-0-')]"
loc_OGSCOUT_IncidentList_DamageDetails=    "xpath=//div[@controlname='Incident_DamageDetailButton']"
loc_OGSCOUT_IncidentList_CreationDate=    "xpath=//div[@id='IncidentList-parentdiv']/ul[2]/li[1]//div[@controlname='Incident_CreationDate']/parent::td"  
loc_OGSCOUT_IncidentList_DamageDetailsList=    "xpath=//div[@id='DamageList-parentdiv']/ul[1]/li[2]//tbody/tr[2]/td[1]/a[1]/span/span[2]"