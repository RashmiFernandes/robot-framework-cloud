
# Status Group DB column constants
class statusConstants:
        STATUS_GROUP_ID = 0
        STATUS_CODE = 1
        CODE_ORDER = 2
        FIRST_SELECTED = 3
        WEIGHT = 4
        ACTIVE_CARD = 5 
        SUSPEND_STATUS = 6 
        SUSPEND_MSG = 7
        EXTERNAL_DISPOSE_FLG = 8
        STATUS_EMERGENCY_TIMER_ACK_FLG = 9
        REASON_CODE_REQUIRED_FLG = 10
        ALLOW_CANCEL_AVAIL_APPOINT_FLG = 11
        FORM_GROUP_NAME = 12
        FIRST_REPORTING_STATUS_FLG = 13
        EN_ROUTE_FLG = 14
        ON_SITE_FLG = 15
        TRANSFER_ON_REASSIGN_FLG = 16
        STATUS_DESCRIPTION = 17
        B07_STATUS_COLOR = 18
        
class StatusGroup(statusConstants):

    def __init__(self):
        self._currentStatusIndex = 0
        self._listOrderedStatus = []
        self._listNonOrderedStatus = []
        self._listNonOrderedStatusDesc = []
        self._listOrderedStatusDesc = []
        self._listNonOrderedActiveStatus = []
        self._listOrderedActiveStatus = []

        self.statuses = []

    def _clearStatus(self):
        self._currentStatusIndex = 0
        self._listOrderedStatus.clear()
        self._listNonOrderedStatus.clear()
        self._listNonOrderedStatusDesc.clear()
        self._listOrderedStatusDesc.clear()
        self._listNonOrderedActiveStatus.clear()
        self._listOrderedActiveStatus.clear()

    def initStatusGroup(self,statuses):
        self.statuses = statuses        
        
        currentStatus = self.statuses[self.STATUS_CODE]  #Constants are defined in StatusGroupConstants.py file, this is the column number from the Status group table for Status DP/AC etc
        currentCode = self.statuses[self.CODE_ORDER]  #this is the column number from the Status group table for Code 1,2, 3 etc
        currentStatusDesc = self.statuses[self.STATUS_DESCRIPTION]
        currentActiveStatus = self.statuses[self.ACTIVE_CARD]

        if currentCode == 0:
            self._listNonOrderedStatus.append(currentStatus)  
            self._listNonOrderedStatusDesc.append(currentStatusDesc)
            self._listNonOrderedActiveStatus.append(currentActiveStatus)
        else:
            self._listOrderedStatus.append(currentStatus) 
            self._listOrderedStatusDesc.append(currentStatusDesc) 
            self._listOrderedActiveStatus.append(currentActiveStatus)

       

    def getNumberOfStatus(self):
        return len(self._listOrderedStatus)
    
    def getListOfStatus(self):
        return self._listOrderedStatus
    
    def getListOfStatusDescription(self):
        return self._listOrderedStatusDesc
    
    def getListOfActiveStatus(self):
        return self._listOrderedActiveStatus

    def getStatusCodeByIndex(self, index: int):
        if index < len(self._listOrderedStatus):
            return self._listOrderedStatus[index].status_code
        else:
            return None

    def getStatusDescByIndex(self, index: int):
        if index < len(self._listOrderedStatus):
            return self._listOrderedStatus[index].status_description
        else:
            return None

    def isActiveStatusByIndex(self, index: int):
        if index < len(self._listOrderedStatus):
            if self._listOrderedStatus[index].self.statuses[5] == 'F' or self._listOrderedStatus[index].active_card == None:
                return False
            else:
                return True
        else:
            return None
        

        
    