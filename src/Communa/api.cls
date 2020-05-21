Class Communa.Api Extends %CSP.REST
{

XData UrlMap [ XMLNamespace = "http://www.intersystems.com/urlmap" ]
{
<Routes>
    <Route Url="/saveOwner" Method="POST" Call="saveOwner"/>
    <Route Url="/deleteOwner" Method="POST" Call="deleteOwner"/>
    <Route Url="/listOwners" Method="GET" Call="listOwners"/>

    <Route Url="/saveDebt" Method="POST" Call="saveDebt"/>
    <Route Url="/deleteDebt" Method="POST" Call="deleteDebt"/>
    <Route Url="/listDebts" Method="GET" Call="listDebts"/>

    <Route Url="/saveService" Method="POST" Call="saveService"/>
    <Route Url="/deleteService" Method="POST" Call="deleteService"/>
    <Route Url="/listServices" Method="GET" Call="listServices"/>

    <Route Url="/saveSurvey" Method="POST" Call="saveSurvey"/>
    <Route Url="/deleteSurvey" Method="POST" Call="deleteSurvey"/>
    <Route Url="/listSurveys" Method="GET" Call="listSurveys"/>

    <Route Url="/saveVoting" Method="POST" Call="saveVoting"/>
    <Route Url="/deleteVoting" Method="POST" Call="deleteVoting"/>
    <Route Url="/listVotings" Method="GET" Call="listVotings"/>

</Routes>
}

ClassMethod saveOwner() As %Status
{
    set obj = {}
    set obj.name = %request.Get("name")
    set obj.sector = %request.Get("sector")
    set obj.room = %request.Get("room")
    set obj.address = %request.Get("address")
    set result = ##class(Communa.Owner).saveOwner(obj)
    write result.%ToJSON()
    Return result
}

ClassMethod deleteOwner() As %Status
{
    set id = %request.Get("id")
    set result = ##class(Communa.Owner).%DeleteId(id)
    Return result
}

ClassMethod listOwners() As %Status
{
  set list = ##class(Communa.Owner).getAllOwners()
  write list.%ToJSON()
  Return $$$OK
}

ClassMethod truncateOwners() As %Status
{
    set sql = "truncate table Communa.Owner"
	set sqlObj = ##class(%SQL.Statement).%New()
	set qStatus = sqlObj.%Prepare(sql)

	set rset = sqlObj.%Execute()
    return $$$OK
}

ClassMethod saveDebt() As %Status
{
    set obj = {}

    set obj.owner =  %request.Get("owner")
    set obj.date = $ZDATEH(%request.Get("date"), 3)
    set obj.service = %request.Get("service")
    set obj.sum = %request.Get("sum")
    set result = ##class(Communa.Debt).saveDebt(obj)
    write result.%ToJSON()
    Return result
}

ClassMethod saveDebtTest() As %Status
{
    set obj = {}
    set obj.owner =  $PIECE("name/1", "/", 2)
    set obj.date = $ZDATEH("2020-09-22", 3)
    set obj.service = $PIECE("service/1","/",2)
    write obj.owner," ", obj.service
    set obj.sum = 100
    set result = ##class(Communa.Debt).saveDebt(obj)
    write result.%ToJSON()
    Return result
}

ClassMethod deleteDebt() As %Status
{
    set id = %request.Get("id")
    set result = ##class(Communa.Debt).%DeleteId(id)
    Return result
}

ClassMethod listDebts() As %Status
{
  set list = ##class(Communa.Debt).getAllDebts()
  write list.%ToJSON()
  Return $$$OK
}

ClassMethod saveService() As %Status
{
    set obj = {}
    set obj.name = %request.Get("name")
    set obj.cost = %request.Get("cost")

    set result = ##class(Communa.Service).saveService(obj)
    write result.%ToJSON()
    Return result
}

ClassMethod deleteService() As %Status
{
    set id = %request.Get("id")
    set result = ##class(Communa.Service).%DeleteId(id)
    Return result
}

ClassMethod listServices() As %Status
{
  set list = ##class(Communa.Service).getAllServices()
  write list.%ToJSON()
  Return $$$OK
}

ClassMethod saveSurvey() As %Status
{
    set obj = {}
    set obj.owner = %request.Get("owner")
    set obj.voting = %request.Get("voting")
    set obj.issue = %request.Get("issue")

    set result = ##class(Communa.SurveyList).saveSurvey(obj)
    write result.%ToJSON()
    Return result
}

ClassMethod deleteSurvey() As %Status
{
    set id = %request.Get("id")
    set result = ##class(Communa.SurveyList).%DeleteId(id)
    Return result
}

ClassMethod listSurveys() As %Status
{
  set list = ##class(Communa.SurveyList).getAllSurveys()
  write list.%ToJSON()
  Return $$$OK
}

ClassMethod saveVoting() As %Status
{
    set obj = {}
    set obj.date = $ZDATEH(%request.Get("date"), 3)
    set obj.description = %request.Get("description")

    set result = ##class(Communa.Voting).saveVoting(obj)
    write result.%ToJSON()
    Return result
}

ClassMethod deleteVoting() As %Status
{
    set id = %request.Get("id")
    set result = ##class(Communa.Voting).%DeleteId(id)
    Return result
}

ClassMethod listVotings() As %Status
{
  set list = ##class(Communa.Voting).getAllVotings()
  write list.%ToJSON()
  Return $$$OK
}

}
