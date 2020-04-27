// S1AP-PDU-Descriptions

// Messages are defined in PDU-Contents file. 
// Elementary Procedures are Described here, by connecting the messages to each procedure. 


// -------  Interface Elementary Procedure Class

struct S1APElementaryProcedure{
	1: InitiatingMessage 				initiating_message;
	2: optional SuccessfulOutcome 		successful_outcome;
	3: optional UnsuccessfulOutcome 	unsuccessful_outcome; 
	4: required ProcedureCode 			procedure_code;  //TODO : UNIQUE
	5: Criticality 						criticality = Criticality.IGNORE;

}



// -------  Interface PDU Definition

union S1APPDU{
	1: InitiatingMessage 		initiating_message;
	2: SuccessfulOutcome 		successful_outcome;
	3: UnsuccessfulOutcome 		unsuccessful_outcome; 
}

typedef S1APElementaryProcedure InitiatingMessage
typedef S1APElementaryProcedure SuccessfulOutcome
typedef S1APElementaryProcedure UnsuccessfulOutcome


// -------  Interface Elementary Procedure List

const list<S1APElementaryProcedure> S1APElementaryProcedures = [S1APElementaryProceduresClass1, S1APElementaryProceduresClass2];


const list<S1APElementaryProcedure> S1APElementaryProceduresClass1 = [
	HandoverPreparation_EP,
	HandoverResourceAllocation_EP,
	PathSwitchRequest_EP,
	ERABSetup_EP,
	ERABModify_EP,
	ERABRelease_EP,
	InitialContextSetup_EP,
	HandoverCancel_EP,
	Reset_EP,
	S1Setup_EP,
	UEContextModification_EP,
	UEContextRelease_EP,
	ENBConfigurationUpdate_EP,
	MMEConfigurationUpdate_EP,
	WriteReplaceWarning_EP, 
]


const list<S1APElementaryProcedure> S1APElementaryProceduresClass2 = [
	HandoverNotification_EP,
	ERABReleaseIndication_EP,
	Paging_EP,
	DownlinkNASTransport_EP,
	InitialUEMessage_EP,
	UplinkNASTransport_EP,
	ErrorIndication_EP,
	NASNonDeliveryIndication_EP,
	UEContextReleaseRequest_EP,
	DownlinkS1cdma2000tunneling_EP,
	UplinkS1cdma2000tunneling_EP,
	UECapabilityInfoIndication_EP,
	ENBStatusTransfer_EP,
	MMEStatusTransfer_EP,
	DeactivateTrace_EP,
	TraceStart_EP,
	TraceFailureIndication_EP,
	CellTrafficTrace_EP,
	LocationReportingControl_EP,
	LocationReportingFailureIndication_EP,
	LocationReport_EP,
	OverloadStart_EP,
	OverloadStop_EP,
	ENBDirectInformationTransfer_EP,
	MMEDirectInformationTransfer_EP,
	ENBConfigurationTransfer_EP,
	MMEConfigurationTransfer_EP,
	PrivateMessage_EP,
]

// -------  Interface Elementary Procedures

/*  -- TEMPLATE

typedef S1apElementaryProcedure <> = {"initiating_message": , "sucessful_outcome":, "unsuccessful_outcome": , "procedure_code": , "criticality": Criticality.REJECT}

*/




// EP0
typedef S1apElementaryProcedure HandoverPreparation_EP = {"initiating_message": HandoverRequired, "sucessful_outcome": HandoverCommand, "unsuccessful_outcome": HandoverPreparationFailure, "procedure_code": ID_HandoverPreparation_PC, "criticality": Criticality.REJECT}

// EP1
typedef S1apElementaryProcedure HandoverResourceAllocation_EP = {"initiating_message": HandoverRequest, "sucessful_outcome":HandoverRequestAcknowledge, "unsuccessful_outcome": andoverFailure, "procedure_code": ID_HandoverResourceAllocation_PC, "criticality": Criticality.REJECT}

// EP2
typedef S1apElementaryProcedure HandoverNotification_EP = {"initiating_message": HandoverNotify, "procedure_code": ID_HandoverNotification_PC, "criticality": Criticality.IGNORE}


// EP3
typedef S1apElementaryProcedure PathSwitchRequest_EP = {"initiating_message": PathSwitchRequest, "sucessful_outcome": PathSwitchRequestAcknowledge, "unsuccessful_outcome": PathSwitchRequestFailure, "procedure_code": ID_PathSwitchRequest_PC , "criticality": Criticality.REJECT}


// EP4
typedef S1apElementaryProcedure HandoverCancel_EP = {"initiating_message": HandoverCancel , "sucessful_outcome": HandoverCancelAcknowledge,  "procedure_code":ID_HandoverCancel_PC  , "criticality": Criticality.REJECT}

// EP5 
typedef S1apElementaryProcedure ERABSetup_EP = {"initiating_message":ERABSetupRequest , "sucessful_outcome": ERABSetupResponse, "procedure_code": ID_E_RABSetup_PC, "criticality": Criticality.REJECT}

// EP6
typedef S1apElementaryProcedure ERABModify_EP = {"initiating_message": ERABModifyRequest, "sucessful_outcome": ERABModifyResponse,  "procedure_code": ID_E_RABModify_PC, "criticality": Criticality.REJECT}

// EP7
typedef S1apElementaryProcedure ERABRelease_EP = {"initiating_message": ERABReleaseCommand, "sucessful_outcome":ERABReleaseResponse,  "procedure_code":ID_E_RABRelease_PC , "criticality": Criticality.REJECT}

// EP8 
typedef S1apElementaryProcedure ERABReleaseIndication_EP = {"initiating_message": ERABReleaseIndication,  "procedure_code": ID_E_RABReleaseIndication_PC , "criticality": Criticality.IGNORE}

// EP9
typedef S1apElementaryProcedure InitialContextSetup_EP = {"initiating_message": InitialContextSetupRequest , "sucessful_outcome":InitialContextSetupResponse , "unsuccessful_outcome": InitialContextSetupFailure, "procedure_code": ID_InitialContextSetup_PC, "criticality": Criticality.REJECT}


// EP10
typedef S1apElementaryProcedure Paging_EP = {"initiating_message": Paging , "procedure_code": ID_Paging_PC, "criticality": Criticality.IGNORE}

// EP11
typedef S1apElementaryProcedure DownlinkNASTransport_EP = {"initiating_message": DownlinkNASTransport,  "procedure_code": ID_downlinkNASTransport_PC, "criticality": Criticality.IGNORE}


// EP12
typedef S1apElementaryProcedure InitialUEMessage_EP = {"initiating_message": InitialUEMessage,  "procedure_code": ID_initialUEMessage_PC , "criticality": Criticality.IGNORE}


// EP13
typedef S1apElementaryProcedure UplinkNASTransport_EP = {"initiating_message": UplinkNASTransport,  "procedure_code": ID_uplinkNASTransport_PC, "criticality": Criticality.IGNORE}


// EP14
typedef S1apElementaryProcedure Reset_EP = {"initiating_message": Reset, "sucessful_outcome":ResetAcknowledge,  "procedure_code": ID_Reset_PC, "criticality": Criticality.REJECT}



// EP15
typedef S1apElementaryProcedure ErrorIndication_EP = {"initiating_message":ErrorIndication ,  "procedure_code": ID_ErrorIndication_PC , "criticality": Criticality.IGNORE}


// EP16
typedef S1apElementaryProcedure NASNonDeliveryIndication_EP = {"initiating_message": NASNonDeliveryIndication ,  "procedure_code": ID_NASNonDeliveryIndication_PC, "criticality": Criticality.IGNORE}



// EP17
typedef S1apElementaryProcedure S1Setup_EP = {"initiating_message":S1SetupRequest , "sucessful_outcome":S1SetupResponse, "unsuccessful_outcome":S1SetupFailure , "procedure_code":ID_S1Setup_PC , "criticality": Criticality.REJECT}



// EP18
typedef S1apElementaryProcedure UEContextReleaseRequest_EP = {"initiating_message": UEContextReleaseRequest , "procedure_code": ID_UEContextReleaseRequest_PC, "criticality": Criticality.IGNORE}

// EP 19
typedef S1apElementaryProcedure DownlinkS1cdma2000tunneling_EP = {"initiating_message":DownlinkS1cdma2000tunneling , "procedure_code": ID_DownlinkS1cdma2000tunneling_PC, "criticality": Criticality.IGNORE}

// EP20
typedef S1apElementaryProcedure UplinkS1cdma2000tunneling_EP = {"initiating_message": UplinkS1cdma2000tunneling, "procedure_code":ID_UplinkS1cdma2000tunneling_PC , "criticality": Criticality.IGNORE}

// EP21
typedef S1apElementaryProcedure UEContextModification_EP = {"initiating_message":UEContextModificationRequest , "sucessful_outcome": UEContextModificationResponse, "unsuccessful_outcome": UEContextModificationFailure , "procedure_code": ID_UEContextModification_PC, "criticality": Criticality.REJECT}


// EP22
typedef S1apElementaryProcedure UECapabilityInfoIndication_EP = {"initiating_message": UECapabilityInfoIndication,  "procedure_code": ID_UECapabilityInfoIndication_PC, "criticality": Criticality.IGNORE}

// EP23
typedef S1apElementaryProcedure UEContextRelease_EP = {"initiating_message":UEContextReleaseCommand, "sucessful_outcome": UEContextReleaseComplete ,  "procedure_code": ID_UEContextRelease_PC, "criticality": Criticality.REJECT}

// EP24
typedef S1apElementaryProcedure ENBStatusTransfer_EP = {"initiating_message":ENBStatusTransfer , "procedure_code": ID_eNBStatusTransfer_PC, "criticality": Criticality.IGNORE}

// EP25
typedef S1apElementaryProcedure MMEStatusTransfer_EP = {"initiating_message": MMEStatusTransfer, "procedure_code": ID_MMEStatusTransfer_PC, "criticality": Criticality.IGNORE}

// EP26
typedef S1apElementaryProcedure DeactivateTrace_EP = {"initiating_message": DeactivateTrace, "procedure_code": ID_DeactivateTrace_PC , "criticality": Criticality.IGNORE}

// EP27
typedef S1apElementaryProcedure TraceStart_EP = {"initiating_message":TraceStart , "procedure_code":ID_TraceStart_PC , "criticality": Criticality.IGNORE}


// EP28
typedef S1apElementaryProcedure TraceFailureIndication_EP = {"initiating_message": TraceFailureIndication,  "procedure_code": ID_TraceFailureIndication_PC, "criticality": Criticality.IGNORE}


// EP29
typedef S1apElementaryProcedure ENBConfigurationUpdate_EP = {"initiating_message": ENBConfigurationUpdate, "sucessful_outcome":ENBConfigurationUpdateAcknowledge, "unsuccessful_outcome":ENBConfigurationUpdateFailure , "procedure_code": ID_ENBConfigurationUpdate_PC , "criticality": Criticality.REJECT}


// EP30
typedef S1apElementaryProcedure MMEConfigurationUpdate_EP = {"initiating_message":MMEConfigurationUpdate , "sucessful_outcome":MMEConfigurationUpdateAcknowledge, "unsuccessful_outcome":MMEConfigurationUpdateFailure , "procedure_code":  ID_MMEConfigurationUpdate_PC, "criticality": Criticality.REJECT}

// EP31
typedef S1apElementaryProcedure LocationReportingControl_EP = {"initiating_message":LocationReportingControl ,"procedure_code":ID_LocationReportingControl_PC , "criticality": Criticality.IGNORE}

// EP32
typedef S1apElementaryProcedure LocationReportingFailureIndication_EP = {"initiating_message": LocationReportingFailureIndication,  "procedure_code": ID_LocationReportingFailureIndication_PC, "criticality": Criticality.IGNORE}


// EP33
typedef S1apElementaryProcedure LocationReport_EP = {"initiating_message": LocationReport, "procedure_code": ID_LocationReport_PC, "criticality": Criticality.IGNORE}


// EP34
typedef S1apElementaryProcedure OverloadStart_EP = {"initiating_message":OverloadStart , "procedure_code": ID_OverloadStart_PC, "criticality": Criticality.IGNORE}

// EP35
typedef S1apElementaryProcedure OverloadStop_EP = {"initiating_message":OverloadStop , "procedure_code": ID_OverloadStop_PC, "criticality": Criticality.REJECT}

// EP36
typedef S1apElementaryProcedure writeReplaceWarning = {"initiating_message": WriteReplaceWarningRequest , "sucessful_outcome": WriteReplaceWarningResponse,  "procedure_code": ID_WriteReplaceWarning_PC, "criticality": Criticality.REJECT}


// EP37
typedef S1apElementaryProcedure ENBDirectInformationTransfer_EP = {"initiating_message": ENBDirectInformationTransfer,  "procedure_code": ID_eNBDirectInformationTransfer_PC , "criticality": Criticality.IGNORE}


// EP38
typedef S1apElementaryProcedure MMEDirectInformationTransfer_EP = {"initiating_message":	MMEDirectInformationTransfer ,  "procedure_code": ID_MMEDirectInformationTransfer_PC, "criticality": Criticality.IGNORE}

// EP39
typedef S1apElementaryProcedure PrivateMessage_EP = {"initiating_message": PrivateMessage, "procedure_code": ID_PrivateMessage_PC , "criticality": Criticality.IGNORE}



// EP40
typedef S1apElementaryProcedure ENBConfigurationTransfer_EP = {"initiating_message":ENBConfigurationTransfer , "procedure_code": ID_eNBConfigurationTransfer_PC, "criticality": Criticality.IGNORE}

// EP41
typedef S1apElementaryProcedure MMEConfigurationTransfer_EP = {"initiating_message": MMEConfigurationTransfer, "procedure_code":ID_MMEConfigurationTransfer_PC , "criticality": Criticality.IGNORE}


// EP42
typedef S1apElementaryProcedure CellTrafficTrace_EP = {"initiating_message": CellTrafficTrace,  "procedure_code": ID_CellTrafficTrace_PC, "criticality": Criticality.IGNORE}




/*
-- **************************************************************
--
-- Elementary Procedure definitions
--
-- **************************************************************

S1AP-PDU-Descriptions  { 
itu-t (0) identified-organization (4) etsi (0) mobileDomain (0) 
eps-Access (21) modules (3) s1ap (1) version1 (1) s1ap-PDU-Descriptions (0)}

DEFINITIONS AUTOMATIC TAGS ::= 

BEGIN

-- **************************************************************
--
-- IE parameter types from other modules.
--
-- **************************************************************

IMPORTS
	Criticality,
	ProcedureCode
FROM S1AP-CommonDataTypes

	CellTrafficTrace,
	DeactivateTrace,
	DownlinkNASTransport,
	DownlinkS1cdma2000tunneling,
	ENBDirectInformationTransfer,
	ENBStatusTransfer,
	ENBConfigurationUpdate,
	ENBConfigurationUpdateAcknowledge,
	ENBConfigurationUpdateFailure,
	ErrorIndication,
	HandoverCancel,
	HandoverCancelAcknowledge,
	HandoverCommand,
	HandoverFailure,
	HandoverNotify,
	HandoverPreparationFailure,
	HandoverRequest,
	HandoverRequestAcknowledge,
	HandoverRequired,
	InitialContextSetupFailure,
	InitialContextSetupRequest,
	InitialContextSetupResponse,
	InitialUEMessage,
	LocationReportingControl,
	LocationReportingFailureIndication,
	LocationReport,
	MMEConfigurationUpdate,
	MMEConfigurationUpdateAcknowledge,
	MMEConfigurationUpdateFailure,
	MMEDirectInformationTransfer,
	MMEStatusTransfer,
	NASNonDeliveryIndication,
	OverloadStart,
	OverloadStop,
	Paging,
	PathSwitchRequest,
	PathSwitchRequestAcknowledge,
	PathSwitchRequestFailure,	
	PrivateMessage,
	Reset,
	ResetAcknowledge,
	S1SetupFailure,
	S1SetupRequest,
	S1SetupResponse,
	E-RABModifyRequest,
	E-RABModifyResponse,
	E-RABReleaseCommand,
	E-RABReleaseResponse,
	E-RABReleaseIndication,
	E-RABSetupRequest,
	E-RABSetupResponse,
	TraceFailureIndication,
	TraceStart,
	UECapabilityInfoIndication,
	UEContextModificationFailure,
	UEContextModificationRequest,
	UEContextModificationResponse,
	UEContextReleaseCommand,
	UEContextReleaseComplete,
	UEContextReleaseRequest,
	UplinkNASTransport,
	UplinkS1cdma2000tunneling,
	WriteReplaceWarningRequest,
	WriteReplaceWarningResponse,
	ENBConfigurationTransfer,
	MMEConfigurationTransfer
FROM S1AP-PDU-Contents
	
	id-CellTrafficTrace,
	id-DeactivateTrace,
	id-downlinkNASTransport,
	id-DownlinkS1cdma2000tunneling,
	id-eNBStatusTransfer,
	id-ErrorIndication,
	id-HandoverCancel,
	id-HandoverNotification,
	id-HandoverPreparation,
	id-HandoverResourceAllocation,
	id-InitialContextSetup,
	id-initialUEMessage,
	id-ENBConfigurationUpdate,
	id-LocationReportingControl,
	id-LocationReportingFailureIndication,
	id-LocationReport,
	id-eNBDirectInformationTransfer,
	id-MMEConfigurationUpdate,
	id-MMEDirectInformationTransfer,
	id-MMEStatusTransfer,
	id-NASNonDeliveryIndication,
	id-OverloadStart,
	id-OverloadStop,
	id-Paging,
	id-PathSwitchRequest,
	id-PrivateMessage,
	id-Reset,
	id-S1Setup,
	id-E-RABModify,
	id-E-RABRelease,
	id-E-RABReleaseIndication,
	id-E-RABSetup,
	id-TraceFailureIndication,
	id-TraceStart,
	id-UECapabilityInfoIndication,
	id-UEContextModification,
	id-UEContextRelease,
	id-UEContextReleaseRequest,
	id-uplinkNASTransport,
	id-UplinkS1cdma2000tunneling,
	id-WriteReplaceWarning,
	id-eNBConfigurationTransfer,
	id-MMEConfigurationTransfer
FROM S1AP-Constants;


-- **************************************************************
--
-- Interface Elementary Procedure Class
--
-- **************************************************************

S1AP-ELEMENTARY-PROCEDURE ::= CLASS {
	&InitiatingMessage				,
	&SuccessfulOutcome				OPTIONAL,
	&UnsuccessfulOutcome				OPTIONAL,
	&procedureCode			ProcedureCode 	UNIQUE,
	&criticality			Criticality 	DEFAULT ignore
}
WITH SYNTAX {
	INITIATING MESSAGE			&InitiatingMessage
	[SUCCESSFUL OUTCOME			&SuccessfulOutcome]
	[UNSUCCESSFUL OUTCOME		&UnsuccessfulOutcome]
	PROCEDURE CODE				&procedureCode
	[CRITICALITY				&criticality]
}

-- **************************************************************
--
-- Interface PDU Definition
--
-- **************************************************************

S1AP-PDU ::= CHOICE {
	initiatingMessage	InitiatingMessage,
	successfulOutcome	SuccessfulOutcome,
	unsuccessfulOutcome	UnsuccessfulOutcome,
	...
}

InitiatingMessage ::= SEQUENCE {
	procedureCode	S1AP-ELEMENTARY-PROCEDURE.&procedureCode	({S1AP-ELEMENTARY-PROCEDURES}),
	criticality	S1AP-ELEMENTARY-PROCEDURE.&criticality			({S1AP-ELEMENTARY-PROCEDURES}{@procedureCode}),
	value		S1AP-ELEMENTARY-PROCEDURE.&InitiatingMessage	({S1AP-ELEMENTARY-PROCEDURES}{@procedureCode})
}

SuccessfulOutcome ::= SEQUENCE {
	procedureCode	S1AP-ELEMENTARY-PROCEDURE.&procedureCode	({S1AP-ELEMENTARY-PROCEDURES}),
	criticality	S1AP-ELEMENTARY-PROCEDURE.&criticality			({S1AP-ELEMENTARY-PROCEDURES}{@procedureCode}),
	value		S1AP-ELEMENTARY-PROCEDURE.&SuccessfulOutcome	({S1AP-ELEMENTARY-PROCEDURES}{@procedureCode})
}

UnsuccessfulOutcome ::= SEQUENCE {
	procedureCode	S1AP-ELEMENTARY-PROCEDURE.&procedureCode	({S1AP-ELEMENTARY-PROCEDURES}),
	criticality	S1AP-ELEMENTARY-PROCEDURE.&criticality			({S1AP-ELEMENTARY-PROCEDURES}{@procedureCode}),
	value		S1AP-ELEMENTARY-PROCEDURE.&UnsuccessfulOutcome	({S1AP-ELEMENTARY-PROCEDURES}{@procedureCode})
}

-- **************************************************************
--
-- Interface Elementary Procedure List
--
-- **************************************************************

S1AP-ELEMENTARY-PROCEDURES S1AP-ELEMENTARY-PROCEDURE ::= {
	S1AP-ELEMENTARY-PROCEDURES-CLASS-1		|
	S1AP-ELEMENTARY-PROCEDURES-CLASS-2,	
	...
}


S1AP-ELEMENTARY-PROCEDURES-CLASS-1 S1AP-ELEMENTARY-PROCEDURE ::= {
	handoverPreparation				|
	handoverResourceAllocation		|
	pathSwitchRequest 				|
	e-RABSetup						|
	e-RABModify						|
	e-RABRelease					|
	initialContextSetup				|
	handoverCancel					|
	reset							|
	s1Setup							|
	uEContextModification			|
	uEContextRelease				|
	eNBConfigurationUpdate			|
	mMEConfigurationUpdate			|
	writeReplaceWarning				,
	...
}

S1AP-ELEMENTARY-PROCEDURES-CLASS-2 S1AP-ELEMENTARY-PROCEDURE ::= {	
	handoverNotification			|
	e-RABReleaseIndication			|
	paging 							|
	downlinkNASTransport			|
	initialUEMessage				|
	uplinkNASTransport				|
	errorIndication					|
	nASNonDeliveryIndication		|
	uEContextReleaseRequest			|
	downlinkS1cdma2000tunneling		|
	uplinkS1cdma2000tunneling		|
	uECapabilityInfoIndication		|
	eNBStatusTransfer				|
	mMEStatusTransfer				|
	deactivateTrace					|
	traceStart						|
	traceFailureIndication			|
	cellTrafficTrace				|
	locationReportingControl		|
	locationReportingFailureIndication	|
	locationReport					|
	overloadStart					|
	overloadStop					|
	eNBDirectInformationTransfer	|
	mMEDirectInformationTransfer	|
	eNBConfigurationTransfer		|
	mMEConfigurationTransfer		|
	privateMessage					,
	...
}

-- **************************************************************
--
-- Interface Elementary Procedures
--
-- **************************************************************

handoverPreparation S1AP-ELEMENTARY-PROCEDURE ::= {
	INITIATING MESSAGE	HandoverRequired
	SUCCESSFUL OUTCOME	HandoverCommand
	UNSUCCESSFUL OUTCOME	HandoverPreparationFailure
	PROCEDURE CODE			id-HandoverPreparation
	CRITICALITY		reject
}

handoverResourceAllocation S1AP-ELEMENTARY-PROCEDURE ::= {
	INITIATING MESSAGE	HandoverRequest
	SUCCESSFUL OUTCOME	HandoverRequestAcknowledge
	UNSUCCESSFUL OUTCOME	HandoverFailure
	PROCEDURE CODE			id-HandoverResourceAllocation
	CRITICALITY		reject
}

handoverNotification S1AP-ELEMENTARY-PROCEDURE ::= {
	INITIATING MESSAGE	HandoverNotify
	PROCEDURE CODE			id-HandoverNotification
	CRITICALITY		ignore
}

pathSwitchRequest S1AP-ELEMENTARY-PROCEDURE ::= {
	INITIATING MESSAGE	PathSwitchRequest
	SUCCESSFUL OUTCOME	PathSwitchRequestAcknowledge
	UNSUCCESSFUL OUTCOME	PathSwitchRequestFailure
	PROCEDURE CODE			id-PathSwitchRequest
	CRITICALITY		reject
}

e-RABSetup S1AP-ELEMENTARY-PROCEDURE ::= {
	INITIATING MESSAGE	E-RABSetupRequest
	SUCCESSFUL OUTCOME	E-RABSetupResponse
	PROCEDURE CODE		id-E-RABSetup
	CRITICALITY		reject
}

e-RABModify S1AP-ELEMENTARY-PROCEDURE ::= {
	INITIATING MESSAGE	E-RABModifyRequest
	SUCCESSFUL OUTCOME	E-RABModifyResponse
	PROCEDURE CODE		id-E-RABModify
	CRITICALITY		reject
}

e-RABRelease S1AP-ELEMENTARY-PROCEDURE ::= {
	INITIATING MESSAGE	E-RABReleaseCommand
	SUCCESSFUL OUTCOME	E-RABReleaseResponse
	PROCEDURE CODE		id-E-RABRelease
	CRITICALITY		reject
}

e-RABReleaseIndication S1AP-ELEMENTARY-PROCEDURE ::= {
	INITIATING MESSAGE	E-RABReleaseIndication
	PROCEDURE CODE		id-E-RABReleaseIndication
	CRITICALITY		ignore
}

initialContextSetup S1AP-ELEMENTARY-PROCEDURE ::= {
	INITIATING MESSAGE	InitialContextSetupRequest
	SUCCESSFUL OUTCOME	InitialContextSetupResponse
	UNSUCCESSFUL OUTCOME InitialContextSetupFailure
	PROCEDURE CODE		id-InitialContextSetup
	CRITICALITY		reject
}

uEContextReleaseRequest S1AP-ELEMENTARY-PROCEDURE ::= {
	INITIATING MESSAGE		UEContextReleaseRequest
	PROCEDURE CODE			id-UEContextReleaseRequest
	CRITICALITY				ignore
}

paging S1AP-ELEMENTARY-PROCEDURE ::= {
	INITIATING MESSAGE	Paging
	PROCEDURE CODE		id-Paging
	CRITICALITY			ignore
}

downlinkNASTransport S1AP-ELEMENTARY-PROCEDURE ::= {
	INITIATING MESSAGE		DownlinkNASTransport
	PROCEDURE CODE			id-downlinkNASTransport
	CRITICALITY				ignore
}

initialUEMessage S1AP-ELEMENTARY-PROCEDURE ::= {
	INITIATING MESSAGE		InitialUEMessage
	PROCEDURE CODE			id-initialUEMessage
	CRITICALITY				ignore
}

uplinkNASTransport S1AP-ELEMENTARY-PROCEDURE ::= {
	INITIATING MESSAGE		UplinkNASTransport
	PROCEDURE CODE			id-uplinkNASTransport
	CRITICALITY				ignore
}
nASNonDeliveryIndication S1AP-ELEMENTARY-PROCEDURE ::= {
	INITIATING MESSAGE		NASNonDeliveryIndication
	PROCEDURE CODE			id-NASNonDeliveryIndication
	CRITICALITY				ignore
}

handoverCancel S1AP-ELEMENTARY-PROCEDURE ::= {
	INITIATING MESSAGE	HandoverCancel
	SUCCESSFUL OUTCOME	HandoverCancelAcknowledge
	PROCEDURE CODE			id-HandoverCancel
	CRITICALITY		reject
}

reset S1AP-ELEMENTARY-PROCEDURE ::= {
	INITIATING MESSAGE	Reset
	SUCCESSFUL OUTCOME	ResetAcknowledge
	PROCEDURE CODE		id-Reset
	CRITICALITY			reject
}

errorIndication S1AP-ELEMENTARY-PROCEDURE ::= {
	INITIATING MESSAGE	ErrorIndication
	PROCEDURE CODE		id-ErrorIndication
	CRITICALITY		ignore
}

s1Setup S1AP-ELEMENTARY-PROCEDURE ::= {
	INITIATING MESSAGE		S1SetupRequest
	SUCCESSFUL OUTCOME		S1SetupResponse
	UNSUCCESSFUL OUTCOME 	S1SetupFailure
	PROCEDURE CODE			id-S1Setup
	CRITICALITY				reject
}

eNBConfigurationUpdate S1AP-ELEMENTARY-PROCEDURE ::= {
	INITIATING MESSAGE		ENBConfigurationUpdate
	SUCCESSFUL OUTCOME		ENBConfigurationUpdateAcknowledge
	UNSUCCESSFUL OUTCOME 	ENBConfigurationUpdateFailure
	PROCEDURE CODE			id-ENBConfigurationUpdate
	CRITICALITY				reject
}

mMEConfigurationUpdate S1AP-ELEMENTARY-PROCEDURE ::= {
	INITIATING MESSAGE		MMEConfigurationUpdate
	SUCCESSFUL OUTCOME		MMEConfigurationUpdateAcknowledge
	UNSUCCESSFUL OUTCOME 	MMEConfigurationUpdateFailure
	PROCEDURE CODE			id-MMEConfigurationUpdate
	CRITICALITY				reject
}

downlinkS1cdma2000tunneling S1AP-ELEMENTARY-PROCEDURE ::= {
	INITIATING MESSAGE		DownlinkS1cdma2000tunneling
	PROCEDURE CODE			id-DownlinkS1cdma2000tunneling
	CRITICALITY				ignore
}

uplinkS1cdma2000tunneling S1AP-ELEMENTARY-PROCEDURE ::= {
	INITIATING MESSAGE		UplinkS1cdma2000tunneling
	PROCEDURE CODE			id-UplinkS1cdma2000tunneling
	CRITICALITY				ignore
}

uEContextModification S1AP-ELEMENTARY-PROCEDURE ::= {
	INITIATING MESSAGE		UEContextModificationRequest
	SUCCESSFUL OUTCOME		UEContextModificationResponse
	UNSUCCESSFUL OUTCOME 	UEContextModificationFailure

	PROCEDURE CODE		id-UEContextModification
	CRITICALITY		reject
}

uECapabilityInfoIndication S1AP-ELEMENTARY-PROCEDURE ::= {
	INITIATING MESSAGE		UECapabilityInfoIndication
	PROCEDURE CODE			id-UECapabilityInfoIndication
	CRITICALITY				ignore
}

uEContextRelease S1AP-ELEMENTARY-PROCEDURE ::= {
	INITIATING MESSAGE		UEContextReleaseCommand
	SUCCESSFUL OUTCOME		UEContextReleaseComplete
	PROCEDURE CODE			id-UEContextRelease
	CRITICALITY				reject
}

eNBStatusTransfer S1AP-ELEMENTARY-PROCEDURE ::= {
	INITIATING MESSAGE		ENBStatusTransfer
	PROCEDURE CODE			id-eNBStatusTransfer
	CRITICALITY				ignore
}

mMEStatusTransfer S1AP-ELEMENTARY-PROCEDURE ::= {
	INITIATING MESSAGE		MMEStatusTransfer
	PROCEDURE CODE			id-MMEStatusTransfer
	CRITICALITY				ignore
}

deactivateTrace S1AP-ELEMENTARY-PROCEDURE ::= {
	INITIATING MESSAGE		DeactivateTrace
	PROCEDURE CODE			id-DeactivateTrace
	CRITICALITY				ignore
}

traceStart S1AP-ELEMENTARY-PROCEDURE ::= {
	INITIATING MESSAGE	TraceStart
	PROCEDURE CODE		id-TraceStart
	CRITICALITY			ignore
}

traceFailureIndication S1AP-ELEMENTARY-PROCEDURE ::= {
	INITIATING MESSAGE	TraceFailureIndication
	PROCEDURE CODE		id-TraceFailureIndication
	CRITICALITY			ignore
}
cellTrafficTrace S1AP-ELEMENTARY-PROCEDURE ::={
     INITIATING MESSAGE CellTrafficTrace
     PROCEDURE CODE      id-CellTrafficTrace
     CRITICALITY         ignore
}

locationReportingControl S1AP-ELEMENTARY-PROCEDURE ::= {
	INITIATING MESSAGE		LocationReportingControl
	PROCEDURE CODE			id-LocationReportingControl
	CRITICALITY				ignore
}

locationReportingFailureIndication S1AP-ELEMENTARY-PROCEDURE ::= {
	INITIATING MESSAGE		LocationReportingFailureIndication
	PROCEDURE CODE			id-LocationReportingFailureIndication
	CRITICALITY				ignore
}

locationReport S1AP-ELEMENTARY-PROCEDURE ::= {
	INITIATING MESSAGE		LocationReport
	PROCEDURE CODE			id-LocationReport
	CRITICALITY				ignore
}

overloadStart S1AP-ELEMENTARY-PROCEDURE ::= {
	INITIATING MESSAGE	OverloadStart
	PROCEDURE CODE		id-OverloadStart
	CRITICALITY		ignore
}

overloadStop S1AP-ELEMENTARY-PROCEDURE ::= {
	INITIATING MESSAGE	OverloadStop
	PROCEDURE CODE		id-OverloadStop
	CRITICALITY		reject
}

writeReplaceWarning S1AP-ELEMENTARY-PROCEDURE ::= {
	INITIATING MESSAGE	WriteReplaceWarningRequest
	SUCCESSFUL OUTCOME	WriteReplaceWarningResponse
	PROCEDURE CODE		id-WriteReplaceWarning
	CRITICALITY			reject
}

eNBDirectInformationTransfer S1AP-ELEMENTARY-PROCEDURE ::= {
	INITIATING MESSAGE	ENBDirectInformationTransfer
	PROCEDURE CODE		id-eNBDirectInformationTransfer
	CRITICALITY			ignore
}

mMEDirectInformationTransfer S1AP-ELEMENTARY-PROCEDURE ::= {
	INITIATING MESSAGE	MMEDirectInformationTransfer
	PROCEDURE CODE		id-MMEDirectInformationTransfer
	CRITICALITY			ignore
}

eNBConfigurationTransfer S1AP-ELEMENTARY-PROCEDURE ::= {
	INITIATING MESSAGE		ENBConfigurationTransfer
	PROCEDURE CODE			id-eNBConfigurationTransfer
	CRITICALITY				ignore
}

mMEConfigurationTransfer S1AP-ELEMENTARY-PROCEDURE ::= {
	INITIATING MESSAGE		MMEConfigurationTransfer
	PROCEDURE CODE			id-MMEConfigurationTransfer
	CRITICALITY				ignore
}


privateMessage S1AP-ELEMENTARY-PROCEDURE ::= {
	INITIATING MESSAGE	PrivateMessage
	PROCEDURE CODE		id-PrivateMessage
	CRITICALITY			ignore
}

END
*/
