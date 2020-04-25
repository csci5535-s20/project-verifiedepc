package s1ap

/*
other tools used: 
https://crates.io/crates/asn1rs


Reference: 
1. https://thrift.apache.org/docs/idl
2. https://github.com/apache/thrift/blob/af7ecd6a2b15efe5c6b742cf4a9ccb31bcc1f362/doc/specs/thrift-protocol-spec.md

Definition      ::=  Const | Typedef | Enum | Senum | Struct | Union | Exception | Service

BaseType        ::=  'bool' | 'byte' | 'i8' | 'i16' | 'i32' | 'i64' | 'double' | 'string' | 'binary' | 'slist'

ContainerType   ::=  MapType | SetType | ListType

ConstValue      ::=  IntConstant | DoubleConstant | Literal | Identifier | ConstList | ConstMap


Thrift maps the various base and container types to C++ types as follows:

    bool: bool

    binary: std::string

    byte: int8_t

    i16: int16_t

    i32: int32_t

    i64: int64_t

    double: double

    string: std::string

    slist

    list<t1>: std::vector<t1>

    set<t1>: std::set<t1>

    map<t1,t2>: std::map<T1, T2>


You can define enums, which are just 32 bit integers. Values are optional
 * and start at 1 

 Questions: 
 1. When to use bool, byte, binary, string, slist BaseTypes? 
 2. 

*/


 // -----------------------
 // S1AP specification


 enum CriticalityValue{
  REJECT = 1,
  IGNORE = 2,
  NOTIFY = 3
 }

 enum Presence{
  OPTIONAL=1,
  CONDITIONAL=2,
  MANDATORY=3
 }

 union PrivateIEID{	// TODO: Choice, oneof ( is Union correct)
 	1: i16 local,
 	2: string global 	//. TODO:  What should this be? 
 }


 enum TriggeringMessage{
  INITIATING_MESSAGE = 1,
  SUCCESSFUL_OUTCOME = 2,
  UNSUCCESSFULOUTCOME = 3
 }


 enum ProcedureCode{ 					// 2^(8bits) integer
	 PC_HandoverPreparation = 0,			
	 PC_HandoverResourceAllocation = 1,
	 PC_HandoverNotification = 2,
	 PC_PathSwitchRequest = 3,
	 PC_HandoverCancel = 4,
	 PC_E_RABSetup = 5,
	 PC_E_RABModify = 6,
	 PC_E_RABRelease = 7,
	 PC_E_RABReleaseIndication = 8,
	 PC_InitialContextSetup = 9,            // Request, Response
	 PC_Paging = 10,
	 PC_downlinkNASTransport = 11,          //
	 PC_initialUEMessage = 12,              //
	 PC_uplinkNASTransport = 13,            //
	 PC_Reset = 14,
	 PC_ErrorIndication = 15,
	 PC_NASNonDeliveryIndication = 16,
	 PC_S1Setup = 17,                       // Request, Response
	 PC_UEContextReleaseRequest = 18,
	 PC_DownlinkS1cdma2000tunneling = 19,
	 PC_UplinkS1cdma2000tunneling = 20,
	 PC_UEContextModification = 21,
	 PC_UECapabilityInfoIndication = 22,
	 PC_UEContextRelease = 23,
	 PC_eNBStatusTransfer = 24,
	 PC_MMEStatusTransfer = 25,
	 PC_DeactivateTrace = 26,
	 PC_TraceStart = 27,
	 PC_TraceFailureIndication = 28,
	 PC_ENBConfigurationUpdate = 29,
	 PC_MMEConfigurationUpdate = 30,
	 PC_LocationReportingControl = 31,
	 PC_LocationReportingFailureIndication = 32,
	 PC_LocationReport = 33,
	 PC_OverloadStart = 34,
	 PC_OverloadStop  = 35,
	 PC_WriteReplaceWarning     = 36,
	 PC_eNBDirectInformationTransfer  = 37,
	 PC_MMEDirectInformationTransfer   = 38,
	 PC_PrivateMessage = 39,
	 PC_eNBConfigurationTransfer    = 40,
	 PC_MMEConfigurationTransfer    = 41,
	 PC_CellTrafficTrace = 42
	 
	}



enum ProtocolIEID{ 				//TODO: 2^(16bits)
	IE_MME_UE_S1AP_ID					 = 0,   //
	IE_HandoverType						 = 1,
	IE_Cause							 = 2,
	IE_SourceID							 = 3,   ////
	IE_TargetID							 = 4,   ////
	IE_eNB_UE_S1AP_ID					 = 8,   //
	IE_E_RABSubjecttoDataForwardingList	 = 12,
	IE_E_RABtoReleaseListHOCmd			 = 13,
	IE_E_RABDataForwardingItem			 = 14,
	IE_E_RABReleaseItemBearerRelComp	 = 15,
	IE_E_RABToBeSetupListBearerSUReq	 = 16,
	IE_E_RABToBeSetupItemBearerSUReq	 = 17,
	IE_E_RABAdmittedList				 = 18,
	IE_E_RABFailedToSetupListHOReqAck	 = 19,
	IE_E_RABAdmittedItem				 = 20,
	IE_E_RABFailedtoSetupItemHOReqAck	 = 21,
	IE_E_RABToBeSwitchedDLList			 = 22,
	IE_E_RABToBeSwitchedDLItem			 = 23,
	IE_E_RABToBeSetupListCtxtSUReq		 = 24,
	IE_TraceActivation					 = 25,
	IE_NAS_PDU							 = 26,      //
	IE_E_RABToBeSetupItemHOReq			 = 27,      //
	IE_E_RABSetupListBearerSURes		 = 28,
	IE_E_RABFailedToSetupListBearerSURes = 29,
	IE_E_RABToBeModifiedListBearerModReq = 30,
	IE_E_RABModifyListBearerModRes		 = 31,
	IE_E_RABFailedToModifyList			 = 32,
	IE_E_RABToBeReleasedList			 = 33,
	IE_E_RABFailedToReleaseList			 = 34,
	IE_E_RABItem						 = 35,
	IE_E_RABToBeModifiedItemBearerModReq = 36,
	IE_E_RABModifyItemBearerModRes		 = 37,
	IE_E_RABReleaseItem					 = 38,
	IE_E_RABSetupItemBearerSURes		 = 39,
	IE_SecurityContext					 = 40,
	IE_HandoverRestrictionList			 = 41,
	IE_UEPagingID 						 = 43,
	IE_pagingDRX 						 = 44,
	IE_TAIList							 = 46,
	IE_TAIItem							 = 47,
	IE_E_RABFailedToSetupListCtxtSURes	 = 48,
	IE_E_RABReleaseItemHOCmd			 = 49,
	IE_E_RABSetupItemCtxtSURes			 = 50,
	IE_E_RABSetupListCtxtSURes			 = 51,
	IE_E_RABToBeSetupItemCtxtSUReq		 = 52,
	IE_E_RABToBeSetupListHOReq			 = 53,      //
	IE_GERANtoLTEHOInformationRes			 = 55,
	IE_UTRANtoLTEHOInformationRes			 = 57,
	IE_CriticalityDiagnostics 				 = 58,
	IE_Global_ENB_ID						 = 59,  //
	IE_eNBname								 = 60,
	IE_MMEname								 = 61,
	IE_ServedPLMNs							 = 63,  //
	IE_SupportedTAs							 = 64,  //
	IE_TimeToWait							 = 65,
	IE_UEaggregateMaximumBitrate			 = 66,  //
	IE_TAI									 = 67,  //
	IE_E_RABReleaseListBearerRelComp		 = 69,
	IE_cdma2000PDU							 = 70,
	IE_cdma2000RATType						 = 71,
	IE_cdma2000SectorID						 = 72,
	IE_SecurityKey							 = 73,
	IE_UERadioCapability					 = 74,
	IE_GUMMEI_ID							 = 75,
	IE_E_RABInformationListItem				 = 78,
	IE_Direct_Forwarding_Path_Availability	 = 79,
	IE_UEIdentityIndexValue					 = 80,
	IE_cdma2000HOStatus						 = 83,
	IE_cdma2000HORequiredIndication			 = 84,
	IE_E_UTRAN_Trace_ID						 = 86,
	IE_RelativeMMECapacity					 = 87,  //
	IE_SourceMME_UE_S1AP_ID					 = 88,
	IE_Bearers_SubjectToStatusTransfer_Item	 = 89,
	IE_eNB_StatusTransfer_TransparentContainer = 90,
	IE_UE_associatedLogicalS1_ConnectionItem = 91,
	IE_ResetType							 = 92,
	IE_UE_associatedLogicalS1_ConnectionListResAck	 = 93,
	IE_E_RABToBeSwitchedULItem				 = 94,
	IE_E_RABToBeSwitchedULList				 = 95,
	IE_S_TMSI								 = 96,
	IE_cdma2000OneXRAND						 = 97,
	IE_RequestType							 = 98,
	IE_UE_S1AP_IDs							 = 99,
	IE_EUTRAN_CGI							 = 100, //
	IE_OverloadResponse						 = 101,
	IE_cdma2000OneXSRVCCInfo				 = 102,
	IE_E_RABFailedToBeReleasedList			 = 103,
	IE_Source_ToTarget_TransparentContainer	 = 104,
	IE_ServedGUMMEIs						 = 105, //
	IE_SubscriberProfileIDforRFP			 = 106,
	IE_UESecurityCapabilities				 = 107, //
	IE_CSFallbackIndicator					 = 108,
	IE_CNDomain								 = 109,
	IE_E_RABReleasedList					 = 110,
	IE_MessageIdentifier					 = 111,
	IE_SerialNumber							 = 112,
	IE_WarningAreaList						 = 113,
	IE_RepetitionPeriod						 = 114,
	IE_NumberofBroadcastRequest				 = 115,
	IE_WarningType							 = 116,
	IE_WarningSecurityInfo					 = 117,
	IE_DataCodingScheme						 = 118,
	IE_WarningMessageContents				 = 119,
	IE_BroadcastCompletedAreaList			 = 120,
	IE_Inter_SystemInformationTransferTypeEDT = 121,
	IE_Inter_SystemInformationTransferTypeMDT = 122,
	IE_Target_ToSource_TransparentContainer	 = 123,
	IE_SRVCCOperationPossible				 = 124,
	IE_SRVCCHOIndication					 = 125,
	IE_NAS_DownlinkCount					 = 126,
	IE_CSG_Id								 = 127,
	IE_CSG_IdList							 = 128,
	IE_SONConfigurationTransferECT			 = 129,
	IE_SONConfigurationTransferMCT			 = 130,
	IE_TraceCollectionEntityIPAddress		 = 131,
	IE_MSClassmark2							 = 132,
	IE_MSClassmark3							 = 133,
	IE_RRC_Establishment_Cause				 = 134,
	IE_NASSecurityParametersfromE_UTRAN		 = 135,
	IE_NASSecurityParameterstoE_UTRAN		 = 136,
	IE_DefaultPagingDRX						 = 137,     //
	IE_Source_ToTarget_TransparentContainer_Secondary	 = 138,
	IE_Target_ToSource_TransparentContainer_Secondary	 = 139

}
 
// ********************************************************
// CONSTANTS: 
/* TODO: Need to insert/initialize the Constant Values
struct ConstLists {
  // Map from feature name to feature list.
  map<string, FeatureList> constants_list = 1;
}*/

 const  i32 maxPrivateIEs 					= 65535;
 const  i32 maxProtocolExtensions 			= 65535;
 const  i32 maxProtocolIEs					= 65535;
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



// **************************************************************
struct S1apProtocolIEs{
	1: required ProtocolIEID id,		//UNIQUE
	2: Criticality criticality,
	3: Value 	value,
	4: Presence presence
}


struct S1apProtocolIEsPair{
	1: required ProtocolIEID id;			//UNIQUE
	2: Criticality first_criticality;
	3: Value first_value;
	4: Criticality second_criticality;
	5: Value second_value;
	6: Presence presence

}

struct S1apProtocolExtension{
	1: required ProtocolIEID id;			//UNIQUE
	2: Criticality criticality;
	3: Extension extension;
	4: Presence presence 
}

struct S1apPrivateIEs{
	1: required ProtocolIEID id;
	2: Criticality criticality;
	3: Value value;
	4: Presence presence
}


// *************************************
// Dependent Types being defined here. 
// TODO: Modify/chagne/delete these as we might not be using this. 
// *************************************



typedef S1apProtocolIEs ProtocolIEField

typedef ProtocolIEField ProtocolIESingleContainer

//TODO: size(maxProtocolIEs)
typedef list<ProtocolIEField maxProtocolIEs> ProtocolIEContainer

typedef S1apProtocolIEsPair ProtocolIEFieldPair

typedef list<ProtocolIEFieldPair maxProtocolIEs>ProtocolIEContainerPair;// TODO: size(maxProtocolIEs)


//TODO: size(loowerBound,upperBound)
typedef list<ProtocolIESingleContainer>ProtocolIEContainerList


//TODO: size(LowerBound, UpperBound)
typedef list<ProtocolIEContainerPair> ProtocolIEContainerPairList

typedef S1apProtocolExtension ProtocolExtensionField

typedef list<ProtocolExtensionField maxProtocolExtensionContainer> ProtocolExtensionContainer // TODO: size(maxProtocolExtensions)


typedef S1apPrivateIEs PrivateIEField

typedef list<PrivateIEField maxPrivateIEs> PrivateIEContainer //TODO: size(maxPrivateIEs)


// *************************************
// S1AP-IEs
// *************************************



// -- A

struct AllocationAndRetentionPriority{
	1: PriorityLevel 			priority_level;
	2: PreEmptionCapability 	pre_emption_capability;
	3: PreEmptionVulnerability 	pre_emption_vulnerability;
	4: optional ProtocolExtensionContainer ie_extensions; // TODO: Verify this
}



// -- B

// not handling unnecessary ones. 

typedef i64 BitRate

typedef PLMNidentity BPLMNs

union BroadcastCompletedAreaList{
	1: CellIDBroadcast 			cellID_broadcast;
	2: TAIBroadcast 				tAI_broadcast;
	3: EmergencyAreaIDBroadcast 	emergency_areaID_broadcast;
}

union Cause{
	1: CauseRadioNetwork radioNetwork;
	2: CauseTransport	transport;
	3: CauseNas 		nas;
	4: CauseProtocol 	protocol;
	5: optional CauseMisc 	misc;
}

enum CauseMisc{
	
	CONTROL_PROCESSING_OVERLOAD,
	NOT_ENOUGH_USER_PLANE_PROCESSING_RESOURCES,
	HARDWARE_FAILURE,
	OM_INTERVENTION,
	UNSPECIFIED,
	UNKNOWN_PLMN
}

enum CauseProtocol{

	TRANSFER_SYNTAX_ERROR,
	ABSTRACT_SYNTAX_ERROR_REJECT,
	ABSTRACT_SYNTAX_ERROR_IGNORE_AND_NOTIFY,
	MESSAGE_NOT_COMPATIBLE_WITH_RECEIVER_STATE,
	SEMANTIC_ERROR,
	ABSTRACT_SYNTAX_ERROR_FALSELY_CONSTRUCTED_MESSAGE,
	UNSPECIFIED	

}

enum CauseRadioNetwork{  // TODO: Complete list
	UNSPECIFIED,
	SUCCESSFUL_HANDOVER
	}

enum CauseTransport {
	TRANSPORT_RESOURCE_UNAVAILABLE,
	UNSPECIFIED

}

enum CauseNas{
	NORMAL_RELEASE,
	AUTHENTICATION_FAILURE,
	DETACH,
	UNSPECIFIED
}

typedef string CellIdentity

typedef list<CellID-Broadcast-Item> CellIDBroadcast

struct CellIDBroadcastItem{
	1: EUTRAN-CGI 			eCGI;
	2: optional list<CellIDBroadcastItemExtIEs> ie_extensions;
}



typedef string Cdma2000PDU 	// OCTET STRING

enum Cdma2000RATType{
	H_RPD,
	ONEX_RTT,
}

typedef string Cdma2000SectorID
enum Cdma2000HOStatus {
	HO_SUCCESS,
	HO_FAILURE
}

enum Cdma2000HORequiredIndication {
	TRUE,
	FALSE
}

typedef string Cdma2000OneXMEID // OCTET STRING

typedef string Cdma2000OneXMSI // OCTET STRING

typedef string Cdma2000OneXPilot // OCTET STRING

typedef string Cdma2000OneXRAND // OCTET STRING



struct Cdma2000OneXSRVCCInfo{
	1: Cdma2000OneXMEID 		cdma2000OneXMEID;
	2: Cdma2000OneXMSI			cdma2000OneXMSI;
	3: Cdma2000OneXPilot		cdma2000OneXPilot;
	4: optional list<Cdma2000OneXSRVCCInfoExtIEs> ie_extensions;
}

enum CellSize{
	VERYSMALL, 
	SMALL,
	MEDIUM,
	LARGE
}


struct CellType{
	1: CellSize 		cell_size;
	2: optional list<CellTypeExtIEs> ie_extensions;
}


typedef string CI 		// OCTET STRING (SIZE (2))

struct CGI{
	1: PLMNidentity 	plmn_identity;
	2: LAC 				lac;
	3: CI 				ci;
	4: RAC 				rac;
	5: optional list<CGIextIEs>	ie_extensions;

}


enum CNDomain{
	PS, 
	CS 
}

enum CSFallbackIndicator{ 
	CS_FALLBACK_REQUIRED,
	CS_FALLBACK_HIGH_PRIORITY
}

//TODO: Is this the right way to do this? 
typedef binary CSGId // BIT STRING SIZE(27)



struct CSGIdListItem{
	1: CSGId 				csg_id;
	2: optional list<CSGIdListItemExtIEs> ie_extensions;
}

typedef list<CSGIdListItem maxNrOfCSGs> CSGIdList 		//TODO: size(maxNrOfCSGs)

struct COUNTvalue{
	1: PDCP_SN 		pdcp_sn;
	2: HFN 			hfn;
	3: optional list<COUNTvalueExtIEs> ie_extensions;
}


struct CriticalityDiagnostics{
	1: optional ProcedureCode 			procedure_code;
	2: optional TriggeringMessage 		triggering_message;
	3: optional Criticality 			triggering_criticiality;
	4: optional CriticalityDiagnosticsIEList 	ies_criticality_diagnostics;
	5: optional list<CriticalityDiagnosticsExtIEs> ie_extensions;
}


//TODO: size(maxNrOfErrors)
typedef list<CriticalityDiagnosticsIEItem maxNrOfErrors>CriticalityDiagnosticsIEList


struct CriticalityDiagnosticsIEItem{
	1: Criticality 			ie_criticality;
	2: ProtocolIEID 		ie_id;
	3: TypeOfError 			type_of_error;
	4: optional list<CriticalityDiagnosticsIEItemExtIEs> ie_extensions;
}

// -- D

// TODO: Veify structure
typedef binary DataCodingScheme 	// BIT STRING Size(8)
//typedef string DataCodingScheme

enum DLForwarding{
	DL_FORWARDING_PROPOSED,
}

enum DirectForwardingPathAvailability{
	DIRECT_PATH_AVAILABLE,
}

// -- E


//TODO : size(maxnoofCellID)
typedef list<EUTRANCGI maxnoofCellID> ECGIList

typedef string EmergencyAreaID 	//OCTET STRING SIZE 3

typedef list<EmergencyAreaID> EmergencyAreaIDList



// TODO: size(maxnoofEmergencyAreaID)
typedef list<EmergencyAreaIDBroadcastItem maxnoofEmergencyAreaID> EmergencyAreaID-Broadcast



struct EmergencyAreaIDBroadcastItem{
	1: EmergencyAreaID 			emergency_area_id;
	2: CompletedCellInEAI 		completed_cell_in_eai;
	3: optional list<EmergencyAreaIDBroadcastItemExtIEs> ie_extensions;
}


//TODO: size(maxnoofCellinEAI)
typedef listCompletedCellinEAIItem maxnoofCellinEAI> CompletedCellinEAI

struct CompletedCellinEAIItem{
	1: EUTRANCGI 			ecgi;
	2: optional list<CompletedCellinEAIItemExtIEs> ie_extensions;
}


union ENBID{
	1: string macro_enb_id; 	//BIT STRING (SIZE(20))
	2: string home_enb_id; 		// BIT STRING (SIZE(28)),
}


struct ENBStatusTransferTransparentContainer{
	1: BearersSubjectToStatusTransferList bearers_subject_to_status_transfer_list;
	2: optional list<ENBStatusTransferTransparentContainerExtIEs> ie_extensions;
}

typedef string ENBName //(SIZE (1..150,...))

typedef i64 ENB_UE_S1AP_ID // INTEGER (0..16777215)


// TODO: size(maxnoofeNBX2TLAs)
typedef list<TransportLayerAddress maxnoofeNBX2TLAs> ENBX2TLAs 

typedef binary EncryptionAlgorithms // BIT STRING (SIZE (16,...))

// TODO: size(maxnoofEPLMNs)
typedef list<PLMNIdentity maxnoofEPLMNs> EPLMNs

enum EventType {
 	DIRECT,
 	CHANGE_OF_SERVE_CELL,
 	STOP_CHANGE_OF_SERVE_CELL,
}


union E_RAB_ID {	 	// INTEGER (0..15, ...)
	1: i8 	id_1;
	2: i64 	id_2;
}

 
//TODO: size(maxNrOfE_RABs)
typedef list<ERABInformationListIEs maxNrOfE-RABs> ERABInformationList

//TODO: How to do this? 

typedef ERAB

/* TODO: How to modify this? 
E-RABInformationListIEs S1AP-PROTOCOL-IES ::= {
	{ ID id-E-RABInformationListItem			CRITICALITY ignore	TYPE E-RABInformationListItem			PRESENCE mandatory	},
	...
}
*/

struct ERABInformationListItem{
	1: E_RAB_ID 			e_rab_id;
	2: optional DLForwarding dl_forwarding; 
	3: optional list<ERABInformationListItemExtIEs> ie_extensions;
}





// -- G


struct GERANCellID{
	1: LAI 			lai;
	2: RAC 			rac;
	3: CI 			ci;
	4: optional list<GERANCellIDExtIEs> ie_extensions; 

}

struct GlobalENBID{
	1: PLMNIdentity 	plmn_identity; 
	2: ENBID 			enb_id; 
	3: optional list<globalENBIDExtIEs> ie_extensions;
}


// TODO: size(maxNrOfE-RABs)
typedef list<ERABItemIEs maxNrOfE_RABs> ERABList

 
/* TODO: How to handle this? 
E-RABItemIEs 	S1AP-PROTOCOL-IES ::= {
	{ ID id-E-RABItem	 CRITICALITY ignore 	TYPE E-RABItem 	PRESENCE mandatory },
	...
}
*/

struct ERABItem{
	1: E_RAB_ID 			e_rab_id;
	2: Cause 				cause;
	3: optional list<ERABItemExtIEs> ie_extensions;
}


struct ERABLevelQoSParameters{
	1: QCI 									qci; 
	2: AllocationAndRetentionPriority 		allocation_retention_priority;
	3: optional GBRQosInformation 			gbr_qos_information;
	4: optional list<ERABQoSParametersExtIEs> ie_extensions
}


struct EUTRANCGI{
	1: PLMNIdentity plmn_identity; 
	2: CellIdentity cell_identity; 
	3: optional list<EUTRANCGIExtIEs> ie_extensions; 

}

typedef i16 ExtendedRNC-ID.  // INTEGER (4096..65535)


// -- F

enum ForbiddenInterRATs{
	ALL, 
	GERAN,
	UTRAN,
	CDMA2000

}

typedef list<ForbiddenTAsItem maxnoofEPLMNsPlusOne> ForbiddenTAs


struct ForbiddenTAsItem{
	1: PLMNIdentity 		plmn_identity;
	2: ForbiddenTACs 		forbidden_tacs;
	3; optional list<ForbiddenTAsItemExtIEs> ie_extensions;
}


//TODO: size(maxnoofForbTACs)
typedef list<TAC maxnoofForbTACs> ForbiddenTACs


//TODO: size(maxnoofEPLMNsPlusOne)
typedef list<ForbiddenLAsItem maxnoofEPLMNsPlusOne> ForbiddenLAs


struct ForbiddenLAsItem{
	1: PLMNIdentity 	plmn_identity;
	2: ForbiddenLACs 	forbidden_identity;
	3: optional list<ForbiddenLAsItemExtIEs> 	ie_extensions;
}

# TODO: size(maxnoofForbLACs)
typedef list<LAC maxnoofForbLACs> ForbiddenLACs

// -- G

struct GBR-QosInformation {
	1: BitRate e_rab_maximum_bitrate_dl; 
	2: BitRate e_rab_guaranteed_bitrate_dl; 
	3: BitRate e_rab_guaranteed_bitrate_dl; 
	4: optional list<GBRQosInformationExtIEs> ie_extensions;
}



typedef binary GTP-TEID   // OCTET STRING (SIZE (4))

struct GUMMEI {
	1: PLMNIdentity 	plmn_identity; 
	2: MMEGroupID   	mme_group_id;
	3: MMECode 			mme_code; 
	4: optional list<GUMMEIExtIEs> ie_extensions;

}



-- H

struct HandoverRestrictionList{
	1: PLMNIdentity 		serving_plmn;
	2: optional EPLMNs 		equivalent_plmns;
	3: optional ForbiddenTAs forbidden_tas;
	4: optional ForbiddenLAs forbidden_las;
	5: optional ForbiddenInterRATs forbidden_inter_rats;
	6: optional list<HandoverRestrictionListExtIEs> ie_extensions; 
}


enum HandoverType{
	INTRALTE,
	LTETOUTRAN,
	LTETOGERAN,
	UTRANTOLTE,
	GERANTOLTE,
}

typedef i32 HFN // INTEGER (0..1048575)


// -- I

typedef binary IMSI // OCTET STRING (SIZE (3..8))

typedef binary IntegrityProtectionAlgorithms // BIT STRING (SIZE (16,...))

typedef binary InterfacesToTrace //BIT STRING (SIZE (8))


// -- L

typedef binary LAC //OCTET STRING (SIZE (2))

struct LAI{
	1: PLMNIdentity 	plmn_identity;
	2: LAC 				lac;
	3: optional list<LAIExtIEs> ie_extensions;
}


union LastVisitedCellItem{
	1: LastVisitedEUTRANCellInformation e_utran_cell;
	2: LastVisitedUTRANCellInformation utran_cell;
	3: LastVisitedGERANCellInformation geran_cell; 
}


struct LastVisitedEUTRANCellInformation{
	1: EUTRANCGI 	global_cell_id; 
	2: CellType 	cell_type; 
	3: TimeUEStayedInCell time_ue_stayed_in_cell;
	4: optional list<LastVisitedEUTRANCellInformationExtIEs> ie_extensions;
}


typedef binary LastVisitedUTRANCellInformation	 //TODO: OCTET STRING

union LastVisitedGERANCellInformation {
	1: NULL undefined;
}

typedef binary L3Information  // OCTET STRING

// -- M

// TODO: size(16)
typedef binary MessageIdentifier   // BIT STRING (SIZE (16))

typedef string MMEName // PrintableString (SIZE (1..150,...))

//TODO: size(2)
typedef binary MMEGroupID  // OCTET STRING (SIZE (2))

typedef byte MMECode // OCTET STRING (SIZE (1))

typedef i64 MMEUES1APID	 //INTEGER (0..4294967295)

// TODO: size(4)
typedef binary MTMSI	//OCTET STRING (SIZE (4))

typedef string MSClassmark2 	// OCTET STRING
typedef string MSClassmark3 	// OCTET STRING

//-- N

typedef binary NASPDU	//OCTET STRING

typedef binary NASSecurityParametersfromEUTRAN //OCTET STRING

typedef binary NASSecurityParameterstoEUTRAN //OCTET STRING

typedef i16 NumberofBroadcastRequest //INTEGER (0..65535)

typedef i16 NumberofBroadcast //INTEGER (0..65535)


// -- O
typedef binary OldBSSToNewBSSInformation //OCTET STRING

enum OverloadAction{
	REJECT_NON_EMERGENCY_MO_DT,
	RERJECT_ALL_RRC_CR_SIGNALLING,
	PERMIT_EMERGENCY_SESSIONS_ONLY,
}

union OverloadResponse{
	1: OverloadAction 	overload_action;
}

// 
-- P

enum PagingDRX{
	V32,
	V64,
	V128,
	v256,
	}

typedef i16 PDCPSN //INTEGER (0..4095) 

typedef TBCDString  PLMNIdentity

enum PreEmptionCapability{
	SHALL_NOT_TRIGGER_PRE_EMPTION,
	MAY_TRIGGER_PRE_EMPTION,
}

enum PreEmptionVulnerability{
	NOT_PRE_EMPTABLE,
	PRE_EMPTABLE,
}

/*

TODO: PRIORITY_LEVEL:  INTEGER { spare (0), highest (1), lowest (14), no-priority (15) } (0..15)

typedef Map<string, binary> PriorityLevel = {"SPARE":0x0, "HIGHER":0x1, "LOWEST":0xE, "NO_PRIORITY":0xF}
*/

enum PriorityLevel{
	SPARE=0,
	HIGHER=1,
	LOWEST=14,
	NO_PRIORITY=15
}				


// -- Q

typedef i8 QCI  // ::= INTEGER (0..255)

// -- R

typedef binary ReceiveStatusofULPDCPSDUs //BIT STRING (SIZE(4096))

typedef i8 RelativeMMECapacity //INTEGER (0..255)

typedef binary RAC // OCTET STRING (SIZE (1))


struct RequestType{
	1: EventType 			event_type;
	2: ReportArea 			report_area;
	3: optional list<RequestTypeExtIEs> ie_extensions; 
}


struct RIMTransfer{
	1: RIMInformation 				rim_information;
	2: optional RIMRoutingAddress 	rim_routing_address;
	3: optional list<RIMTransferExtIEs> ie_extensions;
}


typedef binary RIMInformation //::= OCTET STRING

union RIMRoutingAddress{
	1: GERANCellID geran_cell_id;
}

enum ReportArea{
	ECGI,
}

typedef i16 RepetitionPeriod //::= INTEGER (0..4095)



typedef i16 RNC-ID  // INTEGER (0..4095)

typedef binary RRC-Container   //	::= OCTET STRING

enum RRCEstablishmentCause{
	EMERGENCY,
	HIGH_PRIORITY_ACCESS,
	MT_ACCESS,
	MO_SIGNALLING,
	MO_DATA,
}

//-- S


typedef binary SecurityKey  // BIT STRING (SIZE(256))



struct SecurityContext{
	1: i8 next_hop_chaining_count;			// TODO: INTEGER (0..7),
	2: SecurityKey next_hop_parameter;
	3: optional list<SecurityContextExtIEs> ie_extensions;
}



typedef binary SerialNumber  // BIT STRING (SIZE (16))

union SONInformation{
	1: SONInformationRequest 	son_information_request;
	2: SONInformationReply 		son_information_reply;
}


enum SONInformationRequest{ 
	X2TNL_CONFIGURATION_INFO
}

struct SONInformationReply{
	1: optional X2TNLConfigurationInfo x2tnl_configuration_info;
	2: optional list<SONInformationReplyExtIEs> ie_extensions;

}

struct SONConfigurationTransfer{
	1: TargeteNBID 					target_enb_id; 
	2: SourceeNB-ID					source_enb_id;
	3: SONInformation 				son_information; 
	4: optional list<SONConfigurationTransferExtIEs> ie_extensions;

}


// ------------------------------
// S1AP-PROTOCOL-EXTENSION

typedef S1apProtocolExtension AllocationAndRetentionPriorityExtIEs
typedef S1apProtocolExtension CellIDBroadcastItemExtIEs
typedef S1apProtocolExtension Cdma2000OneXSRVCCInfoExtIEs
typedef S1apProtocolExtension CellTypeExtIEs
typedef S1apProtocolExtension CGIExtIEs
typedef S1apProtocolExtension CSGIdListItemExtIEs
typedef S1apProtocolExtension COUNTvalueExtIEs
typedef S1apProtocolExtension CriticalityDiagnosticsExtIEs
typedef S1apProtocolExtension CriticalityDiagnosticsIEItemExtIEs 

typedef S1apProtocolExtension EmergencyAreaIDBroadcastItemExtIEs
typedef S1apProtocolExtension CompletedCellinEAIItemExtIEs
typedef S1apProtocolExtension GERANCellIDExtIEs
typedef S1apProtocolExtension GlobalENBIDExtIEs


typedef S1apProtocolExtension ENBStatusTransferTransparentContainerExtIEs
typedef S1apProtocolExtension ERABInformationListIEs

typedef S1apProtocolExtension ERABInformationListItemExtIEs
typedef S1apProtocolExtension ERABItemExtIEs

typedef S1apProtocolExtension ERABQoSParametersExtIEs
typedef S1apProtocolExtension EUTRANCGIExtIEs

typedef S1apProtocolExtension ForbiddenTAsItemExtIEs
typedef S1apProtocolExtension ForbiddenLAsItemExtIEs

typedef S1apProtocolExtension GBRQosInformationExtIEs

typedef S1apProtocolExtension GUMMEIExtIEs

typedef S1apProtocolExtension HandoverRestrictionListExtIEs

typedef S1apProtocolExtension LAIExtIEs

typedef S1apProtocolExtension LastVisitedEUTRANCellInformationExtIEs 

typedef S1apProtocolExtension RequestTypeExtIEs
typedef S1apProtocolExtension RIMTransferExtIEs 

typedef S1apProtocolExtension SecurityContextExtIEs

typedef S1apProtocolExtension SONConfigurationTransferExtIEs
typedef S1apProtocolExtension SONInformationReplyExtIEs 
// ------------------------------



