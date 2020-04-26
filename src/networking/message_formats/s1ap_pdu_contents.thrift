// **************************************************************
// PDU definitions for S1AP. <Complete List of Tasks>
// **************************************************************



< incomplete: need to translate all the message desciptions from ASN.1 notation to thrift format.
> 






/*

-- **************************************************************
--
-- PDU definitions for S1AP.
--
-- **************************************************************

S1AP-PDU-Contents { 
itu-t (0) identified-organization (4) etsi (0) mobileDomain (0) 
eps-Access (21) modules (3) s1ap (1) version1 (1) s1ap-PDU-Contents (1) }

DEFINITIONS AUTOMATIC TAGS ::= 

BEGIN

-- **************************************************************
--
-- IE parameter types from other modules.
--
-- **************************************************************

IMPORTS
	
	UEAggregateMaximumBitrate,
	Cause,
	Cdma2000HORequiredIndication,
	Cdma2000HOStatus,
	Cdma2000OneXSRVCCInfo,
	Cdma2000OneXRAND,
	Cdma2000PDU,
	Cdma2000RATType,
	Cdma2000SectorID,
	CNDomain,
	CriticalityDiagnostics,
	CSFallbackIndicator,
	CSG-Id,
	CSG-IdList,
	Direct-Forwarding-Path-Availability,
	Global-ENB-ID,
	EUTRAN-CGI,
	ENBname,
	ENB-StatusTransfer-TransparentContainer,
	ENB-UE-S1AP-ID,
	GTP-TEID,
	GUMMEI,
	HandoverRestrictionList,
	HandoverType,
	MMEname,
	MME-UE-S1AP-ID,
	MSClassmark2,
	MSClassmark3,
	NAS-PDU,
	NASSecurityParametersfromE-UTRAN,
	NASSecurityParameterstoE-UTRAN,
	OverloadResponse,
	PagingDRX,
	PLMNidentity,
	RIMTransfer,
	RelativeMMECapacity,
	RequestType,
	E-RAB-ID,
	E-RABLevelQoSParameters,
	E-RABList,
	SecurityKey,
	SecurityContext,
	ServedGUMMEIs,
	SONConfigurationTransfer,
	Source-ToTarget-TransparentContainer,
	SourceBSS-ToTargetBSS-TransparentContainer,
	SourceeNB-ToTargeteNB-TransparentContainer,
	SourceRNC-ToTargetRNC-TransparentContainer,
	SubscriberProfileIDforRFP,
	SRVCCOperationPossible,
	SRVCCHOIndication,
	SupportedTAs,
	TAI,
	Target-ToSource-TransparentContainer,
	TargetBSS-ToSourceBSS-TransparentContainer,	
	TargeteNB-ToSourceeNB-TransparentContainer,
	TargetID,
	TargetRNC-ToSourceRNC-TransparentContainer,
	TimeToWait,
	TraceActivation,
	E-UTRAN-Trace-ID,
	TransportLayerAddress,
	UEIdentityIndexValue,
	UEPagingID,
	UERadioCapability,
	UE-S1AP-IDs,
	UE-associatedLogicalS1-ConnectionItem,
	UESecurityCapabilities,
	S-TMSI,
	MessageIdentifier,
	SerialNumber,
	WarningAreaList,
	RepetitionPeriod,
	NumberofBroadcastRequest,
	WarningType,
	WarningSecurityInfo,
	DataCodingScheme,
	WarningMessageContents,
	BroadcastCompletedAreaList,
	RRC-Establishment-Cause

FROM S1AP-IEs

	PrivateIE-Container{},
	ProtocolExtensionContainer{},
	ProtocolIE-Container{},
	ProtocolIE-ContainerList{},
	ProtocolIE-ContainerPair{},
	ProtocolIE-ContainerPairList{},
	ProtocolIE-SingleContainer{},
	S1AP-PRIVATE-IES, 					--> S1apPrivateIES
	S1AP-PROTOCOL-EXTENSION,			--> S1apProtocolExtension
	S1AP-PROTOCOL-IES, 					--> S1apProtocolIES
	S1AP-PROTOCOL-IES-PAIR 				--> S1apProtocolIESPair
FROM S1AP-Containers


	id-uEaggregateMaximumBitrate,
	id-Cause,
	id-cdma2000HORequiredIndication,
	id-cdma2000HOStatus,
	id-cdma2000OneXSRVCCInfo,
	id-cdma2000OneXRAND,
	id-cdma2000PDU,
	id-cdma2000RATType,
	id-cdma2000SectorID,
	id-CNDomain,
	id-CriticalityDiagnostics,
	id-CSFallbackIndicator,
	id-CSG-Id,
	id-CSG-IdList,
	id-DefaultPagingDRX,
	id-Direct-Forwarding-Path-Availability,
	id-Global-ENB-ID,
	id-EUTRAN-CGI,
	id-eNBname,
	id-eNB-StatusTransfer-TransparentContainer,
	id-eNB-UE-S1AP-ID, 
	id-GERANtoLTEHOInformationRes,
	id-GUMMEI-ID,
	id-HandoverRestrictionList,
	id-HandoverType,
	id-InitialContextSetup,
	id-Inter-SystemInformationTransferTypeEDT,
	id-Inter-SystemInformationTransferTypeMDT,
	id-NAS-DownlinkCount,
	id-MMEname,
	id-MME-UE-S1AP-ID,
	id-MSClassmark2,
	id-MSClassmark3,
	id-NAS-PDU,
	id-NASSecurityParametersfromE-UTRAN,
	id-NASSecurityParameterstoE-UTRAN,
	id-OverloadResponse,
	id-pagingDRX,
	id-RelativeMMECapacity,
	id-RequestType,
	id-E-RABAdmittedItem,
	id-E-RABAdmittedList,
	id-E-RABDataForwardingItem,
	id-E-RABFailedToModifyList,
	id-E-RABFailedToReleaseList,
	id-E-RABFailedtoSetupItemHOReqAck,
	id-E-RABFailedToSetupListBearerSURes,
	id-E-RABFailedToSetupListCtxtSURes,
	id-E-RABFailedToSetupListHOReqAck,
	id-E-RABFailedToBeReleasedList,
	id-E-RABModify,
	id-E-RABModifyItemBearerModRes,
	id-E-RABModifyListBearerModRes,
	id-E-RABRelease,
	id-E-RABReleaseItemBearerRelComp,
	id-E-RABReleaseItemHOCmd,
	id-E-RABReleaseListBearerRelComp,
	id-E-RABReleaseIndication,
	id-E-RABSetup,
	id-E-RABSetupItemBearerSURes,
	id-E-RABSetupItemCtxtSURes,
	id-E-RABSetupListBearerSURes,
	id-E-RABSetupListCtxtSURes,
	id-E-RABSubjecttoDataForwardingList,
	id-E-RABToBeModifiedItemBearerModReq,
	id-E-RABToBeModifiedListBearerModReq,
	id-E-RABToBeReleasedList,
	id-E-RABReleasedList,
	id-E-RABToBeSetupItemBearerSUReq,
	id-E-RABToBeSetupItemCtxtSUReq,
	id-E-RABToBeSetupItemHOReq,
	id-E-RABToBeSetupListBearerSUReq,
	id-E-RABToBeSetupListCtxtSUReq,
	id-E-RABToBeSetupListHOReq,
	id-E-RABToBeSwitchedDLItem,
	id-E-RABToBeSwitchedDLList,
	id-E-RABToBeSwitchedULList,
	id-E-RABToBeSwitchedULItem,
	id-E-RABtoReleaseListHOCmd,
	id-SecurityKey,
	id-SecurityContext,
	id-ServedGUMMEIs,
	id-SONConfigurationTransferECT,
	id-SONConfigurationTransferMCT,
	id-Source-ToTarget-TransparentContainer,
	id-Source-ToTarget-TransparentContainer-Secondary,
	id-SourceMME-UE-S1AP-ID,
	id-SRVCCOperationPossible,
	id-SRVCCHOIndication,
	id-SubscriberProfileIDforRFP,
	id-SupportedTAs,
	id-S-TMSI,
	id-TAI,
	id-TAIItem,
	id-TAIList,
	id-Target-ToSource-TransparentContainer,
	id-Target-ToSource-TransparentContainer-Secondary,
	id-TargetID,
	id-TimeToWait,
	id-TraceActivation,
	id-E-UTRAN-Trace-ID,
	id-UEIdentityIndexValue,
	id-UEPagingID,
	id-UERadioCapability,
	id-UTRANtoLTEHOInformationRes,
	id-UE-associatedLogicalS1-ConnectionListResAck,
	id-UE-associatedLogicalS1-ConnectionItem,
	id-UESecurityCapabilities,
	id-UE-S1AP-IDs,
	id-ResetType,
	id-MessageIdentifier,
	id-SerialNumber,
	id-WarningAreaList,
	id-RepetitionPeriod,
	id-NumberofBroadcastRequest,
	id-WarningType,
	id-WarningSecurityInfo,
	id-DataCodingScheme,
	id-WarningMessageContents,
	id-BroadcastCompletedAreaList,
	id-RRC-Establishment-Cause,
	id-TraceCollectionEntityIPAddress,
	maxnoofTAIs,
	maxNrOfErrors,
	maxNrOfE-RABs,
	maxNrOfIndividualS1ConnectionsToReset,
	maxnoofEmergencyAreaID,
	maxnoofCellID,
	maxnoofTAIforWarning,
	maxnoofCellinTAI,
	maxnoofCellinEAI


FROM S1AP-Constants;

-- **************************************************************
--
-- Common Container Lists
--
-- **************************************************************

ProtocolError-IE-ContainerList	{ S1AP-PROTOCOL-IES      : IEsSetParam }	::= ProtocolIE-ContainerList     { 1, maxNrOfE-RABs,   {IEsSetParam} }


E-RAB-IE-ContainerList			{ S1AP-PROTOCOL-IES      : IEsSetParam }	::= ProtocolIE-ContainerList     { 1, maxNrOfE-RABs,   {IEsSetParam} }

E-RAB-IE-ContainerPairList		{ S1AP-PROTOCOL-IES-PAIR : IEsSetParam }	::= ProtocolIE-ContainerPairList { 1, maxNrOfE-RABs,   {IEsSetParam} }


-- **************************************************************
--
-- HANDOVER PREPARATION ELEMENTARY PROCEDURE
--
-- **************************************************************

-- **************************************************************
--
-- Handover Required
--
-- **************************************************************

HandoverRequired ::= SEQUENCE {
	protocolIEs			ProtocolIE-Container       { { HandoverRequiredIEs} },
	...
}

HandoverRequiredIEs S1AP-PROTOCOL-IES ::= {	
	{ ID id-MME-UE-S1AP-ID							CRITICALITY reject	TYPE MME-UE-S1AP-ID		 							PRESENCE mandatory	} |
	{ ID id-eNB-UE-S1AP-ID							CRITICALITY reject	TYPE ENB-UE-S1AP-ID		 							PRESENCE mandatory	} |
	{ ID id-HandoverType							CRITICALITY reject	TYPE HandoverType		 							PRESENCE mandatory	} |
	{ ID id-Cause									CRITICALITY ignore	TYPE Cause		 									PRESENCE mandatory	} |
	{ ID id-TargetID								CRITICALITY reject	TYPE TargetID	 									PRESENCE mandatory	} |
	{ ID id-Direct-Forwarding-Path-Availability		CRITICALITY ignore	TYPE Direct-Forwarding-Path-Availability		PRESENCE optional } |
	{ ID id-SRVCCHOIndication						CRITICALITY reject	TYPE	SRVCCHOIndication							PRESENCE optional }|
	{ ID id-Source-ToTarget-TransparentContainer	CRITICALITY reject 	TYPE Source-ToTarget-TransparentContainer 	PRESENCE mandatory }|
	{ ID id-Source-ToTarget-TransparentContainer-Secondary 	CRITICALITY reject 	TYPE Source-ToTarget-TransparentContainer 	PRESENCE optional }|
	{ ID id-MSClassmark2							CRITICALITY reject	TYPE MSClassmark2									PRESENCE  conditional }|
	{ ID id-MSClassmark3							CRITICALITY ignore	TYPE MSClassmark3									PRESENCE conditional },
	...
}


-- **************************************************************
--
-- Handover Command
--
-- **************************************************************

HandoverCommand ::= SEQUENCE {
	protocolIEs			ProtocolIE-Container { { HandoverCommandIEs} },
	...
}

HandoverCommandIEs S1AP-PROTOCOL-IES ::= {	
	{ ID id-MME-UE-S1AP-ID							CRITICALITY reject	TYPE MME-UE-S1AP-ID		 									PRESENCE mandatory	} |
	{ ID id-eNB-UE-S1AP-ID							CRITICALITY reject	TYPE ENB-UE-S1AP-ID		 									PRESENCE mandatory	} |
	{ ID id-HandoverType							CRITICALITY reject	TYPE HandoverType		 									PRESENCE mandatory	} |
	{ ID id-NASSecurityParametersfromE-UTRAN		CRITICALITY reject	TYPE NASSecurityParametersfromE-UTRAN					PRESENCE conditional
	-- This IE shall be present if HandoverType IE is set to value "LTEtoUTRAN" or "LTEtoGERAN" --			}|
	{ ID id-E-RABSubjecttoDataForwardingList		CRITICALITY ignore	TYPE E-RABSubjecttoDataForwardingList		 			PRESENCE optional	} |
	{ ID id-E-RABtoReleaseListHOCmd					CRITICALITY ignore	TYPE E-RABList		 										PRESENCE optional	} |
	{ ID id-Target-ToSource-TransparentContainer	CRITICALITY	reject	TYPE Target-ToSource-TransparentContainer			PRESENCE mandatory }|
	{ ID id-Target-ToSource-TransparentContainer-Secondary	CRITICALITY	reject	TYPE Target-ToSource-TransparentContainer			PRESENCE optional }|
	{ ID id-CriticalityDiagnostics					CRITICALITY ignore	TYPE CriticalityDiagnostics								PRESENCE optional	},
	...
}

E-RABSubjecttoDataForwardingList ::= E-RAB-IE-ContainerList { {E-RABDataForwardingItemIEs} }

E-RABDataForwardingItemIEs S1AP-PROTOCOL-IES ::= {
	{ ID id-E-RABDataForwardingItem			CRITICALITY ignore	TYPE E-RABDataForwardingItem			PRESENCE mandatory	},
	...
}

E-RABDataForwardingItem ::= SEQUENCE {
	e-RAB-ID							E-RAB-ID,
	dL-transportLayerAddress			TransportLayerAddress 													OPTIONAL,
	dL-gTP-TEID							GTP-TEID 																OPTIONAL,
	uL-TransportLayerAddress			TransportLayerAddress													OPTIONAL,
	uL-GTP-TEID							GTP-TEID																OPTIONAL,
	iE-Extensions						ProtocolExtensionContainer { { E-RABDataForwardingItem-ExtIEs} }	OPTIONAL,
	...
}

E-RABDataForwardingItem-ExtIEs S1AP-PROTOCOL-EXTENSION ::= {
	...
}



-- **************************************************************
--
-- Handover Preparation Failure
--
-- **************************************************************

HandoverPreparationFailure ::= SEQUENCE {
	protocolIEs			ProtocolIE-Container       { { HandoverPreparationFailureIEs} },
	...
}

HandoverPreparationFailureIEs S1AP-PROTOCOL-IES ::= {	
	{ ID id-MME-UE-S1AP-ID					CRITICALITY ignore	TYPE MME-UE-S1AP-ID		 			PRESENCE mandatory	} |
	{ ID id-eNB-UE-S1AP-ID					CRITICALITY ignore	TYPE ENB-UE-S1AP-ID		 			PRESENCE mandatory	} |
	{ ID id-Cause							CRITICALITY ignore	TYPE Cause		 					PRESENCE mandatory	}|
	{ ID id-CriticalityDiagnostics			CRITICALITY ignore	TYPE CriticalityDiagnostics			PRESENCE optional	},
	...
}

-- **************************************************************
--
-- HANDOVER RESOURCE ALLOCATION ELEMENTARY PROCEDURE
--
-- **************************************************************

-- **************************************************************
--
-- Handover Request
--
-- **************************************************************

HandoverRequest ::= SEQUENCE {
	protocolIEs			ProtocolIE-Container       { {HandoverRequestIEs} },
	...
}

HandoverRequestIEs S1AP-PROTOCOL-IES ::= {	
	{ ID id-MME-UE-S1AP-ID							CRITICALITY reject	TYPE MME-UE-S1AP-ID									PRESENCE mandatory	} |
	{ ID id-HandoverType							CRITICALITY reject	TYPE HandoverType									PRESENCE mandatory	} |
	{ ID id-Cause									CRITICALITY ignore	TYPE Cause		 									PRESENCE mandatory	} |
	{ ID id-uEaggregateMaximumBitrate				CRITICALITY reject	TYPE UEAggregateMaximumBitrate					PRESENCE mandatory	}|
	{ ID id-E-RABToBeSetupListHOReq					CRITICALITY reject	TYPE E-RABToBeSetupListHOReq		 				PRESENCE mandatory	} |
	{ ID id-Source-ToTarget-TransparentContainer	CRITICALITY reject	TYPE Source-ToTarget-TransparentContainer	PRESENCE mandatory	} |
	{ ID id-UESecurityCapabilities					CRITICALITY reject	TYPE UESecurityCapabilities						PRESENCE mandatory	}|
	{ ID id-HandoverRestrictionList					CRITICALITY ignore	TYPE HandoverRestrictionList						PRESENCE optional	}|
	{ ID id-TraceActivation							CRITICALITY ignore	TYPE TraceActivation								PRESENCE optional	}|
	{ ID id-RequestType								CRITICALITY ignore	TYPE RequestType									PRESENCE optional	}|
	{ ID id-SRVCCOperationPossible					CRITICALITY ignore	TYPE SRVCCOperationPossible						PRESENCE optional	}|
	{ ID id-SecurityContext							CRITICALITY reject	TYPE SecurityContext								PRESENCE mandatory}|
	{ ID id-NASSecurityParameterstoE-UTRAN			CRITICALITY reject	TYPE NASSecurityParameterstoE-UTRAN			PRESENCE conditional
	-- This IE shall be present if the Handover Type IE is set to the value "UTRANtoLTE" or "GERANtoLTE" --	},
	...
}

E-RABToBeSetupListHOReq 					::= E-RAB-IE-ContainerList { {E-RABToBeSetupItemHOReqIEs} }

E-RABToBeSetupItemHOReqIEs S1AP-PROTOCOL-IES ::= {
	{ ID id-E-RABToBeSetupItemHOReq			CRITICALITY reject	TYPE E-RABToBeSetupItemHOReq			PRESENCE mandatory	},
	...
}

E-RABToBeSetupItemHOReq ::= SEQUENCE {
	e-RAB-ID							E-RAB-ID,
	transportLayerAddress				TransportLayerAddress,
	gTP-TEID							GTP-TEID,
	e-RABlevelQosParameters				E-RABLevelQoSParameters,
	iE-Extensions						ProtocolExtensionContainer { {E-RABToBeSetupItemHOReq-ExtIEs} }			OPTIONAL,
	...
}

E-RABToBeSetupItemHOReq-ExtIEs S1AP-PROTOCOL-EXTENSION ::= {
	...
}

-- **************************************************************
--
-- Handover Request Acknowledge
--
-- **************************************************************

HandoverRequestAcknowledge ::= SEQUENCE {
	protocolIEs			ProtocolIE-Container       { {HandoverRequestAcknowledgeIEs} },
	...
}

HandoverRequestAcknowledgeIEs S1AP-PROTOCOL-IES ::= {	
	{ ID id-MME-UE-S1AP-ID							CRITICALITY ignore	TYPE MME-UE-S1AP-ID									PRESENCE mandatory	} |
	{ ID id-eNB-UE-S1AP-ID							CRITICALITY ignore	TYPE ENB-UE-S1AP-ID									PRESENCE mandatory	} |
	{ ID id-E-RABAdmittedList						CRITICALITY ignore	TYPE E-RABAdmittedList								PRESENCE mandatory	} |
	{ ID id-E-RABFailedToSetupListHOReqAck			CRITICALITY ignore	TYPE E-RABFailedtoSetupListHOReqAck			PRESENCE optional	} |
	{ ID id-Target-ToSource-TransparentContainer	CRITICALITY reject	TYPE Target-ToSource-TransparentContainer	PRESENCE mandatory }|
	{ ID id-CriticalityDiagnostics					CRITICALITY ignore	TYPE CriticalityDiagnostics						PRESENCE optional	},
	...
}

E-RABAdmittedList 					::= E-RAB-IE-ContainerList { {E-RABAdmittedItemIEs} }

E-RABAdmittedItemIEs S1AP-PROTOCOL-IES ::= {
	{ ID id-E-RABAdmittedItem			CRITICALITY ignore	TYPE E-RABAdmittedItem			PRESENCE mandatory	},
	...
}

E-RABAdmittedItem ::= SEQUENCE {
	e-RAB-ID						E-RAB-ID,
	transportLayerAddress			TransportLayerAddress,
	gTP-TEID						GTP-TEID,
	dL-transportLayerAddress		TransportLayerAddress	OPTIONAL,
	dL-gTP-TEID						GTP-TEID				OPTIONAL,
	uL-TransportLayerAddress		TransportLayerAddress	OPTIONAL,
	uL-GTP-TEID						GTP-TEID				OPTIONAL,
	iE-Extensions					ProtocolExtensionContainer { {E-RABAdmittedItem-ExtIEs} }	OPTIONAL,
	...
}

E-RABAdmittedItem-ExtIEs S1AP-PROTOCOL-EXTENSION ::= {
	...
}

E-RABFailedtoSetupListHOReqAck 					::= E-RAB-IE-ContainerList { {E-RABFailedtoSetupItemHOReqAckIEs} }

E-RABFailedtoSetupItemHOReqAckIEs S1AP-PROTOCOL-IES ::= {
	{ ID id-E-RABFailedtoSetupItemHOReqAck			CRITICALITY ignore	TYPE E-RABFailedToSetupItemHOReqAck			PRESENCE mandatory	},
	...
}

E-RABFailedToSetupItemHOReqAck ::= SEQUENCE {
	e-RAB-ID						E-RAB-ID,
	cause				Cause,
	iE-Extensions					ProtocolExtensionContainer { { E-RABFailedToSetupItemHOReqAckExtIEs} }			OPTIONAL,
	...
}

E-RABFailedToSetupItemHOReqAckExtIEs S1AP-PROTOCOL-EXTENSION ::= {
	...
}


-- **************************************************************
--
-- Handover Failure
--
-- **************************************************************

HandoverFailure ::= SEQUENCE {
	protocolIEs			ProtocolIE-Container       { { HandoverFailureIEs} },
	...
}

HandoverFailureIEs S1AP-PROTOCOL-IES ::= {	
	{ ID id-MME-UE-S1AP-ID				CRITICALITY ignore	TYPE MME-UE-S1AP-ID				PRESENCE mandatory	} |
	{ ID id-Cause						CRITICALITY ignore	TYPE Cause		 				PRESENCE mandatory	}|
	{ ID id-CriticalityDiagnostics		CRITICALITY ignore	TYPE CriticalityDiagnostics		PRESENCE optional	},
	...
}

-- **************************************************************
--
-- HANDOVER NOTIFICATION ELEMENTARY PROCEDURE
--
-- **************************************************************

-- **************************************************************
--
-- Handover Notify
--
-- **************************************************************

HandoverNotify ::= SEQUENCE {
	protocolIEs			ProtocolIE-Container       { { HandoverNotifyIEs} },
	...
}

HandoverNotifyIEs S1AP-PROTOCOL-IES ::= {	
	{ ID id-MME-UE-S1AP-ID			CRITICALITY reject	TYPE MME-UE-S1AP-ID			PRESENCE mandatory	} |
	{ ID id-eNB-UE-S1AP-ID			CRITICALITY reject	TYPE ENB-UE-S1AP-ID			PRESENCE mandatory	} |
	{ ID id-EUTRAN-CGI				CRITICALITY ignore	TYPE EUTRAN-CGI				PRESENCE mandatory}|
	{ ID id-TAI						CRITICALITY ignore	TYPE TAI					PRESENCE mandatory},
	...
}

-- **************************************************************
--
-- PATH SWITCH REQUEST ELEMENTARY PROCEDURE
--
-- **************************************************************

-- **************************************************************
--
-- Path Switch Request
--
-- **************************************************************

PathSwitchRequest ::= SEQUENCE {
	protocolIEs			ProtocolIE-Container       { { PathSwitchRequestIEs} },
	...
}

PathSwitchRequestIEs S1AP-PROTOCOL-IES ::= {	
	{ ID id-eNB-UE-S1AP-ID					CRITICALITY reject	TYPE ENB-UE-S1AP-ID	 			PRESENCE mandatory	}|
	{ ID id-E-RABToBeSwitchedDLList			CRITICALITY reject	TYPE E-RABToBeSwitchedDLList	PRESENCE mandatory	}|
	{ ID id-SourceMME-UE-S1AP-ID			CRITICALITY reject	TYPE MME-UE-S1AP-ID	 			PRESENCE mandatory	}|
	{ ID id-EUTRAN-CGI						CRITICALITY ignore	TYPE EUTRAN-CGI					PRESENCE mandatory}|
	{ ID id-TAI								CRITICALITY ignore	TYPE TAI						PRESENCE mandatory}|
	{ ID id-UESecurityCapabilities			CRITICALITY ignore	TYPE UESecurityCapabilities		PRESENCE mandatory	},
	...
}

E-RABToBeSwitchedDLList 					::= E-RAB-IE-ContainerList { {E-RABToBeSwitchedDLItemIEs} }

E-RABToBeSwitchedDLItemIEs S1AP-PROTOCOL-IES ::= {
	{ ID id-E-RABToBeSwitchedDLItem			CRITICALITY reject	TYPE E-RABToBeSwitchedDLItem			PRESENCE mandatory	},
	...
}

E-RABToBeSwitchedDLItem ::= SEQUENCE {
	e-RAB-ID						E-RAB-ID,
	transportLayerAddress				TransportLayerAddress,
	gTP-TEID					GTP-TEID,
	iE-Extensions					ProtocolExtensionContainer { { E-RABToBeSwitchedDLItem-ExtIEs} }			OPTIONAL,
	...
}

E-RABToBeSwitchedDLItem-ExtIEs S1AP-PROTOCOL-EXTENSION ::= {
	...
}

-- **************************************************************
--
-- Path Switch Request Acknowledge
--
-- **************************************************************

PathSwitchRequestAcknowledge ::= SEQUENCE {
	protocolIEs			ProtocolIE-Container       { { PathSwitchRequestAcknowledgeIEs} },
	...
}

PathSwitchRequestAcknowledgeIEs S1AP-PROTOCOL-IES ::= {	
	{ ID id-MME-UE-S1AP-ID					CRITICALITY ignore	TYPE MME-UE-S1AP-ID		 			PRESENCE mandatory	} |
	{ ID id-eNB-UE-S1AP-ID					CRITICALITY ignore	TYPE ENB-UE-S1AP-ID	 			PRESENCE mandatory	}|
	{ ID id-uEaggregateMaximumBitrate		CRITICALITY ignore	TYPE UEAggregateMaximumBitrate		PRESENCE optional	}|
	{ ID id-E-RABToBeSwitchedULList		CRITICALITY ignore	TYPE E-RABToBeSwitchedULList	PRESENCE optional }|
	{ ID id-E-RABToBeReleasedList		CRITICALITY ignore	TYPE E-RABList				PRESENCE optional	}|
	{ ID id-SecurityContext				CRITICALITY reject	TYPE	SecurityContext			PRESENCE mandatory}|
	{ ID id-CriticalityDiagnostics		CRITICALITY ignore	TYPE CriticalityDiagnostics			PRESENCE optional	},
	...
}

E-RABToBeSwitchedULList ::= E-RAB-IE-ContainerList { {E-RABToBeSwitchedULItemIEs} }

E-RABToBeSwitchedULItemIEs S1AP-PROTOCOL-IES ::= {
	{ ID id-E-RABToBeSwitchedULItem		CRITICALITY ignore	TYPE E-RABToBeSwitchedULItem	PRESENCE mandatory	},
	...
}

E-RABToBeSwitchedULItem ::= SEQUENCE {
	e-RAB-ID							E-RAB-ID,
	transportLayerAddress				TransportLayerAddress,
	gTP-TEID							GTP-TEID,
	iE-Extensions						ProtocolExtensionContainer { { E-RABToBeSwitchedULItem-ExtIEs} }			OPTIONAL,
	...
}

E-RABToBeSwitchedULItem-ExtIEs S1AP-PROTOCOL-EXTENSION ::= {
	...
}


-- **************************************************************
--
-- Path Switch Request Failure
--
-- **************************************************************

PathSwitchRequestFailure ::= SEQUENCE {
	protocolIEs			ProtocolIE-Container       { { PathSwitchRequestFailureIEs} },
	...
}

PathSwitchRequestFailureIEs S1AP-PROTOCOL-IES ::= {	
	{ ID id-MME-UE-S1AP-ID					CRITICALITY ignore	TYPE MME-UE-S1AP-ID		 			PRESENCE mandatory	} |
	{ ID id-eNB-UE-S1AP-ID					CRITICALITY ignore	TYPE ENB-UE-S1AP-ID	 				PRESENCE mandatory	} |
	{ ID id-Cause							CRITICALITY ignore	TYPE Cause		 					PRESENCE mandatory	}|
	{ ID id-CriticalityDiagnostics			CRITICALITY ignore	TYPE CriticalityDiagnostics			PRESENCE optional	},
	...
}

-- **************************************************************
--
-- HANDOVER CANCEL ELEMENTARY PROCEDURE
--
-- **************************************************************

-- **************************************************************
--
-- Handover Cancel
--
-- **************************************************************

HandoverCancel ::= SEQUENCE {
	protocolIEs			ProtocolIE-Container       { { HandoverCancelIEs} },
	...
}

HandoverCancelIEs S1AP-PROTOCOL-IES ::= {	
	{ ID id-MME-UE-S1AP-ID					CRITICALITY reject	TYPE MME-UE-S1AP-ID		 			PRESENCE mandatory	} |
	{ ID id-eNB-UE-S1AP-ID					CRITICALITY reject	TYPE ENB-UE-S1AP-ID		 			PRESENCE mandatory	} |
	{ ID id-Cause					CRITICALITY ignore	TYPE Cause		 			PRESENCE mandatory	},
	...
}

-- **************************************************************
--
-- Handover Cancel Request Acknowledge
--
-- **************************************************************

HandoverCancelAcknowledge ::= SEQUENCE {
	protocolIEs			ProtocolIE-Container       { { HandoverCancelAcknowledgeIEs} },
	...
}

HandoverCancelAcknowledgeIEs S1AP-PROTOCOL-IES ::= {	
	{ ID id-MME-UE-S1AP-ID					CRITICALITY ignore	TYPE MME-UE-S1AP-ID		 			PRESENCE mandatory	} |
	{ ID id-eNB-UE-S1AP-ID					CRITICALITY ignore	TYPE ENB-UE-S1AP-ID		 			PRESENCE mandatory	}|
	{ ID id-CriticalityDiagnostics		CRITICALITY ignore	TYPE CriticalityDiagnostics			PRESENCE optional	},
	...
}

-- **************************************************************
--
-- E-RAB SETUP ELEMENTARY PROCEDURE
--
-- **************************************************************

-- **************************************************************
--
-- E-RAB Setup Request
--
-- **************************************************************

E-RABSetupRequest ::= SEQUENCE {
	protocolIEs			ProtocolIE-Container       { {E-RABSetupRequestIEs} },
	...
}

E-RABSetupRequestIEs S1AP-PROTOCOL-IES ::= {
	{ ID id-MME-UE-S1AP-ID					CRITICALITY reject	TYPE MME-UE-S1AP-ID	 						PRESENCE mandatory	}|
	{ ID id-eNB-UE-S1AP-ID					CRITICALITY reject	TYPE ENB-UE-S1AP-ID	 						PRESENCE mandatory	}|
	{ ID id-uEaggregateMaximumBitrate		CRITICALITY reject	TYPE UEAggregateMaximumBitrate				PRESENCE optional	}|
	{ ID id-E-RABToBeSetupListBearerSUReq	CRITICALITY reject	TYPE E-RABToBeSetupListBearerSUReq		PRESENCE mandatory	},
	...
}

E-RABToBeSetupListBearerSUReq ::= SEQUENCE (SIZE(1.. maxNrOfE-RABs)) OF ProtocolIE-SingleContainer { {E-RABToBeSetupItemBearerSUReqIEs} }

E-RABToBeSetupItemBearerSUReqIEs 	S1AP-PROTOCOL-IES ::= {
	{ ID id-E-RABToBeSetupItemBearerSUReq	 CRITICALITY reject 	TYPE E-RABToBeSetupItemBearerSUReq 	PRESENCE mandatory },
	...
}

E-RABToBeSetupItemBearerSUReq ::= SEQUENCE {
	e-RAB-ID						E-RAB-ID,
	e-RABlevelQoSParameters			E-RABLevelQoSParameters,
	transportLayerAddress 			TransportLayerAddress,
	gTP-TEID						GTP-TEID,
	nAS-PDU							NAS-PDU,
	iE-Extensions					ProtocolExtensionContainer { {E-RABToBeSetupItemBearerSUReqExtIEs} } OPTIONAL,
	...
}


E-RABToBeSetupItemBearerSUReqExtIEs S1AP-PROTOCOL-EXTENSION ::= {
	...
}


-- **************************************************************
--
-- E-RAB Setup Response
--
-- **************************************************************

E-RABSetupResponse ::= SEQUENCE {
	protocolIEs			ProtocolIE-Container       { {E-RABSetupResponseIEs} },
	...
}

E-RABSetupResponseIEs S1AP-PROTOCOL-IES ::= {
	{ ID id-MME-UE-S1AP-ID				CRITICALITY ignore	TYPE MME-UE-S1AP-ID	 				PRESENCE mandatory	}|
	{ ID id-eNB-UE-S1AP-ID				CRITICALITY ignore	TYPE ENB-UE-S1AP-ID	 				PRESENCE mandatory	}|
	{ ID id-E-RABSetupListBearerSURes				CRITICALITY ignore	TYPE E-RABSetupListBearerSURes			PRESENCE optional	}|
	{ ID id-E-RABFailedToSetupListBearerSURes		CRITICALITY ignore	TYPE E-RABList					PRESENCE optional	}|
	{ ID id-CriticalityDiagnostics		CRITICALITY ignore	TYPE CriticalityDiagnostics			PRESENCE optional	},
	...
}


E-RABSetupListBearerSURes ::= SEQUENCE (SIZE(1.. maxNrOfE-RABs)) OF ProtocolIE-SingleContainer { {E-RABSetupItemBearerSUResIEs} }

E-RABSetupItemBearerSUResIEs 	S1AP-PROTOCOL-IES ::= {
	{ ID id-E-RABSetupItemBearerSURes	 CRITICALITY ignore 	TYPE E-RABSetupItemBearerSURes 	PRESENCE mandatory },
	...
}

E-RABSetupItemBearerSURes ::= SEQUENCE {
	e-RAB-ID					E-RAB-ID,
	transportLayerAddress		TransportLayerAddress,
	gTP-TEID					GTP-TEID,
	iE-Extensions				ProtocolExtensionContainer { {E-RABSetupItemBearerSUResExtIEs} } OPTIONAL,
	...
}


E-RABSetupItemBearerSUResExtIEs S1AP-PROTOCOL-EXTENSION ::= {
	...
}



-- **************************************************************
--
-- E-RAB MODIFY ELEMENTARY PROCEDURE
--
-- **************************************************************

-- **************************************************************
--
-- E-RAB Modify Request
--
-- **************************************************************

E-RABModifyRequest ::= SEQUENCE {
	protocolIEs			ProtocolIE-Container       { {E-RABModifyRequestIEs} },
	...
}

E-RABModifyRequestIEs S1AP-PROTOCOL-IES ::= {
	{ ID id-MME-UE-S1AP-ID						CRITICALITY reject	TYPE MME-UE-S1AP-ID								PRESENCE mandatory	}|
	{ ID id-eNB-UE-S1AP-ID						CRITICALITY reject	TYPE ENB-UE-S1AP-ID								PRESENCE mandatory	}|
	{ ID id-uEaggregateMaximumBitrate			CRITICALITY reject	TYPE UEAggregateMaximumBitrate				PRESENCE optional	}|
	{ ID id-E-RABToBeModifiedListBearerModReq	CRITICALITY reject	TYPE E-RABToBeModifiedListBearerModReq		PRESENCE mandatory	},
	...
}

E-RABToBeModifiedListBearerModReq ::= SEQUENCE (SIZE(1.. maxNrOfE-RABs)) OF ProtocolIE-SingleContainer { {E-RABToBeModifiedItemBearerModReqIEs} }

E-RABToBeModifiedItemBearerModReqIEs 	S1AP-PROTOCOL-IES ::= {
	{ ID id-E-RABToBeModifiedItemBearerModReq	 CRITICALITY reject 	TYPE E-RABToBeModifiedItemBearerModReq 	PRESENCE mandatory },
	...
}

E-RABToBeModifiedItemBearerModReq ::= SEQUENCE {
	e-RAB-ID						E-RAB-ID,
	e-RABLevelQoSParameters			E-RABLevelQoSParameters,
	nAS-PDU							NAS-PDU,
	iE-Extensions					ProtocolExtensionContainer { {E-RABToBeModifyItemBearerModReqExtIEs} } OPTIONAL,
	...
}


E-RABToBeModifyItemBearerModReqExtIEs S1AP-PROTOCOL-EXTENSION ::= {
	...
}



-- **************************************************************
--
-- E-RAB Modify Response
--
-- **************************************************************

E-RABModifyResponse ::= SEQUENCE {
	protocolIEs			ProtocolIE-Container       { {E-RABModifyResponseIEs} },
	...
}

E-RABModifyResponseIEs S1AP-PROTOCOL-IES ::= {
	{ ID id-MME-UE-S1AP-ID				CRITICALITY ignore	TYPE MME-UE-S1AP-ID	 				PRESENCE mandatory	}|
	{ ID id-eNB-UE-S1AP-ID				CRITICALITY ignore	TYPE ENB-UE-S1AP-ID	 				PRESENCE mandatory	}|
	{ ID id-E-RABModifyListBearerModRes				CRITICALITY ignore	TYPE E-RABModifyListBearerModRes		PRESENCE optional	}|
	{ ID id-E-RABFailedToModifyList		CRITICALITY ignore	TYPE E-RABList				PRESENCE optional	}|
	{ ID id-CriticalityDiagnostics		CRITICALITY ignore	TYPE CriticalityDiagnostics			PRESENCE optional	},
	...
}


E-RABModifyListBearerModRes ::= SEQUENCE (SIZE(1.. maxNrOfE-RABs)) OF ProtocolIE-SingleContainer { {E-RABModifyItemBearerModResIEs} }

E-RABModifyItemBearerModResIEs 	S1AP-PROTOCOL-IES ::= {
	{ ID id-E-RABModifyItemBearerModRes	 CRITICALITY ignore 	TYPE E-RABModifyItemBearerModRes 	PRESENCE mandatory },
	...
}

E-RABModifyItemBearerModRes ::= SEQUENCE {
	e-RAB-ID					E-RAB-ID,
	iE-Extensions					ProtocolExtensionContainer { {E-RABModifyItemBearerModResExtIEs} } OPTIONAL,
	...
}


E-RABModifyItemBearerModResExtIEs S1AP-PROTOCOL-EXTENSION ::= {
	...
}




-- **************************************************************
--
-- E-RAB RELEASE ELEMENTARY PROCEDURE
--
-- **************************************************************

-- **************************************************************
--
-- E-RAB Release Command
--
-- **************************************************************

E-RABReleaseCommand ::= SEQUENCE {
	protocolIEs			ProtocolIE-Container		{ {E-RABReleaseCommandIEs} },
	...
}

E-RABReleaseCommandIEs S1AP-PROTOCOL-IES ::= {
	{ ID id-MME-UE-S1AP-ID				CRITICALITY reject	TYPE MME-UE-S1AP-ID	 				PRESENCE mandatory	}|
	{ ID id-eNB-UE-S1AP-ID				CRITICALITY reject	TYPE ENB-UE-S1AP-ID	 				PRESENCE mandatory	}|
	{ ID id-uEaggregateMaximumBitrate		CRITICALITY reject	TYPE UEAggregateMaximumBitrate		PRESENCE optional	}|
	{ ID id-E-RABToBeReleasedList		CRITICALITY ignore	TYPE E-RABList					PRESENCE mandatory	}|
	{ ID id-NAS-PDU							CRITICALITY ignore	TYPE NAS-PDU						PRESENCE optional	},
	...
}


-- **************************************************************
--
-- E-RAB Release Response
--
-- **************************************************************

E-RABReleaseResponse ::= SEQUENCE {
	protocolIEs			ProtocolIE-Container       { { E-RABReleaseResponseIEs } },
	...
}

E-RABReleaseResponseIEs S1AP-PROTOCOL-IES ::= {
	{ ID id-MME-UE-S1AP-ID				CRITICALITY ignore	TYPE MME-UE-S1AP-ID	 				PRESENCE mandatory	}|
	{ ID id-eNB-UE-S1AP-ID				CRITICALITY ignore	TYPE ENB-UE-S1AP-ID	 				PRESENCE mandatory	}|
	{ ID id-E-RABReleaseListBearerRelComp				CRITICALITY ignore	TYPE E-RABReleaseListBearerRelComp		PRESENCE optional	}|
	{ ID id-E-RABFailedToReleaseList		CRITICALITY ignore	TYPE E-RABList				PRESENCE optional	}|
	{ ID id-CriticalityDiagnostics		CRITICALITY ignore	TYPE CriticalityDiagnostics			PRESENCE optional	},
	...
}


E-RABReleaseListBearerRelComp ::= SEQUENCE (SIZE(1.. maxNrOfE-RABs)) OF ProtocolIE-SingleContainer { {E-RABReleaseItemBearerRelCompIEs} }

E-RABReleaseItemBearerRelCompIEs 	S1AP-PROTOCOL-IES ::= {
	{ ID id-E-RABReleaseItemBearerRelComp	 CRITICALITY ignore 	TYPE E-RABReleaseItemBearerRelComp 	PRESENCE mandatory },
	...
}

E-RABReleaseItemBearerRelComp ::= SEQUENCE {
	e-RAB-ID					E-RAB-ID,
	iE-Extensions					ProtocolExtensionContainer { {E-RABReleaseItemBearerRelCompExtIEs} } OPTIONAL,
	...
}


E-RABReleaseItemBearerRelCompExtIEs S1AP-PROTOCOL-EXTENSION ::= {
	...
}



-- **************************************************************
--
-- E-RAB RELEASE INDICATION ELEMENTARY PROCEDURE
--
-- **************************************************************

-- **************************************************************
--
-- E-RAB Release Indication
--
-- **************************************************************

E-RABReleaseIndication ::= SEQUENCE {
	protocolIEs			ProtocolIE-Container       { {E-RABReleaseIndicationIEs} },
	...
}

E-RABReleaseIndicationIEs S1AP-PROTOCOL-IES ::= {
	{ ID id-MME-UE-S1AP-ID				CRITICALITY reject	TYPE MME-UE-S1AP-ID	 				PRESENCE mandatory	}|
	{ ID id-eNB-UE-S1AP-ID				CRITICALITY reject	TYPE ENB-UE-S1AP-ID	 				PRESENCE mandatory	}|
	{ ID id-E-RABReleasedList			CRITICALITY ignore	TYPE E-RABList					PRESENCE mandatory	},
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

-- **************************************************************
--
-- PAGING ELEMENTARY PROCEDURE
--
-- **************************************************************


-- **************************************************************
--
-- Paging
--
-- **************************************************************

Paging ::= SEQUENCE {
	protocolIEs			ProtocolIE-Container       {{PagingIEs}},
	...
}

PagingIEs S1AP-PROTOCOL-IES ::= {
	{ ID id-UEIdentityIndexValue		CRITICALITY ignore	TYPE UEIdentityIndexValue	PRESENCE mandatory	} |
	{ ID id-UEPagingID						CRITICALITY ignore	TYPE UEPagingID				PRESENCE mandatory	} |
	{ ID id-pagingDRX					CRITICALITY ignore	TYPE PagingDRX			PRESENCE optional	} |
	{ ID id-CNDomain					CRITICALITY ignore		TYPE CNDomain		PRESENCE mandatory	} |
	{ ID id-TAIList					CRITICALITY ignore	TYPE TAIList		 	PRESENCE mandatory	}|
	{ ID id-CSG-IdList				CRITICALITY ignore	TYPE CSG-IdList		PRESENCE optional },
	...
}

TAIList::= SEQUENCE (SIZE(1.. maxnoofTAIs)) OF ProtocolIE-SingleContainer {{TAIItemIEs}}

TAIItemIEs 	S1AP-PROTOCOL-IES ::= {
	{ ID id-TAIItem	 CRITICALITY ignore		TYPE TAIItem	PRESENCE mandatory },
	...
}

TAIItem ::= SEQUENCE {
	tAI 							TAI,
	iE-Extensions					ProtocolExtensionContainer { {TAIItemExtIEs} } OPTIONAL,
	...
}


TAIItemExtIEs S1AP-PROTOCOL-EXTENSION ::= {
	...
}

-- **************************************************************
--
-- UE CONTEXT RELEASE ELEMENTARY PROCEDURE
--
-- **************************************************************

-- **************************************************************
--
-- UE CONTEXT RELEASE REQUEST
--
-- **************************************************************

UEContextReleaseRequest ::= SEQUENCE {
	protocolIEs                     ProtocolIE-Container       {{UEContextReleaseRequest-IEs}},
	...
}

UEContextReleaseRequest-IEs S1AP-PROTOCOL-IES ::= {
	{ ID id-MME-UE-S1AP-ID			CRITICALITY reject	TYPE MME-UE-S1AP-ID				PRESENCE mandatory} |
	{ ID id-eNB-UE-S1AP-ID			CRITICALITY reject	TYPE ENB-UE-S1AP-ID				PRESENCE mandatory} |
	{ ID id-Cause					CRITICALITY ignore	TYPE Cause				PRESENCE mandatory} ,
	...
}

-- **************************************************************
--
-- UE Context Release Command
--
-- **************************************************************

UEContextReleaseCommand ::= SEQUENCE {
	protocolIEs                     ProtocolIE-Container       {{UEContextReleaseCommand-IEs}},
	...
}

UEContextReleaseCommand-IEs S1AP-PROTOCOL-IES ::= {
	{ ID id-UE-S1AP-IDs				CRITICALITY reject	TYPE UE-S1AP-IDs					PRESENCE mandatory} |
	
	{ ID id-Cause					CRITICALITY ignore	TYPE Cause						PRESENCE mandatory} ,
	...
}

-- **************************************************************
--
-- UE Context Release Complete
--
-- **************************************************************

UEContextReleaseComplete ::= SEQUENCE {
	protocolIEs                     ProtocolIE-Container       {{UEContextReleaseComplete-IEs}},
	...
}

UEContextReleaseComplete-IEs S1AP-PROTOCOL-IES ::= {
	{ ID id-MME-UE-S1AP-ID			CRITICALITY ignore	TYPE MME-UE-S1AP-ID				PRESENCE mandatory} |
	{ ID id-eNB-UE-S1AP-ID			CRITICALITY ignore	TYPE ENB-UE-S1AP-ID				PRESENCE mandatory} |
	{ ID id-CriticalityDiagnostics		CRITICALITY ignore	TYPE CriticalityDiagnostics			PRESENCE optional	},
	...
}


-- **************************************************************
--
-- UE CONTEXT MODIFICATION ELEMENTARY PROCEDURE
--
-- **************************************************************

-- **************************************************************
--
-- UE Context Modification Request
--
-- **************************************************************

UEContextModificationRequest ::= SEQUENCE {
	protocolIEs			ProtocolIE-Container       { { UEContextModificationRequestIEs} },
	...
}

UEContextModificationRequestIEs S1AP-PROTOCOL-IES ::= {	
	{ ID id-MME-UE-S1AP-ID					CRITICALITY reject	TYPE MME-UE-S1AP-ID		 			PRESENCE mandatory	} |
	{ ID id-eNB-UE-S1AP-ID				CRITICALITY reject	TYPE ENB-UE-S1AP-ID				PRESENCE mandatory	} |	
	{ ID id-SecurityKey					CRITICALITY reject	TYPE SecurityKey		 			PRESENCE optional	}|
	{ ID id-SubscriberProfileIDforRFP		CRITICALITY ignore	TYPE SubscriberProfileIDforRFP	PRESENCE optional	}|
	{ ID id-uEaggregateMaximumBitrate		CRITICALITY ignore	TYPE UEAggregateMaximumBitrate		PRESENCE optional	}|
	{ ID id-CSFallbackIndicator				CRITICALITY reject		TYPE CSFallbackIndicator		PRESENCE optional	},
	...
}
-- **************************************************************
--
-- UE Context Modification Response
--
-- **************************************************************

UEContextModificationResponse ::= SEQUENCE {
	protocolIEs			ProtocolIE-Container       { { UEContextModificationResponseIEs} },
	...
}

UEContextModificationResponseIEs S1AP-PROTOCOL-IES ::= {	
	{ ID id-MME-UE-S1AP-ID					CRITICALITY ignore	TYPE MME-UE-S1AP-ID		 			PRESENCE mandatory	} |
	{ ID id-eNB-UE-S1AP-ID				CRITICALITY ignore	TYPE ENB-UE-S1AP-ID				PRESENCE mandatory	}|
	{ ID id-CriticalityDiagnostics		CRITICALITY ignore	TYPE CriticalityDiagnostics			PRESENCE optional	},
	...
}-- **************************************************************
--
-- UE Context Modification Failure
--
-- **************************************************************

UEContextModificationFailure ::= SEQUENCE {
	protocolIEs			ProtocolIE-Container       { { UEContextModificationFailureIEs} },
	...
}

UEContextModificationFailureIEs S1AP-PROTOCOL-IES ::= {	
	{ ID id-MME-UE-S1AP-ID					CRITICALITY ignore	TYPE MME-UE-S1AP-ID		 			PRESENCE mandatory	} |
	{ ID id-eNB-UE-S1AP-ID				CRITICALITY ignore	TYPE ENB-UE-S1AP-ID				PRESENCE mandatory	} |
	{ ID id-Cause				CRITICALITY ignore	TYPE Cause				PRESENCE mandatory	}|
	{ ID id-CriticalityDiagnostics		CRITICALITY ignore	TYPE CriticalityDiagnostics			PRESENCE optional	},
	...
}

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
-- NAS NON DELIVERY INDICATION
--
-- **************************************************************

NASNonDeliveryIndication ::= SEQUENCE {
	protocolIEs                     ProtocolIE-Container       {{NASNonDeliveryIndication-IEs}},
	...
}

NASNonDeliveryIndication-IEs S1AP-PROTOCOL-IES ::= {
	{ ID id-MME-UE-S1AP-ID			CRITICALITY reject	TYPE MME-UE-S1AP-ID				PRESENCE mandatory} |
	{ ID id-eNB-UE-S1AP-ID			CRITICALITY reject	TYPE ENB-UE-S1AP-ID				PRESENCE mandatory} |
	{ ID id-NAS-PDU					CRITICALITY ignore	TYPE NAS-PDU				PRESENCE mandatory} |
	{ ID id-Cause					CRITICALITY ignore	TYPE Cause				PRESENCE mandatory} ,
	...
}

-- **************************************************************
--
-- RESET ELEMENTARY PROCEDURE
--
-- **************************************************************

-- **************************************************************
--
-- Reset
--
-- **************************************************************

Reset ::= SEQUENCE {
	protocolIEs			ProtocolIE-Container       { {ResetIEs} },
	...
}

ResetIEs S1AP-PROTOCOL-IES ::= {
	{ ID id-Cause						CRITICALITY ignore	TYPE Cause						PRESENCE mandatory	}|
	{ ID id-ResetType				CRITICALITY reject	TYPE ResetType			PRESENCE mandatory	},
	...
}

ResetType ::= CHOICE {
	s1-Interface		ResetAll,
	partOfS1-Interface		UE-associatedLogicalS1-ConnectionListRes,
	...
}



ResetAll ::= ENUMERATED {
	reset-all,
	...
}

UE-associatedLogicalS1-ConnectionListRes ::= SEQUENCE (SIZE(1.. maxNrOfIndividualS1ConnectionsToReset)) OF ProtocolIE-SingleContainer { { UE-associatedLogicalS1-ConnectionItemRes } }

UE-associatedLogicalS1-ConnectionItemRes 	S1AP-PROTOCOL-IES ::= {
	{ ID id-UE-associatedLogicalS1-ConnectionItem	 CRITICALITY reject 	TYPE UE-associatedLogicalS1-ConnectionItem 	PRESENCE mandatory },
	...
}


-- **************************************************************
--
-- Reset Acknowledge
--
-- **************************************************************

ResetAcknowledge ::= SEQUENCE {
	protocolIEs			ProtocolIE-Container       { {ResetAcknowledgeIEs} },
	...
}

ResetAcknowledgeIEs S1AP-PROTOCOL-IES ::= {
	{ ID id-UE-associatedLogicalS1-ConnectionListResAck		CRITICALITY ignore	TYPE UE-associatedLogicalS1-ConnectionListResAck			PRESENCE optional	}|
	{ ID id-CriticalityDiagnostics		CRITICALITY ignore	TYPE CriticalityDiagnostics			PRESENCE optional	},
	...
}

UE-associatedLogicalS1-ConnectionListResAck ::= SEQUENCE (SIZE(1.. maxNrOfIndividualS1ConnectionsToReset)) OF ProtocolIE-SingleContainer { { UE-associatedLogicalS1-ConnectionItemResAck } }

UE-associatedLogicalS1-ConnectionItemResAck 	S1AP-PROTOCOL-IES ::= {
	{ ID id-UE-associatedLogicalS1-ConnectionItem	 CRITICALITY ignore 	TYPE UE-associatedLogicalS1-ConnectionItem  	PRESENCE mandatory },
	...
}

-- **************************************************************
--
-- ERROR INDICATION ELEMENTARY PROCEDURE
--
-- **************************************************************

-- **************************************************************
--
-- Error Indication
--
-- **************************************************************

ErrorIndication ::= SEQUENCE {
	protocolIEs			ProtocolIE-Container       {{ErrorIndicationIEs}},
	...
}

ErrorIndicationIEs S1AP-PROTOCOL-IES ::= {
	{ ID id-MME-UE-S1AP-ID				CRITICALITY ignore	TYPE MME-UE-S1AP-ID				PRESENCE optional	} |
	{ ID id-eNB-UE-S1AP-ID				CRITICALITY ignore	TYPE ENB-UE-S1AP-ID				PRESENCE optional	} |
	{ ID id-Cause						CRITICALITY ignore	TYPE Cause						PRESENCE optional	} |
	{ ID id-CriticalityDiagnostics		CRITICALITY ignore	TYPE CriticalityDiagnostics		PRESENCE optional	} ,
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
-- ENB CONFIGURATION UPDATE ELEMENTARY PROCEDURE
--
-- **************************************************************

-- **************************************************************
--
-- eNB Configuration Update 
--
-- **************************************************************

ENBConfigurationUpdate ::= SEQUENCE {
	protocolIEs			ProtocolIE-Container       { {ENBConfigurationUpdateIEs} },
	...
}

ENBConfigurationUpdateIEs S1AP-PROTOCOL-IES ::= {
	{ ID id-eNBname				CRITICALITY ignore	TYPE ENBname			PRESENCE optional	}|
	{ ID id-SupportedTAs		CRITICALITY reject	TYPE SupportedTAs	 	PRESENCE optional	}|
	{ ID id-CSG-IdList					CRITICALITY reject	TYPE CSG-IdList				PRESENCE optional}|
	{ ID id-DefaultPagingDRX	CRITICALITY	ignore	TYPE PagingDRX		PRESENCE optional	},
	...
}

-- **************************************************************
--
-- eNB Configuration Update Acknowledge
--
-- **************************************************************

ENBConfigurationUpdateAcknowledge ::= SEQUENCE {
	protocolIEs			ProtocolIE-Container       { {ENBConfigurationUpdateAcknowledgeIEs} },
	...
}


ENBConfigurationUpdateAcknowledgeIEs S1AP-PROTOCOL-IES ::= {
	{ ID id-CriticalityDiagnostics		CRITICALITY ignore	TYPE CriticalityDiagnostics			PRESENCE optional	},
	...
}

-- **************************************************************
--
-- eNB Configuration Update Failure
--
-- **************************************************************

ENBConfigurationUpdateFailure ::= SEQUENCE {
	protocolIEs			ProtocolIE-Container       { {ENBConfigurationUpdateFailureIEs} },
	...
}

ENBConfigurationUpdateFailureIEs S1AP-PROTOCOL-IES ::= {
	{ ID id-Cause						CRITICALITY ignore	TYPE Cause						PRESENCE mandatory	}|
	{ ID id-TimeToWait					CRITICALITY ignore	TYPE TimeToWait					PRESENCE optional	}|
	{ ID id-CriticalityDiagnostics		CRITICALITY ignore	TYPE CriticalityDiagnostics			PRESENCE optional },
...
}


-- **************************************************************
--
-- MME Configuration UPDATE ELEMENTARY PROCEDURE
--
-- **************************************************************

-- **************************************************************
--
-- MME Configuration Update 
--
-- **************************************************************

MMEConfigurationUpdate ::= SEQUENCE {
	protocolIEs			ProtocolIE-Container       { {MMEConfigurationUpdateIEs} },
	...
}

MMEConfigurationUpdateIEs S1AP-PROTOCOL-IES ::= {
	{ ID id-MMEname				CRITICALITY ignore	TYPE MMEname	 		PRESENCE optional	}|
	{ ID id-ServedGUMMEIs			CRITICALITY reject	TYPE ServedGUMMEIs				PRESENCE optional	}|
	{ ID id-RelativeMMECapacity	CRITICALITY reject	TYPE RelativeMMECapacity	PRESENCE optional},
	...
}

-- **************************************************************
--
-- MME Configuration Update Acknowledge
--
-- **************************************************************

MMEConfigurationUpdateAcknowledge ::= SEQUENCE {
	protocolIEs			ProtocolIE-Container       { {MMEConfigurationUpdateAcknowledgeIEs} },
	...
}


MMEConfigurationUpdateAcknowledgeIEs S1AP-PROTOCOL-IES ::= {
	{ ID id-CriticalityDiagnostics		CRITICALITY ignore	TYPE CriticalityDiagnostics			PRESENCE optional	},
	...
}

-- **************************************************************
--
-- MME Configuration Update Failure
--
-- **************************************************************

MMEConfigurationUpdateFailure ::= SEQUENCE {
	protocolIEs			ProtocolIE-Container       { {MMEConfigurationUpdateFailureIEs} },
	...
}

MMEConfigurationUpdateFailureIEs S1AP-PROTOCOL-IES ::= {
	{ ID id-Cause						CRITICALITY ignore	TYPE Cause						PRESENCE mandatory	}|
	{ ID id-TimeToWait					CRITICALITY ignore	TYPE TimeToWait					PRESENCE optional	}|
	{ ID id-CriticalityDiagnostics		CRITICALITY ignore	TYPE CriticalityDiagnostics			PRESENCE optional	},
	...
}

-- **************************************************************
--
-- DOWNLINK S1 CDMA2000 TUNNELING ELEMENTARY PROCEDURE
--
-- **************************************************************

-- **************************************************************
--
-- Downlink S1 CDMA2000 Tunneling
--
-- **************************************************************

DownlinkS1cdma2000tunneling ::= SEQUENCE {
	protocolIEs			ProtocolIE-Container       { {DownlinkS1cdma2000tunnelingIEs} },
	...
}

DownlinkS1cdma2000tunnelingIEs S1AP-PROTOCOL-IES ::= {
	{ ID id-MME-UE-S1AP-ID				CRITICALITY reject	TYPE MME-UE-S1AP-ID				PRESENCE mandatory	} |
	{ ID id-eNB-UE-S1AP-ID				CRITICALITY reject	TYPE ENB-UE-S1AP-ID				PRESENCE mandatory	} |
	{ ID id-E-RABSubjecttoDataForwardingList					CRITICALITY ignore	TYPE E-RABSubjecttoDataForwardingList		 			PRESENCE optional	} |
	{ ID id-cdma2000HOStatus				CRITICALITY ignore	TYPE Cdma2000HOStatus 			PRESENCE optional	} |
	{ ID id-cdma2000RATType				CRITICALITY reject	TYPE Cdma2000RATType 			PRESENCE mandatory	} |
	{ ID id-cdma2000PDU					CRITICALITY reject	TYPE Cdma2000PDU	 			PRESENCE mandatory	},
	...
}

-- **************************************************************
--
-- UPLINK S1 CDMA2000 TUNNELING ELEMENTARY PROCEDURE
--
-- **************************************************************

-- **************************************************************
--
-- Uplink S1 CDMA2000 Tunneling
--
-- **************************************************************

UplinkS1cdma2000tunneling ::= SEQUENCE {
	protocolIEs			ProtocolIE-Container       { {UplinkS1cdma2000tunnelingIEs} },
	...
}

UplinkS1cdma2000tunnelingIEs S1AP-PROTOCOL-IES ::= {
	{ ID id-MME-UE-S1AP-ID				CRITICALITY reject	TYPE MME-UE-S1AP-ID				PRESENCE mandatory	} |
	{ ID id-eNB-UE-S1AP-ID				CRITICALITY reject	TYPE ENB-UE-S1AP-ID				PRESENCE mandatory	} |
	{ ID id-cdma2000RATType				CRITICALITY reject	TYPE Cdma2000RATType 			PRESENCE mandatory	} |
	{ ID id-cdma2000SectorID			CRITICALITY reject	TYPE Cdma2000SectorID 			PRESENCE mandatory	} |
	{ ID id-cdma2000HORequiredIndication			CRITICALITY ignore	TYPE Cdma2000HORequiredIndication 			PRESENCE optional	} |
	{ ID id-cdma2000OneXSRVCCInfo			CRITICALITY reject	TYPE Cdma2000OneXSRVCCInfo 			PRESENCE optional	} |
	{ ID id-cdma2000OneXRAND			CRITICALITY reject	TYPE Cdma2000OneXRAND 			PRESENCE optional	} |
	{ ID id-cdma2000PDU					CRITICALITY reject	TYPE Cdma2000PDU	 			PRESENCE mandatory	},
	...
}


-- **************************************************************
--
-- UE CAPABILITY INFO INDICATION ELEMENTARY PROCEDURE
--
-- **************************************************************

-- **************************************************************
--
-- UE Capability Info Indication
--
-- **************************************************************

UECapabilityInfoIndication ::= SEQUENCE {
	protocolIEs			ProtocolIE-Container       { { UECapabilityInfoIndicationIEs} },
	...
}

UECapabilityInfoIndicationIEs S1AP-PROTOCOL-IES ::= {
	{ ID id-MME-UE-S1AP-ID				CRITICALITY reject	TYPE MME-UE-S1AP-ID	 				PRESENCE mandatory	} |
	{ ID id-eNB-UE-S1AP-ID				CRITICALITY reject	TYPE ENB-UE-S1AP-ID	 				PRESENCE mandatory	} |
	{ ID id-UERadioCapability			CRITICALITY ignore	TYPE UERadioCapability				PRESENCE mandatory	} ,
	...
}

-- **************************************************************
--
-- eNB STATUS TRANSFER ELEMENTARY PROCEDURE
--
-- **************************************************************

-- **************************************************************
--
-- eNB Status Transfer
--
-- **************************************************************

ENBStatusTransfer ::= SEQUENCE {
	protocolIEs			ProtocolIE-Container       { {ENBStatusTransferIEs} },
	...
}

ENBStatusTransferIEs S1AP-PROTOCOL-IES ::= {
	{ ID id-MME-UE-S1AP-ID			CRITICALITY reject	TYPE MME-UE-S1AP-ID				PRESENCE mandatory} |
	{ ID id-eNB-UE-S1AP-ID			CRITICALITY reject	TYPE ENB-UE-S1AP-ID				PRESENCE mandatory} |
	{ ID id-eNB-StatusTransfer-TransparentContainer	CRITICALITY reject	TYPE ENB-StatusTransfer-TransparentContainer		PRESENCE mandatory} ,
	...
}


-- **************************************************************
--
-- MME STATUS TRANSFER ELEMENTARY PROCEDURE
--
-- **************************************************************

-- **************************************************************
--
-- MME Status Transfer
--
-- **************************************************************

MMEStatusTransfer ::= SEQUENCE {
	protocolIEs			ProtocolIE-Container       { {MMEStatusTransferIEs} },
	...
}

MMEStatusTransferIEs S1AP-PROTOCOL-IES ::= {
	{ ID id-MME-UE-S1AP-ID			CRITICALITY reject	TYPE MME-UE-S1AP-ID				PRESENCE mandatory} |
	{ ID id-eNB-UE-S1AP-ID			CRITICALITY reject	TYPE ENB-UE-S1AP-ID				PRESENCE mandatory} |
	{ ID id-eNB-StatusTransfer-TransparentContainer	CRITICALITY reject	TYPE ENB-StatusTransfer-TransparentContainer		PRESENCE mandatory} ,
	...
}


-- **************************************************************
--
-- TRACE ELEMENTARY PROCEDURES
--
-- **************************************************************
-- **************************************************************
--
-- Trace Start
--
-- **************************************************************

TraceStart ::= SEQUENCE {
	protocolIEs			ProtocolIE-Container       { {TraceStartIEs} },
	...
}

TraceStartIEs S1AP-PROTOCOL-IES ::= {
	{ ID id-MME-UE-S1AP-ID				CRITICALITY reject	TYPE MME-UE-S1AP-ID				PRESENCE mandatory} |
	{ ID id-eNB-UE-S1AP-ID				CRITICALITY reject	TYPE ENB-UE-S1AP-ID				PRESENCE mandatory} |
	{ ID id-TraceActivation				CRITICALITY ignore	TYPE TraceActivation			PRESENCE mandatory	},
	...
}

-- **************************************************************
--
-- Trace Failure Indication
--
-- **************************************************************

TraceFailureIndication ::= SEQUENCE {
	protocolIEs			ProtocolIE-Container       { {TraceFailureIndicationIEs} },
	...
}

TraceFailureIndicationIEs S1AP-PROTOCOL-IES ::= {
	{ ID id-MME-UE-S1AP-ID				CRITICALITY reject	TYPE MME-UE-S1AP-ID				PRESENCE mandatory} |
	{ ID id-eNB-UE-S1AP-ID				CRITICALITY reject	TYPE ENB-UE-S1AP-ID				PRESENCE mandatory} |
	{ ID id-E-UTRAN-Trace-ID				CRITICALITY ignore	TYPE E-UTRAN-Trace-ID				PRESENCE mandatory} |
	{ ID id-Cause						CRITICALITY ignore	TYPE Cause						PRESENCE mandatory} ,
	...
}

-- **************************************************************
--
-- DEACTIVATE TRACE ELEMENTARY PROCEDURE
--
-- **************************************************************

-- **************************************************************
--
-- DEACTIVATE TRACE
--
-- **************************************************************

DeactivateTrace ::= SEQUENCE {
	protocolIEs			ProtocolIE-Container       { { DeactivateTraceIEs} },
	...
}

DeactivateTraceIEs S1AP-PROTOCOL-IES ::= {
	{ ID id-MME-UE-S1AP-ID		CRITICALITY reject	TYPE MME-UE-S1AP-ID		PRESENCE mandatory} |
	{ ID id-eNB-UE-S1AP-ID		CRITICALITY reject	TYPE ENB-UE-S1AP-ID		PRESENCE mandatory} |
	{ ID id-E-UTRAN-Trace-ID		CRITICALITY ignore	TYPE E-UTRAN-Trace-ID	 	PRESENCE mandatory	},
	...
}

-- **************************************************************
--
-- CELL TRAFFIC TRACE ELEMENTARY PROCEDURE
--
-- **************************************************************

-- **************************************************************
--
-- CELL TRAFFIC TRACE
--
-- **************************************************************

CellTrafficTrace ::= SEQUENCE {
     protocolIEs		ProtocolIE-Container	{ { CellTrafficTraceIEs } },
     ...
}

CellTrafficTraceIEs S1AP-PROTOCOL-IES ::= {
	{ID id-MME-UE-S1AP-ID	CRITICALITY reject	TYPE MME-UE-S1AP-ID	PRESENCE mandatory} |
	{ID id-eNB-UE-S1AP-ID	CRITICALITY reject	TYPE ENB-UE-S1AP-ID	PRESENCE mandatory} |
	{ID id-E-UTRAN-Trace-ID	CRITICALITY ignore	TYPE E-UTRAN-Trace-ID	PRESENCE mandatory}|
	{ID id-EUTRAN-CGI	CRITICALITY ignore	TYPE EUTRAN-CGI	PRESENCE mandatory}|
	{ID id-TraceCollectionEntityIPAddress	CRITICALITY ignore	TYPE TransportLayerAddress	PRESENCE mandatory },
	...
}

-- **************************************************************
--
-- LOCATION ELEMENTARY PROCEDURES
--
-- **************************************************************

-- **************************************************************
--
-- Location Reporting Control
--
-- **************************************************************

LocationReportingControl ::= SEQUENCE {
	protocolIEs			ProtocolIE-Container       { { LocationReportingControlIEs} },
	...
}

LocationReportingControlIEs S1AP-PROTOCOL-IES ::= {
	{ ID id-MME-UE-S1AP-ID			CRITICALITY reject	TYPE MME-UE-S1AP-ID				PRESENCE mandatory} |
	{ ID id-eNB-UE-S1AP-ID			CRITICALITY reject	TYPE ENB-UE-S1AP-ID				PRESENCE mandatory} |
	{ ID id-RequestType				CRITICALITY ignore	TYPE RequestType				PRESENCE mandatory	} ,
	...
}

-- **************************************************************
--
-- Location Report Failure Indication
--
-- **************************************************************

LocationReportingFailureIndication ::= SEQUENCE {
	protocolIEs			ProtocolIE-Container       { { LocationReportingFailureIndicationIEs} },
	...
}

LocationReportingFailureIndicationIEs S1AP-PROTOCOL-IES ::= {
	{ ID id-MME-UE-S1AP-ID			CRITICALITY reject	TYPE MME-UE-S1AP-ID				PRESENCE mandatory} |
	{ ID id-eNB-UE-S1AP-ID			CRITICALITY reject	TYPE ENB-UE-S1AP-ID				PRESENCE mandatory} |
	{ ID id-Cause					CRITICALITY ignore	TYPE Cause						PRESENCE mandatory},
	...
}

-- **************************************************************
--
-- Location Report 
--
-- **************************************************************

LocationReport ::= SEQUENCE {
	protocolIEs			ProtocolIE-Container       { { LocationReportIEs} },
	...
}

LocationReportIEs S1AP-PROTOCOL-IES ::= {
	{ ID id-MME-UE-S1AP-ID			CRITICALITY reject	TYPE MME-UE-S1AP-ID				PRESENCE mandatory} |
	{ ID id-eNB-UE-S1AP-ID			CRITICALITY reject	TYPE ENB-UE-S1AP-ID				PRESENCE mandatory} |
	{ ID id-EUTRAN-CGI				CRITICALITY ignore	TYPE EUTRAN-CGI				PRESENCE mandatory} |
	{ ID id-TAI						CRITICALITY ignore	TYPE TAI						PRESENCE mandatory} |
	{ ID id-RequestType				CRITICALITY ignore	TYPE RequestType				PRESENCE mandatory} ,
	...
}

-- **************************************************************
--
-- OVERLOAD ELEMENTARY PROCEDURES
--
-- **************************************************************

-- **************************************************************
--
-- Overload Start
--
-- **************************************************************

OverloadStart ::= SEQUENCE {
	protocolIEs			ProtocolIE-Container       { {OverloadStartIEs} },
	...
}

OverloadStartIEs S1AP-PROTOCOL-IES ::= {	
	{ ID id-OverloadResponse					CRITICALITY reject	TYPE OverloadResponse		 			PRESENCE mandatory	},
	...
}
-- **************************************************************
--
-- Overload Stop
--
-- **************************************************************

OverloadStop ::= SEQUENCE {
	protocolIEs			ProtocolIE-Container       { {OverloadStopIEs} },
	...
}

OverloadStopIEs S1AP-PROTOCOL-IES ::= {	
	...
}
-- **************************************************************
--
-- WRITE-REPLACE WARNING ELEMENTARY PROCEDURE 
--
-- **************************************************************

-- **************************************************************
--
-- Write-Replace Warning Request
--
-- **************************************************************


WriteReplaceWarningRequest ::= SEQUENCE {
	protocolIEs			ProtocolIE-Container       { {WriteReplaceWarningRequestIEs} },
	...
}

WriteReplaceWarningRequestIEs S1AP-PROTOCOL-IES ::= {	
	{ ID id-MessageIdentifier			CRITICALITY reject	TYPE MessageIdentifier		PRESENCE mandatory		}|
	{ ID id-SerialNumber				CRITICALITY reject	TYPE SerialNumber		PRESENCE mandatory		}|
	{ ID id-WarningAreaList				CRITICALITY ignore	TYPE WarningAreaList		PRESENCE optional		}|
	{ ID id-RepetitionPeriod			CRITICALITY reject	TYPE RepetitionPeriod		PRESENCE mandatory		}|
	{ ID id-NumberofBroadcastRequest	CRITICALITY reject	TYPE NumberofBroadcastRequest	PRESENCE mandatory	}|
	{ ID id-WarningType					CRITICALITY ignore	TYPE WarningType			PRESENCE optional		}|
	{ ID id-WarningSecurityInfo			CRITICALITY ignore	TYPE WarningSecurityInfo	PRESENCE optional		}|
	{ ID id-DataCodingScheme			CRITICALITY ignore	TYPE DataCodingScheme		PRESENCE optional		}|
	{ ID id-WarningMessageContents		CRITICALITY ignore	TYPE WarningMessageContents		PRESENCE optional		},
	...
}
-- **************************************************************
--
-- Write-Replace Warning Response
--
-- **************************************************************

WriteReplaceWarningResponse ::= SEQUENCE {
	protocolIEs			ProtocolIE-Container		{ {WriteReplaceWarningResponseIEs} },
	...
}

WriteReplaceWarningResponseIEs S1AP-PROTOCOL-IES ::= {
	{ ID id-MessageIdentifier			CRITICALITY reject	TYPE MessageIdentifier		PRESENCE mandatory		}|
	{ ID id-SerialNumber				CRITICALITY reject	TYPE SerialNumber		PRESENCE mandatory		}|
	{ ID id-BroadcastCompletedAreaList		CRITICALITY ignore	TYPE BroadcastCompletedAreaList		PRESENCE optional	}|
	{ ID id-CriticalityDiagnostics		CRITICALITY ignore	TYPE CriticalityDiagnostics				PRESENCE optional},
	...
}

-- **************************************************************
--
-- eNB DIRECT INFORMATION TRANSFER ELEMENTARY PROCEDURE
--
-- **************************************************************

-- **************************************************************
--
-- eNB Direct Information Transfer
--
-- **************************************************************

ENBDirectInformationTransfer ::= SEQUENCE {
	protocolIEs			ProtocolIE-Container       {{ ENBDirectInformationTransferIEs}},
	...
}

ENBDirectInformationTransferIEs S1AP-PROTOCOL-IES ::= {
	{ ID id-Inter-SystemInformationTransferTypeEDT		CRITICALITY reject	TYPE Inter-SystemInformationTransferType			PRESENCE mandatory}  ,
	...
}

Inter-SystemInformationTransferType ::= CHOICE {
	rIMTransfer		RIMTransfer,
	...
}

-- **************************************************************
--
-- MME DIRECT INFORMATION TRANSFER ELEMENTARY PROCEDURE
--
-- **************************************************************

-- **************************************************************
--
-- MME Direct Information Transfer
--
-- **************************************************************

MMEDirectInformationTransfer ::= SEQUENCE {
	protocolIEs			ProtocolIE-Container       {{ MMEDirectInformationTransferIEs}},
	...
}

MMEDirectInformationTransferIEs S1AP-PROTOCOL-IES ::= {
	{ ID id-Inter-SystemInformationTransferTypeMDT		CRITICALITY reject	TYPE Inter-SystemInformationTransferType			PRESENCE mandatory}  ,
	...
}
-- **************************************************************
--
-- eNB CONFIGURATION TRANSFER ELEMENTARY PROCEDURE
--
-- **************************************************************

-- **************************************************************
--
-- eNB Configuration Transfer
--
-- **************************************************************

ENBConfigurationTransfer ::= SEQUENCE {
	protocolIEs			ProtocolIE-Container       {{ ENBConfigurationTransferIEs}},
	...
}

ENBConfigurationTransferIEs S1AP-PROTOCOL-IES ::= {
	{ ID id-SONConfigurationTransferECT		CRITICALITY ignore	TYPE SONConfigurationTransfer				PRESENCE optional}  ,
	...
}

-- **************************************************************
--
-- MME CONFIGURATION TRANSFER ELEMENTARY PROCEDURE
--
-- **************************************************************

-- **************************************************************
--
-- MME Configuration Transfer
--
-- **************************************************************

MMEConfigurationTransfer ::= SEQUENCE {
	protocolIEs			ProtocolIE-Container       {{ MMEConfigurationTransferIEs}},
	...
}

MMEConfigurationTransferIEs S1AP-PROTOCOL-IES ::= {
	{ ID id-SONConfigurationTransferMCT		CRITICALITY ignore	TYPE SONConfigurationTransfer				PRESENCE optional}  ,
	...
}

-- **************************************************************
--
-- PRIVATE MESSAGE ELEMENTARY PROCEDURE
--
-- **************************************************************

-- **************************************************************
--
-- Private Message
--
-- **************************************************************

PrivateMessage ::= SEQUENCE {
	privateIEs			PrivateIE-Container       {{PrivateMessageIEs}},
	...
}

PrivateMessageIEs S1AP-PRIVATE-IES ::= {
	...
}

END

*/


