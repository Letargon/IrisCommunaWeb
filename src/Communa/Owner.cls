Class Communa.Owner Extends %Persistent
{

Index ownerID On (name, sector, room, address) [ PrimaryKey ];

Property name As %String;

Property sector As %Integer;

Property room As %Integer;

Property address As %String;

Storage Default
{
<Data name="OwnerDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>name</Value>
</Value>
<Value name="3">
<Value>sector</Value>
</Value>
<Value name="4">
<Value>room</Value>
</Value>
<Value name="5">
<Value>address</Value>
</Value>
</Data>
<DataLocation>^Communa.OwnerD</DataLocation>
<DefaultData>OwnerDefaultData</DefaultData>
<IdLocation>^Communa.OwnerD</IdLocation>
<IndexLocation>^Communa.OwnerI</IndexLocation>
<StreamLocation>^Communa.OwnerS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

ClassMethod saveOwner(owner As Communa.Owner) As %Status
{
    set obj = ##class(Communa.Owner).%New()
    set obj.name = owner.name
    set obj.sector = owner.sector
    set obj.room = owner.room
    set obj.address = owner.address
    set result = obj.%Save()
    Return ##class(Communa.Utils).getStatus(result)
}

ClassMethod getAllOwners() As %Library.DynamicArray
{
	set data = ##class(%Library.DynamicArray).%New()
	&sql(
	 	DECLARE MyCursor CURSOR FOR
	    SELECT id, name, sector, room, address
	    INTO :id, :name, :sector, :room, :address
	    FROM Communa.Owner
 	)
 	&sql(OPEN MyCursor)
 	
  FOR { 
    &sql(FETCH MyCursor)
    if (SQLCODE) quit

    set obj = {"ownerID": (id), "name": (name), "sector": (sector), "room": (room), "address": (address)}
    do data.%Push(obj)
 	}
 	&sql(CLOSE MyCursor)

 	return data
}

}
