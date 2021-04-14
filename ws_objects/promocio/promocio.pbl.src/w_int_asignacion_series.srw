$PBExportHeader$w_int_asignacion_series.srw
forward
global type w_int_asignacion_series from w_int_con_empresa
end type
type pb_1 from upb_salir within w_int_asignacion_series
end type
type pb_imprimir from upb_imprimir within w_int_asignacion_series
end type
type dw_listado from datawindow within w_int_asignacion_series
end type
type uo_manejo from u_manejo_datawindow within w_int_asignacion_series
end type
type rb_pendientes from radiobutton within w_int_asignacion_series
end type
type rb_todos from radiobutton within w_int_asignacion_series
end type
type cb_continuar from u_boton within w_int_asignacion_series
end type
type dw_conpromped1 from u_datawindow_consultas within w_int_asignacion_series
end type
type gb_1 from groupbox within w_int_asignacion_series
end type
end forward

global type w_int_asignacion_series from w_int_con_empresa
integer width = 2921
integer height = 1688
pb_1 pb_1
pb_imprimir pb_imprimir
dw_listado dw_listado
uo_manejo uo_manejo
rb_pendientes rb_pendientes
rb_todos rb_todos
cb_continuar cb_continuar
dw_conpromped1 dw_conpromped1
gb_1 gb_1
end type
global w_int_asignacion_series w_int_asignacion_series

type variables
String tipo = "P"
Integer anterior
String  valor_anterior
end variables

on w_int_asignacion_series.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_imprimir=create pb_imprimir
this.dw_listado=create dw_listado
this.uo_manejo=create uo_manejo
this.rb_pendientes=create rb_pendientes
this.rb_todos=create rb_todos
this.cb_continuar=create cb_continuar
this.dw_conpromped1=create dw_conpromped1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_imprimir
this.Control[iCurrent+3]=this.dw_listado
this.Control[iCurrent+4]=this.uo_manejo
this.Control[iCurrent+5]=this.rb_pendientes
this.Control[iCurrent+6]=this.rb_todos
this.Control[iCurrent+7]=this.cb_continuar
this.Control[iCurrent+8]=this.dw_conpromped1
this.Control[iCurrent+9]=this.gb_1
end on

on w_int_asignacion_series.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_imprimir)
destroy(this.dw_listado)
destroy(this.uo_manejo)
destroy(this.rb_pendientes)
destroy(this.rb_todos)
destroy(this.cb_continuar)
destroy(this.dw_conpromped1)
destroy(this.gb_1)
end on

event open;call super::open;istr_parametros.s_titulo_ventana =   "Asignacion series a pedidos"
istr_parametros.s_listado        =   ""
This.title                       =   istr_parametros.s_titulo_ventana
dw_conpromped1.SetTransObject(SQLCA)
dw_listado.SetTransObject(SQLCA)
rb_pendientes.checked= TRUE
rb_todos.checked= FALSE


end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_manejo.triggerEvent("pagina_abajo")
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_manejo.triggerEvent("pagina_arriba")
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_conpromped1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_conpromped1)
end event

event ue_listar;dw_listado.SetFilter("")
dw_listado.Filter()
IF  tipo = "P" Then
	dw_listado.SetFilter("IsNull(numserie)")
	dw_listado.Filter()
END IF
dw_listado.retrieve(codigo_empresa)
dw_report =dw_listado
Call Super::ue_listar
end event

event activate;call super::activate;w_int_asignacion_series = ventanas_activas[id_ventana_activa].ventana
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_int_asignacion_series
integer taborder = 30
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_int_asignacion_series
end type

type st_empresa from w_int_con_empresa`st_empresa within w_int_asignacion_series
end type

type pb_1 from upb_salir within w_int_asignacion_series
integer x = 2711
integer y = 36
integer width = 123
integer height = 104
integer taborder = 0
end type

type pb_imprimir from upb_imprimir within w_int_asignacion_series
integer x = 2715
integer y = 208
integer width = 101
integer height = 84
integer taborder = 0
boolean originalsize = false
end type

event clicked;call super::clicked;Parent.triggerEvent("ue_listar")
end event

type dw_listado from datawindow within w_int_asignacion_series
boolean visible = false
integer x = 59
integer y = 8
integer width = 494
integer height = 264
boolean bringtotop = true
string dataobject = "report_int_asignacion_series"
boolean livescroll = true
end type

type uo_manejo from u_manejo_datawindow within w_int_asignacion_series
integer x = 2235
integer y = 160
integer width = 608
integer height = 156
end type

event valores;call super::valores;dw_data=dw_conpromped1

end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type rb_pendientes from radiobutton within w_int_asignacion_series
integer x = 96
integer y = 184
integer width = 329
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Pdtes"
end type

event clicked;rb_pendientes.checked= TRUE
rb_todos.checked= FALSE
tipo= "P"

end event

type rb_todos from radiobutton within w_int_asignacion_series
integer x = 421
integer y = 184
integer width = 329
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Todos"
end type

event clicked;rb_pendientes.checked= FALSE
rb_todos.checked= TRUE
tipo= "T"
end event

type cb_continuar from u_boton within w_int_asignacion_series
integer x = 823
integer y = 188
integer height = 72
integer taborder = 20
string text = "&Continuar"
end type

event clicked;call super::clicked;
string filtro
dw_conpromped1.SetFilter("")
dw_conpromped1.Filter()
IF  tipo = "P" Then
    filtro=""
	 filtro= "IsNull(numserie)" + " or " + " trim(numserie)='' "
    dw_conpromped1.SetFilter(filtro)
	 dw_conpromped1.Filter()
END IF
dw_conpromped1.Retrieve(codigo_empresa)

end event

type dw_conpromped1 from u_datawindow_consultas within w_int_asignacion_series
integer x = 37
integer y = 308
integer width = 2816
integer height = 1120
integer taborder = 10
string dataobject = "dw_int_asignacion_series"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event key;IF This.GetItemString(This.GetRow(),"situacion") = "P" Then Return
IF KeyDown(KeyEnter!) OR KeyDown(KeyTab!) THEN
 valor_empresa = TRUE	
 bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "numserie"
      bus_titulo     = "VENTANA SELECCION DE Series "
 		bus_datawindow = "dw_ayuda_promseries_stock"
 		bus_filtro = "tipo_expositor = '" + This.GetItemString(This.GetRow(),"tipo_expositor")+"'"
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key
 
END IF



IF KeyDown(KeyDelete!)THEN
Dec{0} var_pedido,var_anyo,bien
DateTime var_fpedido
String var_numserie,var_numserie_ant,var_cliente
bien = 0 
Accepttext()
	var_anyo     = GetItemNumber(GetRow(),"anyo")
	var_pedido   = GetItemNumber(GetRow(),"pedido")
	var_numserie = GetItemString(GetRow(),"numserie")
	var_cliente = GetItemString(GetRow(),"cliente")
	var_fpedido = GetItemDateTime(GetRow(),"fpedido")
	Select numserie Into :var_numserie_ant From promped
	Where  empresa = :codigo_empresa
	And    anyo    = :var_anyo
	And    pedido  = :var_pedido;
	IF Not IsNull(var_numserie_ant) And var_numserie_ant <> "" Then
		UPdate  promseries
		Set    situacion = "S",
		       cliente   = null,
				 anyo      = null,
				 pedido    = null,
				 fpedido    = null,
				 nombre     = null,
				 domicilio  = null,
				 codpostal  = null,
				 provincia  = null,
				 pais       = null,
				 poblacion  = null
				 
 	 Where   empresa = :codigo_empresa
	 And     codigo  = :var_numserie_ant;
	 IF SQLCA.SQLCODE <> 0 Then bien = 1

	END IF
	Update  promped
	Set    numserie = null
	Where  empresa = :codigo_empresa
	And    anyo    = :var_anyo
	And    pedido  = :var_pedido;
	Update  promlinped
	Set    numserie = null
	Where  empresa = :codigo_empresa
	And    anyo    = :var_anyo
	And    pedido  = :var_pedido;
   IF SQLCA.SQLCODE <> 0 Then bien = 1
END IF
SetItem(GetRow(),"numserie","")
IF bien = 0 Then
	COMMIT;
ELSE
	f_mensaje("Error en proceso","error")
END IF

end event

event rbuttondown;IF This.GetItemString(This.GetRow(),"situacion") = "P" Then Return
 valor_empresa = TRUE	
 bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "numserie"
      bus_titulo     = "VENTANA SELECCION DE Series "
 		bus_datawindow = "dw_ayuda_promseries_stock"
 		bus_filtro = "tipo_expositor = '" + This.GetItemString(This.GetRow(),"tipo_expositor")+"'"
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
 

end event

event rowfocuschanged;call super::rowfocuschanged;IF GetRow() = 0 Then Return
Dec{0}   var_pedido,var_anyo
String   var_numserie_ant
AcceptText()

IF anterior <> 0 And Not Isnull(anterior) Then
	var_anyo     = GetItemNumber(anterior,"anyo")
	var_pedido   = GetItemNumber(anterior,"pedido")
	Select numserie Into :var_numserie_ant From promped
	Where  empresa = :codigo_empresa
	And    anyo    = :var_anyo
	And    pedido  = :var_pedido;
	SetItem(anterior,"numserie",var_numserie_ant)
END IF

anterior = This.GetRow()
valor_anterior = This.GetItemString(anterior,"numserie")
end event

event retrieveend;call super::retrieveend;IF RowCount() <> 0 Then
anterior = 1
valor_anterior = This.GetItemString(1,"numserie")
END IF
end event

event clicked;call super::clicked;IF GetRow() = 0 Then Return
SetRow(row)
SetColumn("numserie")
IF This.GetItemString(This.GetRow(),"situacion") = "P" Then Return
Dec{0} var_pedido,var_anyo,bien
DateTime var_fpedido
String var_numserie,var_numserie_ant,var_cliente,var_nombre,var_domicilio,var_codpostal,var_provincia,var_pais,var_poblacion,var_envio
bien = 0 
Accepttext()



IF f_objeto_datawindow(This) = "ok" Then
	var_anyo     = GetItemNumber(GetRow(),"anyo")
	var_pedido   = GetItemNumber(GetRow(),"pedido")
	var_numserie = GetItemString(GetRow(),"numserie")
	IF Not IsNull(var_numserie) Then
		IF Trim(var_numserie) = "" Then SetNull(var_numserie)
	END IF
	var_cliente = GetItemString(GetRow(),"cliente")
	var_fpedido = GetItemDateTime(GetRow(),"fpedido")
	Select  promped.envio Into :var_envio From promped
	WHERE ( promped.empresa = :codigo_empresa )
	AND   ( promped.anyo    = :var_anyo)
	AND   ( promped.pedido  = :var_pedido);
			IF sqlca.sqlcode = 100 Then
				var_envio = ""
			ELSE
  SELECT venenvio.pais,     venenvio.provincia,    venenvio.codpostal,   
         venenvio.localidad,venenvio.domicilio  
    INTO :var_pais,:var_provincia,:var_codpostal,:var_poblacion,:var_domicilio 
    FROM venenvio  
   WHERE (venenvio.empresa = :codigo_empresa )
	AND   (venenvio.cliente = :var_cliente )
   AND   (venenvio.codigo = :var_envio );
		IF sqlca.sqlcode = 100 Then	var_envio = ""
		iF IsNull(var_envio) Then var_envio = ""
	END IF
	IF var_envio = "" Then
  SELECT genter.razon,genter.pais,genter.provincia,genter.cod_postal,   
         genter.domicilio,genter.localidad  
    INTO :var_nombre,:var_pais,:var_provincia,:var_codpostal,   
         :var_domicilio,:var_poblacion  
    FROM genter  
   WHERE (genter.empresa = :codigo_empresa ) AND  
         (genter.tipoter = 'C' ) AND  
         (genter.codigo  = :var_cliente);
	ELSE
	  SELECT genter.razon  INTO :var_nombre
     FROM genter  
     WHERE ( genter.empresa = :codigo_empresa ) AND  
           ( genter.tipoter = 'C' ) AND  
           ( genter.codigo  = :var_cliente);
		END IF

		Select numserie Into :var_numserie_ant From promped
		Where  empresa = :codigo_empresa
		And    anyo    = :var_anyo
		And    pedido  = :var_pedido;
		IF Not IsNull(var_numserie_ant) And var_numserie_ant <> "" Then
			
	
		UPdate  promseries
		Set    situacion  = "S",
		       cliente    = null,
				 anyo       = null,
				 pedido     = null,
				 fpedido    = null,
				 nombre     = null,
				 domicilio  = null,
				 codpostal  = null,
				 provincia  = null,
				 pais       = null,
				 poblacion  = null
 	 Where   empresa = :codigo_empresa
	 And     codigo  = :var_numserie_ant;
	 IF SQLCA.SQLCODE <> 0 Then bien = 1

	END IF
	Update  promped
	Set    numserie = :var_numserie
	Where  empresa = :codigo_empresa
	And    anyo    = :var_anyo
	And    pedido  = :var_pedido;
	   IF SQLCA.SQLCODE <> 0 Then bien = 1
	Update  promlinped
	Set    numserie = :var_numserie
	Where  empresa = :codigo_empresa
	And    anyo    = :var_anyo
	And    pedido  = :var_pedido;
   IF SQLCA.SQLCODE <> 0 Then bien = 1
		UPdate  promseries
		Set    situacion = "R",
		       cliente   = :var_cliente,
				 anyo      = :var_anyo,
				 pedido    = :var_pedido,
 				 fpedido   = :var_fpedido,
  				 nombre     = :var_nombre,
				 domicilio  = :var_domicilio,
				 codpostal  = :var_codpostal,
				 provincia  = :var_provincia,
				 pais       = :var_pais,
				 poblacion  = :var_poblacion
 	 Where   empresa = :codigo_empresa
	 And     codigo  = :var_numserie;
	 IF SQLCA.SQLCODE <> 0 Then bien = 1
	
END IF
IF bien = 0 Then
	COMMIT;
ELSE
	f_mensaje("Error en proceso","error")
END IF
end event

event doubleclicked;call super::doubleclicked;string pedido
date fec
str_parametros lstr_param 
  lstr_param.i_nargumentos=3
  lstr_param.s_argumentos[2]=String(dw_conpromped1.GetItemNumber(This.GetRow(),"anyo"))
  lstr_param.s_argumentos[3]=String(dw_conpromped1.GetItemNumber(This.GetRow(),"pedido"))
  OpenWithParm(w_int_prompedidos,lstr_param)

end event

type gb_1 from groupbox within w_int_asignacion_series
integer x = 41
integer y = 140
integer width = 1202
integer height = 132
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

