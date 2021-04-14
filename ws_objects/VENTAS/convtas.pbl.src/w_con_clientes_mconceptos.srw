$PBExportHeader$w_con_clientes_mconceptos.srw
forward
global type w_con_clientes_mconceptos from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_clientes_mconceptos
end type
type uo_manejo from u_manejo_datawindow within w_con_clientes_mconceptos
end type
type dw_listado4 from datawindow within w_con_clientes_mconceptos
end type
type pb_imprimir from upb_imprimir within w_con_clientes_mconceptos
end type
type rb_1 from radiobutton within w_con_clientes_mconceptos
end type
type rb_2 from radiobutton within w_con_clientes_mconceptos
end type
type rb_3 from radiobutton within w_con_clientes_mconceptos
end type
type cb_1 from commandbutton within w_con_clientes_mconceptos
end type
type dw_1 from datawindow within w_con_clientes_mconceptos
end type
type ddlb_1 from dropdownlistbox within w_con_clientes_mconceptos
end type
type st_2 from statictext within w_con_clientes_mconceptos
end type
type uo_paises from u_marca_lista within w_con_clientes_mconceptos
end type
type cb_2 from commandbutton within w_con_clientes_mconceptos
end type
type dw_distribuidores from datawindow within w_con_clientes_mconceptos
end type
type gb_1 from groupbox within w_con_clientes_mconceptos
end type
end forward

global type w_con_clientes_mconceptos from w_int_con_empresa
integer width = 2949
integer height = 1684
pb_1 pb_1
uo_manejo uo_manejo
dw_listado4 dw_listado4
pb_imprimir pb_imprimir
rb_1 rb_1
rb_2 rb_2
rb_3 rb_3
cb_1 cb_1
dw_1 dw_1
ddlb_1 ddlb_1
st_2 st_2
uo_paises uo_paises
cb_2 cb_2
dw_distribuidores dw_distribuidores
gb_1 gb_1
end type
global w_con_clientes_mconceptos w_con_clientes_mconceptos

type variables
string filtro,tipocon
end variables

event open;call super::open;istr_parametros.s_titulo_ventana="Clientes por pais (Conceptos/Mailing)"
This.title=istr_parametros.s_titulo_ventana

dw_distribuidores.SetTransObject(SQLCA)
dw_distribuidores.SetRowFocusIndicator(Hand!)
dw_listado4.SetTransObject(SQLCA)
dw_1.SetTransObject(SQLCA)

tipocon = 'S' // opcion de todos los activos
ddlb_1.text = "Excluidos"

datastore d
String sel,marca,var_codigo,var_texto
dec registros,x1

sel = "select pais,nombre from paises order by nombre"
		
//d = f_cargar_cursor(sel)
f_cargar_cursor_nuevo(sel,d)
    
registros=d.retrieve()

If registros<>0 THEN
 FOR x1= 1 To registros
  var_codigo  = d.GetItemString(x1,"pais")
  var_texto   = d.GetItemString(x1,"nombre")
  marca="S"
  uo_paises.dw_marca.InsertRow(x1)
  uo_paises.dw_marca.setitem(x1,"marca",marca)
  uo_paises.dw_marca.setitem(x1,"codigo",var_codigo)
  uo_paises.dw_marca.setitem(x1,"texto",var_texto)
NEXT
END IF
uo_paises.st_titulo1.text="Pais"
uo_paises.st_titulo2.text="Nombre"

destroy d
end event

on w_con_clientes_mconceptos.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.uo_manejo=create uo_manejo
this.dw_listado4=create dw_listado4
this.pb_imprimir=create pb_imprimir
this.rb_1=create rb_1
this.rb_2=create rb_2
this.rb_3=create rb_3
this.cb_1=create cb_1
this.dw_1=create dw_1
this.ddlb_1=create ddlb_1
this.st_2=create st_2
this.uo_paises=create uo_paises
this.cb_2=create cb_2
this.dw_distribuidores=create dw_distribuidores
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.uo_manejo
this.Control[iCurrent+3]=this.dw_listado4
this.Control[iCurrent+4]=this.pb_imprimir
this.Control[iCurrent+5]=this.rb_1
this.Control[iCurrent+6]=this.rb_2
this.Control[iCurrent+7]=this.rb_3
this.Control[iCurrent+8]=this.cb_1
this.Control[iCurrent+9]=this.dw_1
this.Control[iCurrent+10]=this.ddlb_1
this.Control[iCurrent+11]=this.st_2
this.Control[iCurrent+12]=this.uo_paises
this.Control[iCurrent+13]=this.cb_2
this.Control[iCurrent+14]=this.dw_distribuidores
this.Control[iCurrent+15]=this.gb_1
end on

on w_con_clientes_mconceptos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.uo_manejo)
destroy(this.dw_listado4)
destroy(this.pb_imprimir)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.rb_3)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.ddlb_1)
destroy(this.st_2)
destroy(this.uo_paises)
destroy(this.cb_2)
destroy(this.dw_distribuidores)
destroy(this.gb_1)
end on

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_distribuidores)

IF dw_distribuidores.GetRow() = 0 Then Return

String cliente 

cliente =dw_distribuidores.GetItemString(dw_distribuidores.GetRow(),"codigo")
dw_1.Retrieve(codigo_empresa,cliente)

end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_distribuidores)
IF dw_distribuidores.GetRow() = 0 Then Return

String cliente 

cliente =dw_distribuidores.GetItemString(dw_distribuidores.GetRow(),"codigo")
dw_1.Retrieve(codigo_empresa,cliente)

end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_manejo.triggerEvent("pagina_abajo")
IF dw_distribuidores.GetRow() = 0 Then Return

String cliente 

cliente =dw_distribuidores.GetItemString(dw_distribuidores.GetRow(),"codigo")
dw_1.Retrieve(codigo_empresa,cliente)

end event

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_manejo.triggerEvent("pagina_arriba")
IF dw_distribuidores.GetRow() = 0 Then Return

String cliente 

cliente =dw_distribuidores.GetItemString(dw_distribuidores.GetRow(),"codigo")
dw_1.Retrieve(codigo_empresa,cliente)

end event

event ue_f5;call super::ue_f5;cb_1.TriggerEvent(Clicked!)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_clientes_mconceptos
integer taborder = 40
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_clientes_mconceptos
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_clientes_mconceptos
integer y = 8
integer width = 1893
end type

type pb_1 from upb_salir within w_con_clientes_mconceptos
integer x = 2688
integer y = 8
integer width = 114
integer height = 108
integer taborder = 0
end type

type uo_manejo from u_manejo_datawindow within w_con_clientes_mconceptos
integer x = 2226
integer y = 132
integer width = 613
end type

event valores;call super::valores;dw_data=dw_distribuidores

end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type dw_listado4 from datawindow within w_con_clientes_mconceptos
boolean visible = false
integer x = 37
integer y = 4
integer width = 379
integer height = 140
boolean bringtotop = true
string dataobject = "report_con_clientes_mconceptos"
boolean livescroll = true
end type

type pb_imprimir from upb_imprimir within w_con_clientes_mconceptos
integer x = 2706
integer y = 180
integer width = 101
integer height = 84
integer taborder = 0
boolean bringtotop = true
boolean originalsize = false
end type

event clicked;call super::clicked;String filtropaises,montaje,filtroactivo
dec y1,numero,x1

filtroactivo = ""
filtroactivo = " genter_activo = '" + tipocon + "' "

if tipocon = 'T' then filtroactivo = ""

y1=0
numero = uo_paises.dw_marca.RowCount()
IF numero =0 Then return
FOR x1 = 1 To numero
IF uo_paises.dw_marca.GetItemString(x1,"marca") = "S" THEN
 y1=y1+1
 IF Trim(filtropaises)="" Then
    montaje = " genter_pais = '" + uo_paises.dw_marca.GetItemString(x1,"codigo") + "'"		
 Else
    montaje = " Or genter_pais = '" + uo_paises.dw_marca.GetItemString(x1,"codigo") + "'"
 End If
 filtropaises = filtropaises + montaje
END IF
NEXT

IF Trim(filtroactivo) <> "" THEN
   filtro = filtroactivo +" and ("+filtropaises+")"
 else
	filtro = filtropaises
END IF


IF TRIM(filtro)<>"" THEN
 dw_listado4.SetFilter(filtro)
 dw_listado4.Filter()
END IF


dw_listado4.Retrieve(codigo_empresa)
f_imprimir_datawindow(dw_listado4)

end event

type rb_1 from radiobutton within w_con_clientes_mconceptos
integer x = 837
integer y = 200
integer width = 247
integer height = 56
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Todos"
end type

event clicked;		// Si estaba seleccionado otra opcion, limpio la Datawindow

//IF tipocon <> 'T' THEN dw_distribuidores.Reset()

tipocon = 'T'



end event

type rb_2 from radiobutton within w_con_clientes_mconceptos
integer x = 1093
integer y = 200
integer width = 274
integer height = 56
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Activos"
boolean checked = true
end type

event clicked;		// Si estaba seleccionado otra opcion, limpio la Datawindow

//IF tipocon <> 'S' THEN dw_distribuidores.Reset()

tipocon = 'S'



end event

type rb_3 from radiobutton within w_con_clientes_mconceptos
integer x = 1358
integer y = 200
integer width = 315
integer height = 56
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Inactivos"
end type

event clicked;		// Si estaba seleccionado otra opcion, limpio la Datawindow

//IF tipocon <> 'N' THEN dw_distribuidores.Reset()

tipocon = 'N'



end event

type cb_1 from commandbutton within w_con_clientes_mconceptos
integer x = 343
integer y = 184
integer width = 334
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Continuar"
end type

event clicked;uo_paises.visible = False

String filtropaises,montaje,filtroactivo
dec y1,numero,x1
filtro = ""
dw_distribuidores.Setfilter(filtro)

filtroactivo = "activo = '" + tipocon + "'"

if tipocon = 'T' then filtroactivo = ""

y1=0
numero = uo_paises.dw_marca.RowCount()
IF numero =0 Then return
FOR x1 = 1 To numero
IF uo_paises.dw_marca.GetItemString(x1,"marca") = "S" THEN
 y1=y1+1
 IF Trim(filtropaises)="" Then
    montaje = " pais = '" + uo_paises.dw_marca.GetItemString(x1,"codigo") + "'"
 Else
    montaje = " Or pais = '" + uo_paises.dw_marca.GetItemString(x1,"codigo") + "'"
 End If
 filtropaises = filtropaises + montaje
END IF
NEXT

IF Trim(filtroactivo) <> "" THEN
   filtro =  filtroactivo +" and ("+filtropaises+")"
 else
	filtro = filtropaises
END IF



IF TRIM(filtro)<>"" THEN
 dw_distribuidores.SetFilter(filtro)
 dw_distribuidores.Filter()
END IF

dw_distribuidores.Retrieve(codigo_empresa)

end event

type dw_1 from datawindow within w_con_clientes_mconceptos
integer x = 1463
integer y = 292
integer width = 1371
integer height = 1148
boolean bringtotop = true
string dataobject = "dw_lista_mconceptos1"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;IF row = 0 Then Return

String codigo,cliente
Integer numero


codigo =  f_valor_columna(This,row,"codigo")
cliente = dw_distribuidores.GetItemString(dw_distribuidores.GetRow(),"codigo")

Select Count(*) Into :numero From mconceptoscltes
Where  mconceptoscltes.empresa = :codigo_empresa
And    mconceptoscltes.cliente = :cliente
And    mconceptoscltes.codigo = :codigo;
If IsNull(numero) Then numero = 0

IF numero = 0 Then
   INSERT INTO mconceptoscltes
         ( empresa,   
           cliente,
			  codigo)  
  VALUES ( :codigo_empresa,   
           :cliente,
			  :codigo)  ;
Else
  DELETE FROM mconceptoscltes
   WHERE  mconceptoscltes.empresa = :codigo_empresa 
	  AND  mconceptoscltes.cliente = :cliente 
  	  AND  mconceptoscltes.codigo  = :codigo    ;
END IF
COMMIT;
Retrieve(codigo_empresa,cliente)
end event

type ddlb_1 from dropdownlistbox within w_con_clientes_mconceptos
integer x = 1856
integer y = 184
integer width = 338
integer height = 228
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean vscrollbar = true
string item[] = {"Excluidos","Incluidos"}
end type

type st_2 from statictext within w_con_clientes_mconceptos
integer x = 1865
integer y = 124
integer width = 247
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Listado"
alignment alignment = right!
boolean focusrectangle = false
end type

type uo_paises from u_marca_lista within w_con_clientes_mconceptos
boolean visible = false
integer x = 5
integer y = 296
integer width = 1376
integer height = 676
integer taborder = 50
borderstyle borderstyle = styleraised!
end type

on uo_paises.destroy
call u_marca_lista::destroy
end on

type cb_2 from commandbutton within w_con_clientes_mconceptos
integer x = 9
integer y = 184
integer width = 334
integer height = 84
integer taborder = 10
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Paises"
end type

event clicked;if uo_paises.visible = False then
	uo_paises.visible = True
else
	uo_paises.visible = False
End if
end event

type dw_distribuidores from datawindow within w_con_clientes_mconceptos
event doubleclicked pbm_dwnlbuttondblclk
integer x = 5
integer y = 292
integer width = 1458
integer height = 1148
string dataobject = "dw_con_clientes_mconceptos"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;IF row = 0 Then Return

String codigo,cliente,tipoter,var_activo


tipoter=  f_valor_columna(This,row,"tipoter")
codigo =  f_valor_columna(This,row,"codigo")


Select activo Into :var_activo From genter
Where  genter.empresa = :codigo_empresa
And    genter.tipoter = :tipoter
And    genter.codigo = :codigo;
If IsNull(var_activo) Then var_activo = "S"

CHOOSE CASE var_activo
	case "S"
		var_activo = "N"
	case else
		var_activo = "S"
END CHOOSE

UPDATE genter  
   SET activo = :var_activo  
 WHERE genter.empresa = :codigo_empresa 
   AND genter.tipoter = :tipoter 
	AND  genter.codigo = :codigo ;
COMMIT;

dw_distribuidores.SetItem(row,"activo",var_activo)
end event

event clicked;IF Row = 0 Then Return

String cliente 

cliente =This.GetItemString(Row,"codigo")
dw_1.Retrieve(codigo_empresa,cliente)


end event

event rbuttondown;IF Row = 0 Then Return

str_parametros lstr_param
lstr_param.i_nargumentos=2
lstr_param.s_argumentos[2]=This.GetItemString(Row,"codigo")
OpenWithParm(wi_mant_clientes2,lstr_param) 

end event

type gb_1 from groupbox within w_con_clientes_mconceptos
integer x = 823
integer y = 144
integer width = 869
integer height = 132
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

