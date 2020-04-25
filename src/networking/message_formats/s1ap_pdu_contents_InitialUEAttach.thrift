
/*

// Elementary Procedure Description in <s1ap_pdu_descriptions.thrift>


// EP17
typedef S1apElementaryProcedure S1Setup_EP = {"initiating_message":S1SetupRequest , "sucessful_outcome":S1SetupResponse, "unsuccessful_outcome":S1SetupFailure , "procedure_code":ID_S1Setup_PC , "criticality": Criticality.REJECT}


// EP12
typedef S1apElementaryProcedure InitialUEMessage_EP = {"initiating_message": InitialUEMessage,  "procedure_code": ID_initialUEMessage_PC , "criticality": Criticality.IGNORE}


// EP11
typedef S1apElementaryProcedure DownlinkNASTransport_EP = {"initiating_message": DownlinkNASTransport,  "procedure_code": ID_downlinkNASTransport_PC, "criticality": Criticality.IGNORE}



// EP13
typedef S1apElementaryProcedure UplinkNASTransport_EP = {"initiating_message": UplinkNASTransport,  "procedure_code": ID_uplinkNASTransport_PC, "criticality": Criticality.IGNORE}



// EP9
typedef S1apElementaryProcedure InitialContextSetup_EP = {"initiating_message": InitialContextSetupRequest , "sucessful_outcome":InitialContextSetupResponse , "unsuccessful_outcome": InitialContextSetupFailure, "procedure_code": ID_InitialContextSetup_PC, "criticality": Criticality.REJECT}

// ----------------- Messages from S1AP-PDU-CONTENTS

S1SetupRequest
S1SetupResponse
S1SetupFailure
InitialUEMessage
DownlinkNASTransport
UplinkNASTransport
InitialContextSetupRequest
InitialContextSetupResponse 
InitialContextSetupFailure

// -- use these to 


// Template; 


	{"id": , "criticality": Criticality.REJECT, "type": , "presence" :Presence.MANDATORY},

*/


// NAS TRANSPORT ELEMENTARY PROCEDURES

// DOWNLINK NAS TRANSPORT

struct DownlinkNASTransport {
	1: DownlinkNASTransportIES protocol_ies;
}

const list<S1apProtocolIES> DownlinkNASTransportIES = [
	{"id": ID_MME_UE_S1AP_ID_PIEID , "criticality": Criticality.REJECT, "type":MME_UE_S1AP_ID , "presence" :Presence.MANDATORY},
	{"id": ID_eNB_UE_S1AP_ID_PIEID, "criticality": Criticality.REJECT, "type":ENB_UE_S1AP_ID , "presence" :Presence.MANDATORY},
	{"id": ID_NAS_PDU_PIEID , "criticality": Criticality.REJECT, "type": NAS_PDU , "presence" :Presence.MANDATORY},
	{"id": ID_HandoverRestrictionList_PIEID , "criticality": Criticality.IGNORE, "type": HandoverRestrictionList, "presence" :Presence.OPTIONAL},
]



// INITIAL UE MESSAGE

struct InitialUEMessage {
	1: InitialUEMessageIEs protocol_ies;
}

const list<S1apProtocolIES> InitialUEMessageIEs = [ 
{"id": ID_eNB_UE_S1AP_ID_PIEID, "criticality": Criticality.REJECT, "type": ENB_UE_S1AP_ID, "presence" :Presence.MANDATORY},
{"id":ID_NAS_PDU_PIEID , "criticality": Criticality.REJECT, "type": NAS_PDU, "presence" :Presence.MANDATORY},
{"id":ID_TAI_PIEID , "criticality": Criticality.REJECT, "type":TAI , "presence" :Presence.MANDATORY},
{"id":ID_EUTRAN_CGI_PIEID , "criticality": Criticality.IGNORE, "type":EUTRAN_CGI , "presence" :Presence.MANDATORY},
{"id":ID_RRC_Establishment_Cause_PIEID , "criticality": Criticality.IGNORE, "type":RRCEstablishmentCause , "presence" :Presence.MANDATORY},
{"id":ID_S_TMSI_PIEID , "criticality": Criticality.REJECT, "type":S_TMSI, "presence" :Presence.OPTIONAL},
{"id":ID_CSG_Id_PIEID , "criticality": Criticality.REJECT, "type": CSGId, "presence" :Presence.OPTIONAL},
{"id":ID_GUMMEI_ID_PIEID, "criticality": Criticality.REJECT, "type":GUMMEI , "presence" :Presence.OPTIONAL},
]


// UPLINK NAS TRANSPORT

struct UplinkNASTransport {
	1: UplinkNASTransportIEs protocol_ies;
}



const list<S1apProtocolIES> UplinkNASTransportIEs= [
	{"id":ID_MME_UE_S1AP_ID_PIEID , "criticality": Criticality.REJECT, "type":MME_UE_S1AP_ID , "presence" :Presence.MANDATORY},
	{"id":ID_eNB_UE_S1AP_ID_PIEID , "criticality": Criticality.REJECT, "type":ENB_UE_S1AP_ID , "presence" :Presence.MANDATORY},
	{"id": ID_NAS_PDU_PIEID , "criticality": Criticality.REJECT, "type":NAS_PDU , "presence" :Presence.MANDATORY},
	{"id":ID_EUTRAN_CGI_PIEID , "criticality": Criticality.IGNORE, "type":EUTRAN_CGI , "presence" :Presence.MANDATORY},
	{"id":ID_TAI_PIEID , "criticality": Criticality.IGNORE, "type":TAI , "presence" :Presence.MANDATORY},

]

-- **************************************************************
--
-- S1 SETUP ELEMENTARY PROCEDURE
--
-- **************************************************************

-- **************************************************************
--
-- S1 Setup Request
--
-- **************************************************************



struct S1SetupRequest {
	1: SetupRequestIEs protocol_ies;
}

const list<S1apProtocolIES> S1SetupRequestIEs = [
	{"id":ID_Global_ENB_ID_PIEID , "criticality": Criticality.REJECT, "type":GlobalENBID , "presence" :Presence.MANDATORY},
	{"id":ID_eNBname_PIEID , "criticality": Criticality.IGNORE, "type":ENBName , "presence" :Presence.OPTIONAL},
	{"id":ID_SupportedTAs_PIEID , "criticality": Criticality.REJECT, "type":SupportedTAs , "presence" :Presence.MANDATORY},
	{"id":ID_DefaultPagingDRX_PIEID , "criticality": Criticality.IGNORE, "type":PagingDRX , "presence" :Presence.MANDATORY},
	{"id":ID_CSG_IdList_PIEID , "criticality": Criticality.REJECT, "type":CSGIdList , "presence" :Presence.OPTIONAL},

]

-- **************************************************************
--
-- S1 Setup Response
--
-- **************************************************************


struct S1SetupResponse {
	1: S1SetupResponseIEs protocol_ies;
}

const list<S1apProtocolIES> S1SetupResponseIEs = [
	{"id":ID_MMEname_PIEID , "criticality": Criticality.IGNORE, "type":MMEName , "presence" :Presence.OPTIONAL},
	{"id":ID_ServedGUMMEIs_PIEID , "criticality": Criticality.REJECT, "type":ServedGUMMEIs , "presence" :Presence.MANDATORY},
	{"id":ID_RelativeMMECapacity_PIEID , "criticality": Criticality.IGNORE, "type":RelativeMMECapacity , "presence" :Presence.MANDATORY},
	{"id":ID_CriticalityDiagnostics_PIEID , "criticality": Criticality.IGNORE, "type":CriticalityDiagnostics , "presence" :Presence.OPTIONAL},


]



-- **************************************************************
--
-- S1 Setup Failure
--
-- **************************************************************


struct S1SetupFailure {
	1: S1SetupFailureIEs protocol_ies;
}

const list<S1apProtocolIES> S1SetupResponseIEs = [
	{"id":ID_Cause_PIEID , "criticality": Criticality.IGNORE, "type":Cause , "presence" :Presence.MANDATORY},
	{"id":ID_TimeToWait_PIEID , "criticality": Criticality.IGNORE, "type":TimeToWait	 , "presence" :Presence.OPTIONAL},
	{"id":ID_CriticalityDiagnostics_PIEID , "criticality": Criticality.IGNORE, "type":CriticalityDiagnostics , "presence" :Presence.OPTIONAL},

]


-- **************************************************************
--
-- INITIAL CONTEXT SETUP ELEMENTARY PROCEDURE
--
-- **************************************************************

-- **************************************************************
--
-- Initial Context Setup Request
--
-- **************************************************************



struct InitialContextSetupRequest{
	1: InitialContextSetupRequestIEs protocol_ies;
}

const list<S1apProtocolIES> InitialContextSetupRequestIEs = [
		{"id":ID_MME_UE_S1AP_ID_PIEID , "criticality": Criticality.IGNORE, "type":MME_UE_S1AP_ID , "presence" :Presence.MANDATORY},
		{"id":ID_eNB_UE_S1AP_ID_PIEID , "criticality": Criticality.IGNORE, "type":ENB_UE_S1AP_ID , "presence" :Presence.MANDATORY},
	{"id":ID_uEaggregateMaximumBitrate_PIEID , "criticality": Criticality.REJECT, "type":UEAggregateMaximumBitrate , "presence" :Presence.MANDATORY},
	{"id":ID_E_RABToBeSetupListCtxtSUReq_PIEID , "criticality": Criticality.REJECT, "type":ERABToBeSetupListCtxtSUReq , "presence" :Presence.MANDATORY},
	{"id":ID_UESecurityCapabilities_PIEID , "criticality": Criticality.REJECT, "type":UESecurityCapabilities , "presence" :Presence.MANDATORY},
	{"id":ID_SecurityKey_PIEID , "criticality": Criticality.REJECT, "type":SecurityKey , "presence" :Presence.MANDATORY},
	{"id":ID_TraceActivation_PIEID , "criticality": Criticality.IGNORE, "type":TraceActivation , "presence" :Presence.OPTIONAL},
	{"id":ID_HandoverRestrictionList_PIEID , "criticality": Criticality.IGNORE, "type":HandoverRestrictionList , "presence" :Presence.OPTIONAL},
	{"id":ID_UERadioCapability_PIEID , "criticality": Criticality.IGNORE, "type":UERadioCapability , "presence" :Presence.OPTIONAL},
	{"id":ID_SubscriberProfileIDforRFP_PIEID , "criticality": Criticality.IGNORE, "type":SubscriberProfileIDforRFP , "presence" :Presence.OPTIONAL},
	{"id":ID_CSFallbackIndicator_PIEID , "criticality": Criticality.REJECT, "type":CSFallbackIndicator , "presence" :Presence.OPTIONAL},
	{"id":ID_SRVCCOperationPossible_PIEID , "criticality": Criticality.IGNORE, "type":SRVCCOperationPossible , "presence" :Presence.OPTIONAL},

]




//TODO: size(maxNrOfE-RABs)
typedef list<ERABToBeSetupItemCtxtSUReqIEs> ERABToBeSetupListCtxtSUReq


const S1apProtocolIES ERABToBeSetupItemCtxtSUReqIEs = {"id":ID_E_RABToBeSetupItemCtxtSUReq_PIEID , "criticality": Criticality.REJECT, "type":ERABToBeSetupItemCtxtSUReq , "presence" :Presence.MANDATORY},


struct ERABToBeSetupItemCtxtSUReq{
	1: E_RAB_ID 				e_rab_id;
	2: ERABLevelQoSParameters 	e_rab_level_qos_parameters;
	3: GTP_TEID 				gtp_teid;
	4: optional NAS_PDU 		nas_pdu;
	5: optional list<ERABToBeSetupItemCtxtSUReqExtIEs> ie_extensions;

}

typedef S1apProtocolExtension ERABToBeSetupItemCtxtSUReqExtIEs


-- **************************************************************
--
-- Initial Context Setup Response
--
-- **************************************************************




struct InitialContextSetupResponse{
	1: InitialContextSetupResponseIEs protocol_ies;
}

const list<S1apProtocolIES> S1SetupResponseIEs = [
		{"id":ID_MME_UE_S1AP_ID_PIEID , "criticality": Criticality.IGNORE, "type":MME_UE_S1AP_ID , "presence" :Presence.MANDATORY},
		{"id":ID_eNB_UE_S1AP_ID_PIEID , "criticality": Criticality.IGNORE, "type":ENB_UE_S1AP_ID , "presence" :Presence.MANDATORY},
		{"id":ID_E_RABSetupListCtxtSURes_PIEID , "criticality": Criticality.IGNORE, "type":ERABSetupListCtxtSURes , "presence" :Presence.MANDATORY},
		{"id":ID_E_RABFailedToSetupListCtxtSURes_PIEID , "criticality": Criticality.IGNORE, "type":ERABList , "presence" :Presence.OPTIONAL},
		{"id":ID_CriticalityDiagnostics_PIEID , "criticality": Criticality.IGNORE, "type":CriticalityDiagnostics , "presence" :Presence.OPTIONAL},
]



//TODO: size(maxNrOfE-RABs)
typedef list<ERABSetupItemCtxtSUResIEs> ERABSetupListCtxtSURes

const S1apProtocolIES ERABSetupItemCtxtSUResIEs = {"id":ID_E_RABSetupItemCtxtSURes_PIEID , "criticality": Criticality.IGNORE, "type": ERABSetupItemCtxtSURes, "presence": Presence.MANDATORY}

struct ERABSetupItemCtxtSURes{
	1: E_RAB_ID 				e_rab_id;
	2: TransportLayerAddress 	transport_layer_address;
	3: GTP_TEID 				gtp_teid;
	4: optional list<ERABSetupItemCtxtSUResExtIEs> ie_extensions;
}


typedef S1apProtocolExtension ERABSetupItemCtxtSUResExtIEs


-- **************************************************************
--
-- Initial Context Setup Failure
--
-- **************************************************************

InitialContextSetupFailure ::= SEQUENCE {
	protocolIEs			ProtocolIE-Container       { {InitialContextSetupFailureIEs} },
	...
}

InitialContextSetupFailureIEs S1AP-PROTOCOL-IES ::= {
	{ ID id-MME-UE-S1AP-ID				CRITICALITY ignore	TYPE MME-UE-S1AP-ID	 				PRESENCE mandatory	}|
	{ ID id-eNB-UE-S1AP-ID				CRITICALITY ignore	TYPE ENB-UE-S1AP-ID	 				PRESENCE mandatory	}|
	{ ID id-Cause						CRITICALITY ignore	TYPE Cause						PRESENCE mandatory	}|
	{ ID id-CriticalityDiagnostics		CRITICALITY ignore	TYPE CriticalityDiagnostics			PRESENCE optional	},
	...
}





/*


-- **************************************************************
--
-- NAS TRANSPORT ELEMENTARY PROCEDURES
--
-- **************************************************************

-- **************************************************************
--
-- DOWNLINK NAS TRANSPORT
--
-- **************************************************************

DownlinkNASTransport ::= SEQUENCE {
	protocolIEs                     ProtocolIE-Container       {{DownlinkNASTransport-IEs}},
	...
}

DownlinkNASTransport-IEs S1AP-PROTOCOL-IES ::= {
	{ ID id-MME-UE-S1AP-ID			CRITICALITY reject	TYPE MME-UE-S1AP-ID				PRESENCE mandatory} |
	{ ID id-eNB-UE-S1AP-ID			CRITICALITY reject	TYPE ENB-UE-S1AP-ID				PRESENCE mandatory} |
	{ ID id-NAS-PDU					CRITICALITY reject	TYPE NAS-PDU				PRESENCE mandatory} |
	{ ID id-HandoverRestrictionList		CRITICALITY ignore	TYPE HandoverRestrictionList	PRESENCE optional	},
	...
}


-- **************************************************************
--
-- INITIAL UE MESSAGE
--
-- **************************************************************

InitialUEMessage ::= SEQUENCE {
	protocolIEs                     ProtocolIE-Container       {{InitialUEMessage-IEs}},
	...
}

InitialUEMessage-IEs S1AP-PROTOCOL-IES ::= {
	{ ID id-eNB-UE-S1AP-ID				CRITICALITY reject	TYPE ENB-UE-S1AP-ID					PRESENCE mandatory} |
	{ ID id-NAS-PDU						CRITICALITY reject	TYPE NAS-PDU						PRESENCE mandatory} |
	{ ID id-TAI							CRITICALITY reject	TYPE TAI							PRESENCE mandatory} |
	{ ID id-EUTRAN-CGI					CRITICALITY ignore	TYPE EUTRAN-CGI						PRESENCE mandatory} |
	{ ID id-RRC-Establishment-Cause		CRITICALITY ignore	TYPE RRC-Establishment-Cause		PRESENCE mandatory} |
	{ ID id-S-TMSI						CRITICALITY reject	TYPE S-TMSI							PRESENCE optional} |
	{ ID id-CSG-Id						CRITICALITY reject	TYPE CSG-Id							PRESENCE optional} |
	{ ID id-GUMMEI-ID					CRITICALITY reject	TYPE GUMMEI							PRESENCE optional},
	...
}


-- **************************************************************
--
-- UPLINK NAS TRANSPORT
--
-- **************************************************************

UplinkNASTransport ::= SEQUENCE {
	protocolIEs                     ProtocolIE-Container       {{UplinkNASTransport-IEs}},
	...
}

UplinkNASTransport-IEs S1AP-PROTOCOL-IES ::= {
	{ ID id-MME-UE-S1AP-ID			CRITICALITY reject	TYPE MME-UE-S1AP-ID				PRESENCE mandatory} |
	{ ID id-eNB-UE-S1AP-ID			CRITICALITY reject	TYPE ENB-UE-S1AP-ID				PRESENCE mandatory} |
	{ ID id-NAS-PDU					CRITICALITY reject	TYPE NAS-PDU				PRESENCE mandatory} |	
	{ ID id-EUTRAN-CGI			CRITICALITY ignore	TYPE EUTRAN-CGI			PRESENCE mandatory}|
	{ ID id-TAI					CRITICALITY ignore	TYPE TAI						PRESENCE mandatory},
	...
}


-- **************************************************************
--
-- S1 SETUP ELEMENTARY PROCEDURE
--
-- **************************************************************

-- **************************************************************
--
-- S1 Setup Request
--
-- **************************************************************

S1SetupRequest ::= SEQUENCE {
	protocolIEs			ProtocolIE-Container       { {S1SetupRequestIEs} },
	...
}

S1SetupRequestIEs S1AP-PROTOCOL-IES ::= {
	{ ID id-Global-ENB-ID	CRITICALITY reject	TYPE Global-ENB-ID	PRESENCE mandatory}|
	{ ID id-eNBname	CRITICALITY ignore	TYPE ENBname	PRESENCE optional}|
	{ ID id-SupportedTAs	CRITICALITY reject	TYPE SupportedTAs	PRESENCE mandatory}|
	{ ID id-DefaultPagingDRX	CRITICALITY ignore	TYPE PagingDRX	PRESENCE mandatory}|
	{ ID id-CSG-IdList	CRITICALITY reject	TYPE CSG-IdList	PRESENCE optional},
	...
}

-- **************************************************************
--
-- S1 Setup Response
--
-- **************************************************************

S1SetupResponse ::= SEQUENCE {
	protocolIEs			ProtocolIE-Container       { {S1SetupResponseIEs} },
	...
}


S1SetupResponseIEs S1AP-PROTOCOL-IES ::= {
	{ ID id-MMEname				CRITICALITY ignore	TYPE MMEname	 		PRESENCE optional	}|
	{ ID id-ServedGUMMEIs				CRITICALITY reject	TYPE ServedGUMMEIs				PRESENCE mandatory	}|
	{ ID id-RelativeMMECapacity					CRITICALITY ignore	TYPE RelativeMMECapacity		 			PRESENCE mandatory	}|
	{ ID id-CriticalityDiagnostics		CRITICALITY ignore	TYPE CriticalityDiagnostics			PRESENCE optional	},
	...
}

-- **************************************************************
--
-- S1 Setup Failure
--
-- **************************************************************

S1SetupFailure ::= SEQUENCE {
	protocolIEs			ProtocolIE-Container       { {S1SetupFailureIEs} },
	...
}

S1SetupFailureIEs S1AP-PROTOCOL-IES ::= {
	{ ID id-Cause						CRITICALITY ignore	TYPE Cause						PRESENCE mandatory	}|
	{ ID id-TimeToWait					CRITICALITY ignore	TYPE TimeToWait					PRESENCE optional	}|
	{ ID id-CriticalityDiagnostics		CRITICALITY ignore	TYPE CriticalityDiagnostics			PRESENCE optional	},
	...
}



-- **************************************************************
--
-- INITIAL CONTEXT SETUP ELEMENTARY PROCEDURE
--
-- **************************************************************

-- **************************************************************
--
-- Initial Context Setup Request
--
-- **************************************************************

InitialContextSetupRequest ::= SEQUENCE {
	protocolIEs			ProtocolIE-Container       { {InitialContextSetupRequestIEs} },
	...
}

InitialContextSetupRequestIEs S1AP-PROTOCOL-IES ::= {
	{ ID id-MME-UE-S1AP-ID				CRITICALITY reject	TYPE MME-UE-S1AP-ID	 				PRESENCE mandatory	}|
	{ ID id-eNB-UE-S1AP-ID				CRITICALITY reject	TYPE ENB-UE-S1AP-ID	 				PRESENCE mandatory	}|
	{ ID id-uEaggregateMaximumBitrate		CRITICALITY reject	TYPE UEAggregateMaximumBitrate		PRESENCE mandatory	}|
	{ ID id-E-RABToBeSetupListCtxtSUReq			CRITICALITY reject	TYPE E-RABToBeSetupListCtxtSUReq	 	PRESENCE mandatory	}|
	{ ID id-UESecurityCapabilities		CRITICALITY reject	TYPE UESecurityCapabilities			PRESENCE mandatory	}|
	{ ID id-SecurityKey		CRITICALITY reject	TYPE SecurityKey			PRESENCE mandatory	}|
	{ ID id-TraceActivation				CRITICALITY ignore	TYPE TraceActivation	 			PRESENCE optional	}|
	{ ID id-HandoverRestrictionList		CRITICALITY ignore	TYPE HandoverRestrictionList		PRESENCE optional	}|
	{ ID id-UERadioCapability			CRITICALITY ignore	TYPE UERadioCapability				PRESENCE optional	}|
	{ ID id-SubscriberProfileIDforRFP	CRITICALITY ignore	TYPE SubscriberProfileIDforRFP	PRESENCE optional	}|
	{ ID id-CSFallbackIndicator			CRITICALITY reject		TYPE CSFallbackIndicator		PRESENCE optional	}|
	{ ID id-SRVCCOperationPossible			CRITICALITY ignore	TYPE SRVCCOperationPossible		PRESENCE optional	},
	...
}




E-RABToBeSetupListCtxtSUReq ::= SEQUENCE (SIZE(1.. maxNrOfE-RABs)) OF ProtocolIE-SingleContainer { {E-RABToBeSetupItemCtxtSUReqIEs} }

E-RABToBeSetupItemCtxtSUReqIEs 	S1AP-PROTOCOL-IES ::= {
	{ ID id-E-RABToBeSetupItemCtxtSUReq	 CRITICALITY reject 	TYPE E-RABToBeSetupItemCtxtSUReq 	PRESENCE mandatory },
	...
}

E-RABToBeSetupItemCtxtSUReq ::= SEQUENCE {
	e-RAB-ID					E-RAB-ID,
	e-RABlevelQoSParameters					E-RABLevelQoSParameters,		
	transportLayerAddress 			TransportLayerAddress,
	gTP-TEID			GTP-TEID,
	nAS-PDU				NAS-PDU		OPTIONAL,
	iE-Extensions					ProtocolExtensionContainer { {E-RABToBeSetupItemCtxtSUReqExtIEs} } OPTIONAL,
	...
}


E-RABToBeSetupItemCtxtSUReqExtIEs S1AP-PROTOCOL-EXTENSION ::= {
	...
}


-- **************************************************************
--
-- Initial Context Setup Response
--
-- **************************************************************

InitialContextSetupResponse ::= SEQUENCE {
	protocolIEs			ProtocolIE-Container       { {InitialContextSetupResponseIEs} },
	...
}

InitialContextSetupResponseIEs S1AP-PROTOCOL-IES ::= {
	{ ID id-MME-UE-S1AP-ID				CRITICALITY ignore	TYPE MME-UE-S1AP-ID	 				PRESENCE mandatory	}|
	{ ID id-eNB-UE-S1AP-ID				CRITICALITY ignore	TYPE ENB-UE-S1AP-ID	 				PRESENCE mandatory	}|
	{ ID id-E-RABSetupListCtxtSURes				CRITICALITY ignore	TYPE E-RABSetupListCtxtSURes			PRESENCE mandatory	}|
	{ ID id-E-RABFailedToSetupListCtxtSURes		CRITICALITY ignore	TYPE E-RABList					PRESENCE optional	}|
	{ ID id-CriticalityDiagnostics		CRITICALITY ignore	TYPE CriticalityDiagnostics			PRESENCE optional	},
	...
}


E-RABSetupListCtxtSURes ::= SEQUENCE (SIZE(1.. maxNrOfE-RABs)) OF ProtocolIE-SingleContainer { {E-RABSetupItemCtxtSUResIEs} }

E-RABSetupItemCtxtSUResIEs 	S1AP-PROTOCOL-IES ::= {
	{ ID id-E-RABSetupItemCtxtSURes	 CRITICALITY ignore 	TYPE E-RABSetupItemCtxtSURes 	PRESENCE mandatory },
	...
}

E-RABSetupItemCtxtSURes ::= SEQUENCE {
	e-RAB-ID					E-RAB-ID,
	transportLayerAddress 			TransportLayerAddress,
	gTP-TEID			GTP-TEID,
	iE-Extensions					ProtocolExtensionContainer { {E-RABSetupItemCtxtSUResExtIEs} } OPTIONAL,
	...
}


E-RABSetupItemCtxtSUResExtIEs S1AP-PROTOCOL-EXTENSION ::= {
	...
}


-- **************************************************************
--
-- Initial Context Setup Failure
--
-- **************************************************************

InitialContextSetupFailure ::= SEQUENCE {
	protocolIEs			ProtocolIE-Container       { {InitialContextSetupFailureIEs} },
	...
}

InitialContextSetupFailureIEs S1AP-PROTOCOL-IES ::= {
	{ ID id-MME-UE-S1AP-ID				CRITICALITY ignore	TYPE MME-UE-S1AP-ID	 				PRESENCE mandatory	}|
	{ ID id-eNB-UE-S1AP-ID				CRITICALITY ignore	TYPE ENB-UE-S1AP-ID	 				PRESENCE mandatory	}|
	{ ID id-Cause						CRITICALITY ignore	TYPE Cause						PRESENCE mandatory	}|
	{ ID id-CriticalityDiagnostics		CRITICALITY ignore	TYPE CriticalityDiagnostics			PRESENCE optional	},
	...
}


*/