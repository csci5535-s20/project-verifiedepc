//S1AP-IE Definitions
/*

-- **************************************************************
--
-- Information Element Definitions
--
-- **************************************************************

S1AP-IEs { 
itu-t (0) identified-organization (4) etsi (0) mobileDomain (0) 
eps-Access (21) modules (3) s1ap (1) version1 (1) s1ap-IEs (2) }

DEFINITIONS AUTOMATIC TAGS ::= 

BEGIN


IMPORTS
	id-E-RABInformationListItem, 					--> ID_E_RABInformationListItem_PIEID
	id-E-RABItem, 									--> ID_E_RABItem_PIEID
	id-Bearers-SubjectToStatusTransfer-Item, 		--> ID_Bearers_SubjectToStatusTransfer_Item_PIEID
	maxNrOfCSGs,
	maxNrOfE-RABs,
	maxNrOfErrors,
	maxnoofBPLMNs,
	maxnoofPLMNsPerMME,
	maxnoofTACs,
	maxnoofEPLMNs,
	maxnoofEPLMNsPlusOne,
	maxnoofForbLACs,
	maxnoofForbTACs,
	maxnoofCells,
	maxnoofCellID,
	maxnoofEmergencyAreaID,
	maxnoofTAIforWarning,
	maxnoofCellinTAI,
	maxnoofCellinEAI,
	maxnoofeNBX2TLAs,
	maxnoofRATs,
	maxnoofGroupIDs,
	maxnoofMMECs
FROM S1AP-Constants

	Criticality,
	ProcedureCode,
	ProtocolIE-ID,							--> ProtocolIEID
	TriggeringMessage
FROM S1AP-CommonDataTypes

	ProtocolExtensionContainer{}, 			--> ProtocolExtensionContainer
	S1AP-PROTOCOL-EXTENSION,				--> S1apProtocolExtension
	ProtocolIE-SingleContainer{}, 			--> ProtocolIESingleContainer
	S1AP-PROTOCOL-IES 						--> S1apProtocolIES
FROM S1AP-Containers;	
*/



// *************************************
// S1AP-IEs
// *************************************


include "s1ap_constants.thrift"


// -- A

struct AllocationAndRetentionPriority{
	1: PriorityLevel 			priority_level;
	2: PreEmptionCapability 	pre_emption_capability;
	3: PreEmptionVulnerability 	pre_emption_vulnerability;
	4: optional ProtocolExtensionContainer ie_extensions; // TODO: Verify this
}



// -- B

// TODO: size(maxNrOfE-RABs)
typedef list<BearersSubjectToStatusTransferItemIEs> BearersSubjectToStatusTransferList 



struct BearersSubjectToStatusTransferItem{
	1: ERABID 								e_rab_id;
	2: COUNTValue 							ul_count_value;
	3: COUNTValue 							dl_count_value; 
	4: optional ReceiveStatusOfULPDCPSDUs 	receive_status_of_ul_pdcpsdus;
	5: optional list<BearersSubjectToStatusTransferItemExtIEs> ie_extensions; 
}


typedef i64 BitRate

typedef PLMNidentity BPLMNs

union BroadcastCompletedAreaList{
	1: CellIDBroadcast 			cellID_broadcast;
	2: TAIBroadcast 				tAI_broadcast;
	3: EmergencyAreaIDBroadcast 	emergency_areaID_broadcast;
}

// -- C

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
typedef list<EUTRAN_CGI maxnoofCellID> ECGIList

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
	1: EUTRAN_CGI 			ecgi;
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



struct ERABInformationListItem{
	1: E_RAB_ID 			e_rab_id;
	2: optional DLForwarding dl_forwarding; 
	3: optional list<ERABInformationListItemExtIEs> ie_extensions;
}





// TODO: size(maxNrOfE-RABs)
typedef list<ERABItemIEs maxNrOfE_RABs> ERABList





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


struct EUTRAN_CGI{
	1: PLMNIdentity plmn_identity; 
	2: CellIdentity cell_identity; 
	3: optional list<EUTRAN_CGIExtIEs> ie_extensions; 

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
	1: EUTRAN_CGI 	global_cell_id; 
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

typedef i64 MME_UE_S1AP_ID	 //INTEGER (0..4294967295).  MMEUES1APID

// TODO: size(4)
typedef binary MTMSI	//OCTET STRING (SIZE (4))

typedef string MSClassmark2 	// OCTET STRING
typedef string MSClassmark3 	// OCTET STRING

//-- N

typedef binary NAS_PDU	//OCTET STRING

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

// -- P

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


typedef binary SourceToTargetTransparentContainer //::= OCTET STRING

typedef binary SourceBSSToTargetBSSTransparentContainer //::= OCTET STRING

struct SourceeNBID{
	1: GlobalENBID 			global_enb_id;
	2: TAI 					selected_tai;
	3: optional list<SourceeNBIDExtIEs> ie_extensions; 
}


enum SRVCCOperationPossible{
	POSSIBLE,
}

enum SRVCCHOIndication{
	PS_AND_CS,
	CS_ONLY,
}



struct SourceeNBToTargeteNBTransparentContainer{
	1: RRCContainer 					rrc_container;
	2: optional ERABInformationList 	e_rab_information_list;
	3: EUTRAN_CGI 						target_cell_id;
	4: optional SubscriberProfileIDforRFP subscriberr_profile_id_for_rfp;
	5: UEHistoryInformation 			ue_history_information;
	6: optional list<SourceeNBToTargeteNBTransparentContainerExtIEs>  ie_extensions;

}



typedef binary SourceRNCToTargetRNCTransparentContainer		//::= OCTET STRING


//TODO: size(maxnoofRATs)
typedef list<ServedGUMMEIsItem maxnoofRATs> ServedGUMMEIs 


struct ServedGUMMEIsItem{
	1: ServedPLMNs 			served_plmns;
	2: ServedGroupIDs 		served_group_ids;
	3: ServedMMECs 			served_mmecs;
	4: optional list<ServedGUMMEIsItemExtIEs> ie_extensions;
}


//TODO: size(maxnoofGroupIDs)
typedef list<MMEGroupID> ServedGroupIDs


//TODO : size(maxnoofMMECs) ServedMMECs
typedef list<MMECode> ServedMMECs

//TODO: size(maxnoofPLMNsPerMME)
typedef list<PLMNidentity> ServedPLMNs

typedef i8 SubscriberProfileIDforRFP //INTEGER (1..256) 

//TODO: size(maxnoofTACs)
typedef list<SupportedTAsItem> SupportedTAs

struct SupportedTAsItem{
	1: TAC 				tac;
	2: BPLMNs 			broadcastPLMNs;
	3: optional list<SupportedTAsItemExtIEs> ie_extensions;
}

struct S_TMSI{
	1: MMECode 			mmec;
	2: MTMSI 			m_tmsi;
	3: optional list<STMSIExtIEs> ie_extensions;

}


-- T

typedef binary TAC //::= OCTET STRING (SIZE (2))

//TODO: size(maxnoofTAIforWarning)
typedef list<TAI> TAIListforWarning


struct TAI{
	1: PLMNIdentity 		plmn_identity;
	2: TAC 					tac;
	3: optional list<TAIExtIEs> ie_extensions; 
}

//TODO: size(maxnoofTAIforWarning)
typedef list<TAIBroadcastItem> TAIBroadcast 



struct TAIBroadcastItem{
	1: TAI 					tai;
	2: CompletedCellinTAI 		completed_cell_in_tai;
	3: optional list<TAIBroadcastItemExtIEs> ie_extensions; 
}


//TODO: size(maxnoofCellinTAI)
typedef list<CompletedCellinTAIItem> CompletedCellinTAI

struct CompletedCellinTAIItem{
	1: EUTRAN_CGI 				e_cgi;
	2: optional list<CompletedCellinTAIItemExtIEs> ie_extensions; 
}




typedef binary TBCDString //::= OCTET STRING (SIZE (3))

union TargetID{
	1: TargeteNBID 		target_enb_id; 
	2: TargetRNCID 		target_rnc_id;
	3: CGI 				cgi; 
}

struct TargeteNB-ID{
	1: GlobalENBID 			global_enb_id;
	2:  TAI 				selected_tai;
	3: optional list<TargeteNBIDExtIEs> ie_extensions; 
}

struct TargetRNCID{
	1: LAI 				lai;
	2: RAC 				rac;
	3: RNCID 			rnc_id; 
	4: optional ExtendedRNCID 	extended_rnc_id;
	5: optional list<TargetRNCIDExtIEs> ie_extensions; 
	}




stuct TargeteNBToSourceeNBTransparentContainer{
	1: RRCContainer 			rrc_container;
	2: optional list<TargeteNBToSourceeNBTransparentContainerExtIEs> ie_extensions; 
}


typedef list<byte> TargetToSourceTransparentContainer //OCTET STRING
typedef list<byte> TargetRNCToSourceRNCTransparentContainer		// OCTET STRING
typedef list<byte> TargetBSSToSourceBSSTransparentContainer // OCTET STRING

enum TimeToWait{
	V1S, 
	V2S,
	V5S, 
	V10S,
	V20S,
	V60S,
}

typedef i8  TimeUEStayedInCell // INTEGER (0..4095)

typedef binary TransportLayerAddress  // BIT STRING (SIZE(1..160, ...))

struct TraceActivation {
	1: EUTRANTraceID 			eutran_trace_id;
	2: InterfacesToTrace 		interfaces_to_trace;
	3: TraceDepth 				trace_depth;
	4: TransportLayerAddress 	trace_collection_entity_ip_address;
	5: optional list<TraceActivationExtIEs> ie_extensions; 
}



enum TraceDepth{ 
	MINIMUM,
	MEDIUM,
	MAXIMUM,
	MINIMUM_WITHOUT_VENDOR_SPECIFIC_EXTENSION,
	MEDIUM_WITHOUT_VENDOR_SPECIFIC_EXTENSION,
	MAXIMUM_WITHOUT_VENDOR_SPECIFIC_EXTENSION,
}


//TODO : size(8)
typedef list<byte> EUTRANTraceID  //  OCTET STRING (SIZE (8))

enum  TypeOfError{
	NOT_UNDERSTOOD,
	MISSING,
}


-- U

struct UEAggregateMaximumBitrate{
	1: BitRate 					ue_aggregate_maximum_bitrate_dl;
	2: BitRate 	 				ue_aggregate_maximum_bitrate_ul;
	3: optional list<UEAggregateMaximumBitratesExtIEs> ie_extensions;
}


union UES1APIDS{
	1: UES1APIDPair 		ue_s1ap_id_pair;
	2: MME_UE_S1AP_ID		mme_ue_s1ap_id;
}

struct UE_S1APIDPair{
	1: MME_UE_S1AP_ID 		mme_ue_s1ap_id;
	2: ENB_UE_S1AP_ID 		enb_ue_s1ap_id;
	3: optional list<UES1APIDPairExtIEs> ie_extensions; 
}


struct UEassociatedLogicalS1ConnectionItem{
	1: optional MME_UE_S1AP_ID 		mme_ue_s1ap_id;
	2: optional ENB_UE_S1AP_ID  		enb_ue_s1ap_id;
	3: optional list<UEAssociatedLogicalS1ConnectionItemExtIEs> ie_extensions; 
}

//TODO: size(10)
typedef binary UEIdentityIndexValue	//BIT STRING (SIZE (10))



// TODO: size(maxnoofCells)
typedef list<LastVisitedCellItem> UE-HistoryInformation 

union UEPagingID{
	1: S_TMSI 		s_tmsi;
	2: IMSI 		imsi;
	}

typedef list<byte> UERadioCapability //OCTET STRING

struct UESecurityCapabilities{
	1: EncryptionAlgorithms 			encryption_algorithms,
	2: IntegrityProtectionAlgorithms 	integrity_protection_algorithms,
	3: optional list<UESecurityCapabilitiesExtIEs> ie_extensions;
}

-- W

union WarningAreaList{
	1: ECGIList 					cell_id_list;
	2: TAIListforWarning 			tracking_area_list_for_warning;
	3: EmergencyAreaIDList 			emergency_area_id_list;

}


typedef list<byte> WarningType //OCTET STRING (SIZE (2))

typedef list<byte> WarningSecurityInfo //OCTET STRING (SIZE (50))


typedef list<byte> WarningMessageContents  //OCTET STRING (SIZE(1..9600))


// -- X


struct X2TNLConfigurationInfo{
	1: ENBX2TLAs 					enb_x2_transport_layer_address;
	2: optional list<X2TNLConfigurationInfoExtIEs> ie_extensions;
}


// ------------------------------
// S1AP-PROTOCOL-IE

typedef S1apProtocolIES BearersSubjectToStatusTransferItemIEs = {"id": ID_Bearers_SubjectToStatusTransfer_Item_PIEID, "criticality": Criticality.IGNORE, "type": BearersSubjectToStatusTransferItem, "presence": Presence.MANDATORY}


typedef S1apProtocolIES ERABInformationListIEs = {"id": ID_E_RABInformationListItem_PIEID, "criticality": Criticality.IGNORE , "type": ERABInformationListItem, "presence": Presence.MANDATORY}

typedef S1apProtocolIES ERABItemIEs = {"id": ID_E_RABItem_PIEID, "criticality": Criticality.IGNORE, "type": ERABItem, "presence": Presence.MANDATORY}

// ------------------------------
// S1AP-PROTOCOL-EXTENSION

typedef S1apProtocolExtension AllocationAndRetentionPriorityExtIEs

typedef S1apProtocolExtension BearersSubjectToStatusTransferItemExtIEs

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
typedef S1apProtocolExtension EUTRAN_CGIExtIEs

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

typedef S1apProtocolExtension SourceeNBIDExtIEs

typedef S1apProtocolExtension ServedGUMMEIsItemExtIEs 
typedef S1apProtocolExtension SourceeNBToTargeteNBTransparentContainerExtIEs
typedef S1apProtocolExtension STMSIExtIEs 

typedef S1apProtocolExtension SupportedTAsItemExtIEs

typedef S1apProtocolExtension TAIExtIEs
typedef S1apProtocolExtension TAIBroadcastItemExtIEs
typedef S1apProtocolExtension CompletedCellinTAIItemExtIEs 


typedef S1apProtocolExtension TargetRNCIDExtIEs
typedef S1apProtocolExtension TargeteNBIDExtIEs
typedef S1apProtocolExtension TargeteNBToSourceeNBTransparentContainerExtIEs
typedef S1apProtocolExtension TraceActivationExtIEs
typedef S1apProtocolExtension UEAggregateMaximumBitratesExtIEs 

typedef S1apProtocolExtension UES1APIDPairExtIEs 
typedef S1apProtocolExtension UESecurityCapabilitiesExtIEs 
typedef S1apProtocolExtension UEAssociatedLogicalS1ConnectionItemExtIEs
typedef S1apProtocolExtension X2TNLConfigurationInfoExtIEs



// ------------------------------



