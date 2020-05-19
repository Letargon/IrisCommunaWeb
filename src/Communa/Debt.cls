Class Communa.Debt Extends %Persistent
{

Index debtID On (date, owner, service) [ PrimaryKey ];

Property owner As Communa.Owner;

Property date As %Date;

Property service As Communa.Service;

Property sum As %Integer;

Storage Default
{
<Data name="DebtDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>data</Value>
</Value>
<Value name="3">
<Value>owner</Value>
</Value>
<Value name="4">
<Value>summ</Value>
</Value>
<Value name="5">
<Value>sum</Value>
</Value>
<Value name="6">
<Value>service</Value>
</Value>
<Value name="7">
<Value>date</Value>
</Value>
</Data>
<DataLocation>^Communa.DebtD</DataLocation>
<DefaultData>DebtDefaultData</DefaultData>
<IdLocation>^Communa.DebtD</IdLocation>
<IndexLocation>^Communa.DebtI</IndexLocation>
<StreamLocation>^Communa.DebtS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

ClassMethod saveDebt(debt As Communa.Debt) As %Status
{
    set obj = ##class(Communa.Debt).%New()
    set obj.owner = ##class(Communa.Owner).%OpenId(debt.owner)
    set obj.date = debt.date
    set obj.service = ##class(Communa.Service).%OpenId(debt.service)
    set obj.sum = debt.sum
    set result = obj.%Save()
    Return ##class(Communa.Utils).getStatus(result)
}

ClassMethod getAllDebts() As %Library.DynamicArray
{
	set data = ##class(%Library.DynamicArray).%New()
	&sql(
	 	DECLARE MyCursor CURSOR FOR
	    SELECT "id", "owner", "date", "service", "sum"
	    INTO :id, :owner, :date, :service, :sum
	    FROM Communa.Debt
 	)
 	&sql(OPEN MyCursor)
 	
  FOR { 
    &sql(FETCH MyCursor)
    if (SQLCODE) quit
    set obj = {"debtID": (id), "owner": (owner), "date": ($ZDATE(date)), "service": (service), "sum": (sum)}
    do data.%Push(obj)
 	}
 	&sql(CLOSE MyCursor)
 	
 	return data
}

}
