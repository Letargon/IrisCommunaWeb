Class PackageSample.ObjectScript Extends %RegisteredObject
{

ClassMethod Test() As %Status
{
    set a=42
    return "It works!"
}

Method TestObject() As %String
{
    set str = "this is object method"
    return str
}

}
