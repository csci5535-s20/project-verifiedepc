// S1AP-Constants
/*
-- **************************************************************
--
-- Constant definitions
--
*/

/* TODO: Need to insert/initialize the Constant Values
struct ConstLists {
  // Map from feature name to feature list.
  map<string, FeatureList> constants_list = 1;
}*/

// Extension Constants
 const  i32 maxPrivateIEs 					= 65535;
 const  i32 maxProtocolExtensions 			= 65535;
 const  i32 maxProtocolIEs					= 65535;

// List Lengths
 const  i32 maxNrOfCSGs							= 256;
 const  i32 maxNrOfE-RABs						= 256;
 const  i32 maxnoofTAIs							= 256;
 const  i32 maxnoofTACs							= 256;
 const  i32 maxNrOfErrors						= 256;
 const  i32 maxnoofBPLMNs						= 6;
 const  i32 maxnoofPLMNsPerMME					= 32;
 const  i32 maxnoofEPLMNs						= 15;
 const  i32 maxnoofEPLMNsPlusOne				= 16;
 const  i32 maxnoofForbLACs						= 4096;
 const  i32 maxnoofForbTACs						= 4096;
 const  i32 maxNrOfIndividualS1ConnectionsToReset = 256;
 const  i32 maxnoofCells						= 16;
 const  i32 maxnoofTAIforWarning				= 65535 ;
 const  i32 maxnoofCellID						= 65535 ;
 const  i32 maxnoofEmergencyAreaID				= 65535 ;
 const  i32 maxnoofCellinTAI					= 65535 ;
 const  i32 maxnoofCellinEAI					= 65535 ;
 const  i32 maxnoofeNBX2TLAs					= 2;
 const  i32 maxnoofRATs							= 8;
 const  i32 maxnoofGroupIDs						= 65535;
 const  i32 maxnoofMMECs						= 256

// Elementary Procedures 


typedef ProcedureCode ID_HandoverPreparation_PC = 0
typedef ProcedureCode ID_HandoverResourceAllocation_PC = 1
typedef ProcedureCode ID_HandoverNotification_PC = 2
typedef ProcedureCode ID_PathSwitchRequest_PC = 3
typedef ProcedureCode ID_HandoverCancel_PC = 4
typedef ProcedureCode ID_E_RABSetup_PC = 5
typedef ProcedureCode ID_E_RABModify_PC = 6
typedef ProcedureCode ID_E_RABRelease_PC = 7
typedef ProcedureCode ID_E_RABReleaseIndication_PC = 8
typedef ProcedureCode ID_InitialContextSetup_PC = 9
typedef ProcedureCode ID_Paging_PC = 10
typedef ProcedureCode ID_downlinkNASTransport_PC = 11
typedef ProcedureCode ID_initialUEMessage_PC = 12
typedef ProcedureCode ID_uplinkNASTransport_PC = 13
typedef ProcedureCode ID_Reset_PC = 14
typedef ProcedureCode ID_ErrorIndication_PC = 15
typedef ProcedureCode ID_NASNonDeliveryIndication_PC = 16
typedef ProcedureCode ID_S1Setup_PC = 17
typedef ProcedureCode ID_UEContextReleaseRequest_PC = 18
typedef ProcedureCode ID_DownlinkS1cdma2000tunneling_PC = 19
typedef ProcedureCode ID_UplinkS1cdma2000tunneling_PC = 20
typedef ProcedureCode ID_UEContextModification_PC = 21
typedef ProcedureCode ID_UECapabilityInfoIndication_PC = 22
typedef ProcedureCode ID_UEContextRelease_PC = 23
typedef ProcedureCode ID_eNBStatusTransfer_PC = 24
typedef ProcedureCode ID_MMEStatusTransfer_PC = 25
typedef ProcedureCode ID_DeactivateTrace_PC = 26
typedef ProcedureCode ID_TraceStart_PC = 27
typedef ProcedureCode ID_TraceFailureIndication_PC = 28
typedef ProcedureCode ID_ENBConfigurationUpdate_PC = 29
typedef ProcedureCode ID_MMEConfigurationUpdate_PC = 30
typedef ProcedureCode ID_LocationReportingControl_PC = 31
typedef ProcedureCode ID_LocationReportingFailureIndication_PC = 32
typedef ProcedureCode ID_LocationReport_PC = 33
typedef ProcedureCode ID_OverloadStart_PC = 34
typedef ProcedureCode ID_OverloadStop_PC = 35
typedef ProcedureCode ID_WriteReplaceWarning_PC = 36
typedef ProcedureCode ID_eNBDirectInformationTransfer_PC = 37
typedef ProcedureCode ID_MMEDirectInformationTransfer_PC = 38
typedef ProcedureCode ID_PrivateMessage_PC = 39
typedef ProcedureCode ID_eNBConfigurationTransfer_PC = 40
typedef ProcedureCode ID_MMEConfigurationTransfer_PC = 41
typedef ProcedureCode ID_CellTrafficTrace_PC = 42



// IE-s

typedef ProtocolIEID ID_MME_UE_S1AP_ID_PIEID = 0
typedef ProtocolIEID ID_HandoverType_PIEID = 1
typedef ProtocolIEID ID_Cause_PIEID = 2
typedef ProtocolIEID ID_SourceID_PIEID = 3
typedef ProtocolIEID ID_TargetID_PIEID = 4
typedef ProtocolIEID ID_eNB_UE_S1AP_ID_PIEID = 8
typedef ProtocolIEID ID_E_RABSubjecttoDataForwardingList_PIEID = 12
typedef ProtocolIEID ID_E_RABtoReleaseListHOCmd_PIEID = 13
typedef ProtocolIEID ID_E_RABDataForwardingItem_PIEID = 14
typedef ProtocolIEID ID_E_RABReleaseItemBearerRelComp_PIEID = 15
typedef ProtocolIEID ID_E_RABToBeSetupListBearerSUReq_PIEID = 16
typedef ProtocolIEID ID_E_RABToBeSetupItemBearerSUReq_PIEID = 17
typedef ProtocolIEID ID_E_RABAdmittedList_PIEID = 18
typedef ProtocolIEID ID_E_RABFailedToSetupListHOReqAck_PIEID = 19
typedef ProtocolIEID ID_E_RABAdmittedItem_PIEID = 20
typedef ProtocolIEID ID_E_RABFailedtoSetupItemHOReqAck_PIEID = 21
typedef ProtocolIEID ID_E_RABToBeSwitchedDLList_PIEID = 22
typedef ProtocolIEID ID_E_RABToBeSwitchedDLItem_PIEID = 23
typedef ProtocolIEID ID_E_RABToBeSetupListCtxtSUReq_PIEID = 24
typedef ProtocolIEID ID_TraceActivation_PIEID = 25
typedef ProtocolIEID ID_NAS_PDU_PIEID = 26
typedef ProtocolIEID ID_E_RABToBeSetupItemHOReq_PIEID = 27
typedef ProtocolIEID ID_E_RABSetupListBearerSURes_PIEID = 28
typedef ProtocolIEID ID_E_RABFailedToSetupListBearerSURes_PIEID = 29
typedef ProtocolIEID ID_E_RABToBeModifiedListBearerModReq_PIEID = 30
typedef ProtocolIEID ID_E_RABModifyListBearerModRes_PIEID = 31
typedef ProtocolIEID ID_E_RABFailedToModifyList_PIEID = 32
typedef ProtocolIEID ID_E_RABToBeReleasedList_PIEID = 33
typedef ProtocolIEID ID_E_RABFailedToReleaseList_PIEID = 34
typedef ProtocolIEID ID_E_RABItem_PIEID = 35
typedef ProtocolIEID ID_E_RABToBeModifiedItemBearerModReq_PIEID = 36
typedef ProtocolIEID ID_E_RABModifyItemBearerModRes_PIEID = 37
typedef ProtocolIEID ID_E_RABReleaseItem_PIEID = 38
typedef ProtocolIEID ID_E_RABSetupItemBearerSURes_PIEID = 39
typedef ProtocolIEID ID_SecurityContext_PIEID = 40
typedef ProtocolIEID ID_HandoverRestrictionList_PIEID = 41
typedef ProtocolIEID ID_UEPagingID_PIEID = 43
typedef ProtocolIEID ID_pagingDRX_PIEID = 44
typedef ProtocolIEID ID_TAIList_PIEID = 46
typedef ProtocolIEID ID_TAIItem_PIEID = 47
typedef ProtocolIEID ID_E_RABFailedToSetupListCtxtSURes_PIEID = 48
typedef ProtocolIEID ID_E_RABReleaseItemHOCmd_PIEID = 49
typedef ProtocolIEID ID_E_RABSetupItemCtxtSURes_PIEID = 50
typedef ProtocolIEID ID_E_RABSetupListCtxtSURes_PIEID = 51
typedef ProtocolIEID ID_E_RABToBeSetupItemCtxtSUReq_PIEID = 52
typedef ProtocolIEID ID_E_RABToBeSetupListHOReq_PIEID = 53
typedef ProtocolIEID ID_GERANtoLTEHOInformationRes_PIEID = 55
typedef ProtocolIEID ID_UTRANtoLTEHOInformationRes_PIEID = 57
typedef ProtocolIEID ID_CriticalityDiagnostics_PIEID = 58
typedef ProtocolIEID ID_Global_ENB_ID_PIEID = 59
typedef ProtocolIEID ID_eNBname_PIEID = 60
typedef ProtocolIEID ID_MMEname_PIEID = 61
typedef ProtocolIEID ID_ServedPLMNs_PIEID = 63
typedef ProtocolIEID ID_SupportedTAs_PIEID = 64
typedef ProtocolIEID ID_TimeToWait_PIEID = 65
typedef ProtocolIEID ID_uEaggregateMaximumBitrate_PIEID = 66
typedef ProtocolIEID ID_TAI_PIEID = 67
typedef ProtocolIEID ID_E_RABReleaseListBearerRelComp_PIEID = 69
typedef ProtocolIEID ID_cdma2000PDU_PIEID = 70
typedef ProtocolIEID ID_cdma2000RATType_PIEID = 71
typedef ProtocolIEID ID_cdma2000SectorID_PIEID = 72
typedef ProtocolIEID ID_SecurityKey_PIEID = 73
typedef ProtocolIEID ID_UERadioCapability_PIEID = 74
typedef ProtocolIEID ID_GUMMEI_ID_PIEID = 75
typedef ProtocolIEID ID_E_RABInformationListItem_PIEID = 78
typedef ProtocolIEID ID_Direct_Forwarding_Path_Availability_PIEID = 79
typedef ProtocolIEID ID_UEIdentityIndexValue_PIEID = 80
typedef ProtocolIEID ID_cdma2000HOStatus_PIEID = 83
typedef ProtocolIEID ID_cdma2000HORequiredIndication_PIEID = 84
typedef ProtocolIEID ID_E_UTRAN_Trace_ID_PIEID = 86
typedef ProtocolIEID ID_RelativeMMECapacity_PIEID = 87
typedef ProtocolIEID ID_SourceMME_UE_S1AP_ID_PIEID = 88
typedef ProtocolIEID ID_Bearers_SubjectToStatusTransfer_Item_PIEID = 89
typedef ProtocolIEID ID_eNB_StatusTransfer_TransparentContainer_PIEID = 90
typedef ProtocolIEID ID_UE_associatedLogicalS1_ConnectionItem_PIEID = 91
typedef ProtocolIEID ID_ResetType_PIEID = 92
typedef ProtocolIEID ID_UE_associatedLogicalS1_ConnectionListResAck_PIEID = 93
typedef ProtocolIEID ID_E_RABToBeSwitchedULItem_PIEID = 94
typedef ProtocolIEID ID_E_RABToBeSwitchedULList_PIEID = 95
typedef ProtocolIEID ID_S_TMSI_PIEID = 96
typedef ProtocolIEID ID_cdma2000OneXRAND_PIEID = 97
typedef ProtocolIEID ID_RequestType_PIEID = 98
typedef ProtocolIEID ID_UE_S1AP_IDs_PIEID = 99
typedef ProtocolIEID ID_EUTRAN_CGI_PIEID = 100
typedef ProtocolIEID ID_OverloadResponse_PIEID = 101
typedef ProtocolIEID ID_cdma2000OneXSRVCCInfo_PIEID = 102
typedef ProtocolIEID ID_E_RABFailedToBeReleasedList_PIEID = 103
typedef ProtocolIEID ID_Source_ToTarget_TransparentContainer_PIEID = 104
typedef ProtocolIEID ID_ServedGUMMEIs_PIEID = 105
typedef ProtocolIEID ID_SubscriberProfileIDforRFP_PIEID = 106
typedef ProtocolIEID ID_UESecurityCapabilities_PIEID = 107
typedef ProtocolIEID ID_CSFallbackIndicator_PIEID = 108
typedef ProtocolIEID ID_CNDomain_PIEID = 109
typedef ProtocolIEID ID_E_RABReleasedList_PIEID = 110
typedef ProtocolIEID ID_MessageIdentifier_PIEID = 111
typedef ProtocolIEID ID_SerialNumber_PIEID = 112
typedef ProtocolIEID ID_WarningAreaList_PIEID = 113
typedef ProtocolIEID ID_RepetitionPeriod_PIEID = 114
typedef ProtocolIEID ID_NumberofBroadcastRequest_PIEID = 115
typedef ProtocolIEID ID_WarningType_PIEID = 116
typedef ProtocolIEID ID_WarningSecurityInfo_PIEID = 117
typedef ProtocolIEID ID_DataCodingScheme_PIEID = 118
typedef ProtocolIEID ID_WarningMessageContents_PIEID = 119
typedef ProtocolIEID ID_BroadcastCompletedAreaList_PIEID = 120
typedef ProtocolIEID ID_Inter_SystemInformationTransferTypeEDT_PIEID = 121
typedef ProtocolIEID ID_Inter_SystemInformationTransferTypeMDT_PIEID = 122
typedef ProtocolIEID ID_Target_ToSource_TransparentContainer_PIEID = 123
typedef ProtocolIEID ID_SRVCCOperationPossible_PIEID = 124
typedef ProtocolIEID ID_SRVCCHOIndication_PIEID = 125
typedef ProtocolIEID ID_NAS_DownlinkCount_PIEID = 126
typedef ProtocolIEID ID_CSG_Id_PIEID = 127
typedef ProtocolIEID ID_CSG_IdList_PIEID = 128
typedef ProtocolIEID ID_SONConfigurationTransferECT_PIEID = 129
typedef ProtocolIEID ID_SONConfigurationTransferMCT_PIEID = 130
typedef ProtocolIEID ID_TraceCollectionEntityIPAddress_PIEID = 131
typedef ProtocolIEID ID_MSClassmark2_PIEID = 132
typedef ProtocolIEID ID_MSClassmark3_PIEID = 133
typedef ProtocolIEID ID_RRC_Establishment_Cause_PIEID = 134
typedef ProtocolIEID ID_NASSecurityParametersfromE_UTRAN_PIEID = 135
typedef ProtocolIEID ID_NASSecurityParameterstoE_UTRAN_PIEID = 136
typedef ProtocolIEID ID_DefaultPagingDRX_PIEID = 137
typedef ProtocolIEID ID_Source_ToTarget_TransparentContainer_Secondary_PIEID = 138
typedef ProtocolIEID ID_Target_ToSource_TransparentContainer_Secondary_PIEID = 139











/*

-- **************************************************************
-- TS 36.413 V8.10.0 (2010-06)
-- **************************************************************

S1AP-Constants { 
itu-t (0) identified-organization (4) etsi (0) mobileDomain (0) 
eps-Access (21) modules (3) s1ap (1) version1 (1) s1ap-Constants (4) } 

DEFINITIONS AUTOMATIC TAGS ::= 

BEGIN

-- **************************************************************
--
-- IE parameter types from other modules.
--
-- **************************************************************

IMPORTS
	ProcedureCode,
	ProtocolIE-ID

FROM S1AP-CommonDataTypes;


-- **************************************************************
--
-- Elementary Procedures
--
-- **************************************************************

id-HandoverPreparation 				ProcedureCode ::= 0
id-HandoverResourceAllocation 		ProcedureCode ::= 1
id-HandoverNotification 			ProcedureCode ::= 2
id-PathSwitchRequest 				ProcedureCode ::= 3
id-HandoverCancel 					ProcedureCode ::= 4
id-E-RABSetup						ProcedureCode ::= 5
id-E-RABModify 						ProcedureCode ::= 6
id-E-RABRelease						ProcedureCode ::= 7
id-E-RABReleaseIndication			ProcedureCode ::= 8
id-InitialContextSetup				ProcedureCode ::= 9
id-Paging							ProcedureCode ::= 10
id-downlinkNASTransport				ProcedureCode ::= 11
id-initialUEMessage					ProcedureCode ::= 12
id-uplinkNASTransport				ProcedureCode ::= 13
id-Reset							ProcedureCode ::= 14
id-ErrorIndication					ProcedureCode ::= 15
id-NASNonDeliveryIndication			ProcedureCode ::= 16
id-S1Setup							ProcedureCode ::= 17
id-UEContextReleaseRequest			ProcedureCode ::= 18
id-DownlinkS1cdma2000tunneling		ProcedureCode ::= 19
id-UplinkS1cdma2000tunneling		ProcedureCode ::= 20
id-UEContextModification			ProcedureCode ::= 21
id-UECapabilityInfoIndication		ProcedureCode ::= 22
id-UEContextRelease					ProcedureCode ::= 23
id-eNBStatusTransfer				ProcedureCode ::= 24
id-MMEStatusTransfer				ProcedureCode ::= 25
id-DeactivateTrace					ProcedureCode ::= 26
id-TraceStart						ProcedureCode ::= 27
id-TraceFailureIndication			ProcedureCode ::= 28
id-ENBConfigurationUpdate			ProcedureCode ::= 29
id-MMEConfigurationUpdate			ProcedureCode ::= 30
id-LocationReportingControl			ProcedureCode ::= 31
id-LocationReportingFailureIndication	ProcedureCode ::= 32
id-LocationReport					ProcedureCode ::= 33
id-OverloadStart					ProcedureCode ::= 34
id-OverloadStop						ProcedureCode ::= 35
id-WriteReplaceWarning				ProcedureCode ::= 36
id-eNBDirectInformationTransfer		ProcedureCode ::= 37
id-MMEDirectInformationTransfer		ProcedureCode ::= 38
id-PrivateMessage					ProcedureCode ::= 39
id-eNBConfigurationTransfer			ProcedureCode ::= 40
id-MMEConfigurationTransfer			ProcedureCode ::= 41
id-CellTrafficTrace					ProcedureCode ::= 42

-- **************************************************************
--
-- Extension constants
--
-- **************************************************************

maxPrivateIEs 						INTEGER ::= 65535
maxProtocolExtensions 				INTEGER ::= 65535
maxProtocolIEs						INTEGER ::= 65535
-- **************************************************************
--
-- Lists
--
-- **************************************************************

maxNrOfCSGs								INTEGER ::= 256
maxNrOfE-RABs							INTEGER ::= 256
maxnoofTAIs								INTEGER ::= 256
maxnoofTACs								INTEGER ::= 256
maxNrOfErrors							INTEGER ::= 256
maxnoofBPLMNs							INTEGER ::= 6
maxnoofPLMNsPerMME						INTEGER ::= 32
maxnoofEPLMNs							INTEGER ::= 15
maxnoofEPLMNsPlusOne					INTEGER ::= 16
maxnoofForbLACs							INTEGER ::= 4096
maxnoofForbTACs							INTEGER ::= 4096
maxNrOfIndividualS1ConnectionsToReset	INTEGER ::= 256
maxnoofCells							INTEGER ::= 16
maxnoofTAIforWarning					INTEGER ::= 65535 
maxnoofCellID							INTEGER ::= 65535 
maxnoofEmergencyAreaID					INTEGER ::= 65535 
maxnoofCellinTAI						INTEGER ::= 65535 
maxnoofCellinEAI						INTEGER ::= 65535 
maxnoofeNBX2TLAs						INTEGER ::= 2
maxnoofRATs								INTEGER ::= 8
maxnoofGroupIDs							INTEGER ::= 65535
maxnoofMMECs							INTEGER ::= 256




-- **************************************************************
--
-- IEs
--
-- **************************************************************

id-MME-UE-S1AP-ID							ProtocolIE-ID ::= 0
id-HandoverType								ProtocolIE-ID ::= 1
id-Cause									ProtocolIE-ID ::= 2
id-SourceID									ProtocolIE-ID ::= 3
id-TargetID									ProtocolIE-ID ::= 4
id-eNB-UE-S1AP-ID							ProtocolIE-ID ::= 8
id-E-RABSubjecttoDataForwardingList			ProtocolIE-ID ::= 12
id-E-RABtoReleaseListHOCmd					ProtocolIE-ID ::= 13
id-E-RABDataForwardingItem					ProtocolIE-ID ::= 14
id-E-RABReleaseItemBearerRelComp			ProtocolIE-ID ::= 15
id-E-RABToBeSetupListBearerSUReq			ProtocolIE-ID ::= 16
id-E-RABToBeSetupItemBearerSUReq			ProtocolIE-ID ::= 17
id-E-RABAdmittedList						ProtocolIE-ID ::= 18
id-E-RABFailedToSetupListHOReqAck			ProtocolIE-ID ::= 19
id-E-RABAdmittedItem						ProtocolIE-ID ::= 20
id-E-RABFailedtoSetupItemHOReqAck			ProtocolIE-ID ::= 21
id-E-RABToBeSwitchedDLList					ProtocolIE-ID ::= 22
id-E-RABToBeSwitchedDLItem					ProtocolIE-ID ::= 23
id-E-RABToBeSetupListCtxtSUReq				ProtocolIE-ID ::= 24
id-TraceActivation							ProtocolIE-ID ::= 25
id-NAS-PDU									ProtocolIE-ID ::= 26
id-E-RABToBeSetupItemHOReq					ProtocolIE-ID ::= 27
id-E-RABSetupListBearerSURes				ProtocolIE-ID ::= 28
id-E-RABFailedToSetupListBearerSURes		ProtocolIE-ID ::= 29
id-E-RABToBeModifiedListBearerModReq		ProtocolIE-ID ::= 30
id-E-RABModifyListBearerModRes				ProtocolIE-ID ::= 31
id-E-RABFailedToModifyList					ProtocolIE-ID ::= 32
id-E-RABToBeReleasedList					ProtocolIE-ID ::= 33
id-E-RABFailedToReleaseList					ProtocolIE-ID ::= 34
id-E-RABItem								ProtocolIE-ID ::= 35
id-E-RABToBeModifiedItemBearerModReq		ProtocolIE-ID ::= 36
id-E-RABModifyItemBearerModRes				ProtocolIE-ID ::= 37
id-E-RABReleaseItem							ProtocolIE-ID ::= 38
id-E-RABSetupItemBearerSURes				ProtocolIE-ID ::= 39
id-SecurityContext							ProtocolIE-ID ::= 40
id-HandoverRestrictionList					ProtocolIE-ID ::= 41
id-UEPagingID 								ProtocolIE-ID ::= 43
id-pagingDRX 								ProtocolIE-ID ::= 44
id-TAIList									ProtocolIE-ID ::= 46
id-TAIItem									ProtocolIE-ID ::= 47
id-E-RABFailedToSetupListCtxtSURes			ProtocolIE-ID ::= 48
id-E-RABReleaseItemHOCmd					ProtocolIE-ID ::= 49
id-E-RABSetupItemCtxtSURes					ProtocolIE-ID ::= 50
id-E-RABSetupListCtxtSURes					ProtocolIE-ID ::= 51
id-E-RABToBeSetupItemCtxtSUReq				ProtocolIE-ID ::= 52
id-E-RABToBeSetupListHOReq					ProtocolIE-ID ::= 53
id-GERANtoLTEHOInformationRes					ProtocolIE-ID ::= 55
id-UTRANtoLTEHOInformationRes					ProtocolIE-ID ::= 57
id-CriticalityDiagnostics 						ProtocolIE-ID ::= 58
id-Global-ENB-ID								ProtocolIE-ID ::= 59
id-eNBname										ProtocolIE-ID ::= 60
id-MMEname										ProtocolIE-ID ::= 61
id-ServedPLMNs									ProtocolIE-ID ::= 63
id-SupportedTAs									ProtocolIE-ID ::= 64
id-TimeToWait									ProtocolIE-ID ::= 65
id-uEaggregateMaximumBitrate					ProtocolIE-ID ::= 66
id-TAI											ProtocolIE-ID ::= 67
id-E-RABReleaseListBearerRelComp				ProtocolIE-ID ::= 69
id-cdma2000PDU									ProtocolIE-ID ::= 70
id-cdma2000RATType								ProtocolIE-ID ::= 71
id-cdma2000SectorID								ProtocolIE-ID ::= 72
id-SecurityKey									ProtocolIE-ID ::= 73
id-UERadioCapability							ProtocolIE-ID ::= 74
id-GUMMEI-ID									ProtocolIE-ID ::= 75
id-E-RABInformationListItem						ProtocolIE-ID ::= 78
id-Direct-Forwarding-Path-Availability			ProtocolIE-ID ::= 79
id-UEIdentityIndexValue							ProtocolIE-ID ::= 80
id-cdma2000HOStatus								ProtocolIE-ID ::= 83
id-cdma2000HORequiredIndication					ProtocolIE-ID ::= 84
id-E-UTRAN-Trace-ID								ProtocolIE-ID ::= 86
id-RelativeMMECapacity							ProtocolIE-ID ::= 87
id-SourceMME-UE-S1AP-ID							ProtocolIE-ID ::= 88
id-Bearers-SubjectToStatusTransfer-Item			ProtocolIE-ID ::= 89
id-eNB-StatusTransfer-TransparentContainer		ProtocolIE-ID ::= 90
id-UE-associatedLogicalS1-ConnectionItem		ProtocolIE-ID ::= 91
id-ResetType									ProtocolIE-ID ::= 92
id-UE-associatedLogicalS1-ConnectionListResAck	ProtocolIE-ID ::= 93
id-E-RABToBeSwitchedULItem						ProtocolIE-ID ::= 94
id-E-RABToBeSwitchedULList						ProtocolIE-ID ::= 95
id-S-TMSI										ProtocolIE-ID ::= 96
id-cdma2000OneXRAND								ProtocolIE-ID ::= 97
id-RequestType									ProtocolIE-ID ::= 98
id-UE-S1AP-IDs									ProtocolIE-ID ::= 99
id-EUTRAN-CGI									ProtocolIE-ID ::= 100
id-OverloadResponse								ProtocolIE-ID ::= 101
id-cdma2000OneXSRVCCInfo						ProtocolIE-ID ::= 102
id-E-RABFailedToBeReleasedList					ProtocolIE-ID ::= 103
id-Source-ToTarget-TransparentContainer			ProtocolIE-ID ::= 104
id-ServedGUMMEIs								ProtocolIE-ID ::= 105
id-SubscriberProfileIDforRFP					ProtocolIE-ID ::= 106
id-UESecurityCapabilities						ProtocolIE-ID ::= 107
id-CSFallbackIndicator							ProtocolIE-ID ::= 108
id-CNDomain										ProtocolIE-ID ::= 109
id-E-RABReleasedList							ProtocolIE-ID ::= 110
id-MessageIdentifier							ProtocolIE-ID ::= 111
id-SerialNumber									ProtocolIE-ID ::= 112
id-WarningAreaList								ProtocolIE-ID ::= 113
id-RepetitionPeriod								ProtocolIE-ID ::= 114
id-NumberofBroadcastRequest						ProtocolIE-ID ::= 115
id-WarningType									ProtocolIE-ID ::= 116
id-WarningSecurityInfo							ProtocolIE-ID ::= 117
id-DataCodingScheme								ProtocolIE-ID ::= 118
id-WarningMessageContents						ProtocolIE-ID ::= 119
id-BroadcastCompletedAreaList					ProtocolIE-ID ::= 120
id-Inter-SystemInformationTransferTypeEDT		ProtocolIE-ID ::= 121
id-Inter-SystemInformationTransferTypeMDT		ProtocolIE-ID ::= 122
id-Target-ToSource-TransparentContainer			ProtocolIE-ID ::= 123
id-SRVCCOperationPossible						ProtocolIE-ID ::= 124
id-SRVCCHOIndication							ProtocolIE-ID ::= 125
id-NAS-DownlinkCount							ProtocolIE-ID ::= 126
id-CSG-Id										ProtocolIE-ID ::= 127
id-CSG-IdList									ProtocolIE-ID ::= 128
id-SONConfigurationTransferECT					ProtocolIE-ID ::= 129
id-SONConfigurationTransferMCT					ProtocolIE-ID ::= 130
id-TraceCollectionEntityIPAddress				ProtocolIE-ID ::= 131
id-MSClassmark2									ProtocolIE-ID ::= 132
id-MSClassmark3									ProtocolIE-ID ::= 133
id-RRC-Establishment-Cause						ProtocolIE-ID ::= 134
id-NASSecurityParametersfromE-UTRAN				ProtocolIE-ID ::= 135
id-NASSecurityParameterstoE-UTRAN				ProtocolIE-ID ::= 136
id-DefaultPagingDRX								ProtocolIE-ID ::= 137
id-Source-ToTarget-TransparentContainer-Secondary	ProtocolIE-ID ::= 138
id-Target-ToSource-TransparentContainer-Secondary	ProtocolIE-ID ::= 139
END
*/
