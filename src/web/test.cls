Class web.users Extends %CSP.Page
{

ClassMethod onPage() As %Status
{
    do ..header()
    do ..body()
    do ..footer()
    Quit $$$OK
}

ClassMethod header() As %Status
{
  &HTML<
  <html>
    <head>
      <script type="text/javascript" src="webix/webix.min.js" ></script>
      <link rel="stylesheet" type="text/css" href="webix/webix.min.css">
      <link rel="stylesheet" href="https://cdn.materialdesignicons.com/2.7.94/css/materialdesignicons.css?v=7.2.0" type="text/css" charset="utf-8">
    </head>
  >

  Quit $$$OK
}

/// mostly JS on webix framework
ClassMethod body() As %Status
{
     &JS<<script type="text/javascript">
    var ui_template = {
    id:"tab2_content",
    view:"form",
    width: "400",
    elements:[
        {view: "text", name: "fname", label: "Name"},
        {view: "text", name: "fage", label: "Age"},
        { view:"button",  value:"Submit", id:"btn", click:function(){
        var values = this.getFormView().getValues();
        webix.ajax().post("/api/users/save", values, submitUser);
        }}
    ]

    };
    webix.ready(function(){
        webix.ui(ui.template);
        })
</script>>
}


ClassMethod footer() As %Status
{
  &HTML<
    </body></html>
  >
  Quit $$$OK
}
