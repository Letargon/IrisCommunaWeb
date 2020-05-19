Class Communa.SurveyList Extends %Persistent
{

Index survID On (owner, voting) [ PrimaryKey ];

Property owner As Communa.Owner;

Property voting As Communa.Voting;

Property issue As %String;

Storage Default
{
<Data name="SurveyListDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>owner</Value>
</Value>
<Value name="3">
<Value>vote</Value>
</Value>
<Value name="4">
<Value>issue</Value>
</Value>
<Value name="5">
<Value>voting</Value>
</Value>
</Data>
<DataLocation>^Communa.SurveyListD</DataLocation>
<DefaultData>SurveyListDefaultData</DefaultData>
<IdLocation>^Communa.SurveyListD</IdLocation>
<IndexLocation>^Communa.SurveyListI</IndexLocation>
<StreamLocation>^Communa.SurveyListS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

ClassMethod saveSurvey(survey As Communa.SurveyList) As %Status
{
    set obj = ##class(Communa.SurveyList).%New()
    set obj.owner = ##class(Communa.Owner).%OpenId(survey.owner)
    set obj.voting = ##class(Communa.Voting).%OpenId(survey.voting)
    set obj.issue = survey.issue
    set result = obj.%Save()
    Return ##class(Communa.Utils).getStatus(result)
}

ClassMethod getAllSurveys() As %Library.DynamicArray
{
	set data = ##class(%Library.DynamicArray).%New()
	&sql(
	 	DECLARE MyCursor CURSOR FOR
	    SELECT id, owner, voting, issue
	    INTO :id, :owner, :voting, :issue
	    FROM Communa.SurveyList
 	)
 	&sql(OPEN MyCursor)
 	
  FOR { 
    &sql(FETCH MyCursor)
    if (SQLCODE) quit

    set obj = {"survID": (id), "owner": (owner), "voting": (voting), "issue": (issue)}
    do data.%Push(obj)
 	}
 	&sql(CLOSE MyCursor)
 	
 	return data
}

}
