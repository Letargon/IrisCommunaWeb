Class Communa.Voting Extends %Persistent
{

Property descr As %String;

Property date As %Date;

Storage Default
{
<Data name="VotingDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>descr</Value>
</Value>
<Value name="3">
<Value>date</Value>
</Value>
</Data>
<DataLocation>^Communa.VotingD</DataLocation>
<DefaultData>VotingDefaultData</DefaultData>
<IdLocation>^Communa.VotingD</IdLocation>
<IndexLocation>^Communa.VotingI</IndexLocation>
<StreamLocation>^Communa.VotingS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

ClassMethod saveVoting(voting As Communa.Voting) As %Status
{
    set obj = ##class(Communa.SurveyList).%New()
    set obj.description = survey.description
    set obj.date = survey.date
    set result = obj.%Save()
    Return ##class(Communa.Utils).getStatus(result)
}

ClassMethod getAllVotings() As %Library.DynamicArray
{
	set data = ##class(%Library.DynamicArray).%New()
	&sql(
	 	DECLARE MyCursor CURSOR FOR
	    SELECT id, descr, date
	    INTO :id, :descr, :date
	    FROM Communa.Voting
 	)
 	&sql(OPEN MyCursor)
 	
  FOR { 
    &sql(FETCH MyCursor)
    if (SQLCODE) quit

    set obj = {"id": (id), "descr": (owner), "date": ($ZDATE(date))}
    do data.%Push(obj)
 	}
 	&sql(CLOSE MyCursor)
 	
 	return data
}

}
