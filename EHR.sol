pragma solidity ^0.5.10;

contract EHR {

    enum StateType { DiseaseDiagnosed, PendingApprovalDiagnosis, ApprovedDiagnosis, DiseaseTreated, PendingApprovalTreatment}

    //List of properties
    StateType public State;
    address public  ReportingDoctor;
    address public  TreatingDoctor;
    address public  AuthorisingDoctor;
    address public  Patient;

    string public Disease;
    string public Hospital;
    string public ReportLink;
    string public Comments;

    // constructor function
    constructor(string memory disease, string memory reportLink, string memory hospital, string memory comments, address patient) public
    {
        Disease = disease;
        Hospital = hospital;
        ReportLink = reportLink;
        Comments = comments;
        Patient = patient;
        State = StateType.DiseaseDiagnosed;
        ReportingDoctor = msg.sender;
    }

    function ReportDisease(string memory disease) public
    {
        if (ReportingDoctor != msg.sender)
        {
            revert();
        }

        Disease = disease;
        State = StateType.DiseaseDiagnosed;

    }

    function UserConfirmationDiagnosis() public
    {
        if(Patient != msg.sender){
            revert();
        }

        State = StateType.PendingApprovalDiagnosis;
    }

    function ApproveDiagnosis() public
    {
        AuthorisingDoctor = msg.sender;

        State = StateType.ApprovedDiagnosis;
    }

    function TreatDisease(string memory comments) public
    {
        TreatingDoctor = msg.sender;
        Comments = comments;
        State = StateType.DiseaseTreated;

    }

    function UserConfirmationTreatment() public
    {
        if(Patient != msg.sender){
            revert();
        }

        State = StateType.PendingApprovalTreatment;
    }

    function ApproveTreatment() public
    {
        AuthorisingDoctor = msg.sender;

        State = StateType.ApprovedDiagnosis;
    }
}
