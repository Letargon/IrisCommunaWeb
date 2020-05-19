Class web.ownersList Extends %CSP.Page
{

ClassMethod OnPage() As %Status
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

ClassMethod body() As %Status
{
    &JS<
        <script type="text/javascript">

        var submitOwner = (rawData) => {
            let data = JSON.parse(rawData);
            let message;
            if (data.result) {
                message = { type:"success", text: "Owner is saved", expire:-1};
                $$('tab2_content').clear();
            }
            else
                message = { type:"error", text: data.message, expire:-1};
            webix.message(message);
        }

        var owner_list_template = {
            id:"tab1_content",
            view:"datatable",
            columns:[

                { id:"ownerID", header:"OwnerID", adjust:"true" },

                { id:"name", header:"Name", adjust:"true" },

                { id:"sector", header:"Sector", adjust:"true" },

                { id:"room", header:"Room", adjust:"true" },

                { id:"address", header:"Address", adjust:"true" },

                { 
                    id:"", 
                    template:"<input class='delbtn' type='button' value='Delete'>",	
                    css:"padding_less",
                    width:100 
                }
  
            ],
            url:"/communa/listOwners"
        };


        var owner_form_template = {
            id:"tab2_content",
            view:"form",
            width: "400",
            elements:[
                {view: "text", name: "name", label: "Name"},
                {view: "text", name: "sector", label: "Sector"},
                {view: "text", name: "room", label: "Room"},
                {view: "text", name: "address", label: "Address"},
                { view:"button",  value:"Save", id:"btn", 
                    click:function(){
                            var values = this.getFormView().getValues();
                            webix.ajax().post("/communa/saveOwner", values, submitOwner);
                            var url = $$(`tab1_content`).data.url
                            $$(`tab1_content`).clearAll();
                            $$(`tab1_content`).load(url);
                        }
                }
            ]
        };
        var menu_data = [
	        {id: "tab1", icon: "mdi mdi-table", value:"Owners list"},
	        {id: "tab2", icon: "mdi mdi-pencil", value:"Owner form"},
        ];
        var ui_template = {
            height: '100%',
            rows: [
                    { 
                        view: "toolbar", 
                        padding:3, 
                        elements: [
                            { 
                                view: "button",
                                type: "icon", 
                                icon: "mdi mdi-menu",
                                width: 37, align: "left", css: "app_button", click: function(){
                                    $$("$sidebar1").toggle();
                                }
                            },
                            { 
                                view: "label", 
                                label: "OwnerList Controller"
                            },
                        ]
                    },
                    { 
                        cols:[
                                {
                                    view: "sidebar",
                                    data: menu_data,
                                    on:{
                                        onAfterSelect: function(id){
                                            $$(`${id}_content`).show();
                                        }
                                    }
                                },
                                { 
                                    id:"t1_content",
                                    cells:[
                                            owner_form_template,
                                            owner_list_template
                                    ]   
                                }
                        ]
                    }
            ]
        };


        webix.ready(function(){
            webix.ui(ui_template);
            $$("tab1_content").on_click.delbtn=function(e, id, trg){
               
                var val = $$("tab1_content").getItem(id).ownerID;
                webix.message("Delete owner: "+ val);
                webix.ajax().post("/communa/deleteOwner", {"id":val});
                var url = $$(`tab1_content`).data.url
                $$(`tab1_content`).clearAll();
                $$(`tab1_content`).load(url);
                //block default onclick event
                return false;
            };
        });
        </script>
    >
    Quit $$$OK
}

ClassMethod footer() As %Status
{
  &HTML<
    </body></html>
  >
  Quit $$$OK
}

}
