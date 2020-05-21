Class Communa.Service Extends %Persistent
{

Index serviceID On (name, cost) [ PrimaryKey ];

Property name As %String;

Property cost As %Integer;

Storage Default
{
<Data name="ServiceDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>name</Value>
</Value>
<Value name="3">
<Value>cost</Value>
</Value>
</Data>
<DataLocation>^Communa.ServiceD</DataLocation>
<DefaultData>ServiceDefaultData</DefaultData>
<IdLocation>^Communa.ServiceD</IdLocation>
<IndexLocation>^Communa.ServiceI</IndexLocation>
<StreamLocation>^Communa.ServiceS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

ClassMethod saveService(service As Communa.Service) As %Status
{
    set obj = ##class(Communa.Service).%New()
    set obj.name = service.name
    set obj.cost = service.cost
    set result = obj.%Save()
    Return ##class(Communa.Utils).getStatus(result)
}

ClassMethod getAllServices() As %Library.DynamicArray
{
	set data = ##class(%Library.DynamicArray).%New()
	&sql(
	 	DECLARE MyCursor CURSOR FOR
	    SELECT id, name, cost
	    INTO :id, :name, :cost
	    FROM Communa.Service
 	)
 	&sql(OPEN MyCursor)
 	
  FOR { 
    &sql(FETCH MyCursor)
    if (SQLCODE) quit

    set obj = {"serviceID": (id), "name": (name),  "cost": (cost), "id":(id), "value": (name_"/"_id)}
    do data.%Push(obj)
 	}
 	&sql(CLOSE MyCursor)
 	
 	return data
}

}
