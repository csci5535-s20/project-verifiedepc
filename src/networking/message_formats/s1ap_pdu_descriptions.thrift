// S1AP-PDU-Descriptions

/*
-- **************************************************************
--
-- Elementary Procedure definitions
--
-- **************************************************************


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


/*
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
*/

// TODO: Is this classification correct? 
struct S1APElementaryProcedure{
	1: InitiatingMessage 				initiating_message;
	2: optional SuccessfulOutcome 		successful_outcome;
	3: optional UnsuccessfulOutcome 	unsuccessful_outcome; 
	4: ProcedureCode 					procedure_code;  //TODO : UNIQUE
	5: Criticality 						criticality = Criticality.IGNORE;

}

/*
-- **************************************************************
--
-- Interface PDU Definition
--
-- **************************************************************

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

*/

union S1APPDU{
	1: InitiatingMessage 		initiating_message;
	2: SuccessfulOutcome 		successful_outcome;
	3: UnsuccessfulOutcome 		unsuccessful_outcome; 
}

typedef S1APElementaryProcedure InitiatingMessage
typedef S1APElementaryProcedure SuccessfulOutcome
typedef S1APElementaryProcedure UnsuccessfulOutcome

/*
-- **************************************************************
--
-- Interface Elementary Procedure List
--
-- **************************************************************
*/



/*
S1AP-ELEMENTARY-PROCEDURES S1AP-ELEMENTARY-PROCEDURE ::= {
	S1AP-ELEMENTARY-PROCEDURES-CLASS-1		|
	S1AP-ELEMENTARY-PROCEDURES-CLASS-2,	
	...
}
*/
const list<S1APElementaryProcedure> S1APElementaryProcedures = [S1APElementaryProceduresClass1, S1APElementaryProceduresClass2];

/*
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
*/
const list<S1APElementaryProcedure> S1APElementaryProceduresClass1 = [
	HandoverPreparationEP,
	HandoverResourceAllocationEP,
	PathSwitchRequestEP,
	ERABSetupEP,
	ERABModifyEP,
	ERABReleaseEP,
	InitialContextSetupEP,
	HandoverCancelEP,
	ResetEP,
	S1SetupEP,
	UEContextModificationEP,
	UEContextReleaseEP,
	ENBConfigurationUpdateEP,
	MMEConfigurationUpdateEP,
	WriteReplaceWarningEP ]


/*
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

*/
const list<S1APElementaryProcedure> S1APElementaryProceduresClass2 = [
	HandoverNotificationEP,
	ERABReleaseIndicationEP,
	PagingEP,
	DownlinkNASTransportEP,
	InitialUEMessageEP,
	UplinkNASTransportEP,
	ErrorIndicationEP,
	NASNonDeliveryIndicationEP,
	UEContextReleaseRequestEP,
	DownlinkS1cdma2000tunnelingEP,
	UplinkS1cdma2000tunnelingEP,
	UECapabilityInfoIndicationEP,
	ENBStatusTransferEP,
	MMEStatusTransferEP,
	DeactivateTraceEP,
	TraceStartEP,
	TraceFailureIndicationEP,
	CellTrafficTraceEP,
	LocationReportingControlEP,
	LocationReportingFailureIndicationEP,
	LocationReportEP,
	OverloadStartEP,
	OverloadStopEP,
	ENBDirectInformationTransferEP,
	MMEDirectInformationTransferEP,
	ENBConfigurationTransferEP,
	MMEConfigurationTransferEP,
	PrivateMessageEP
]


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
