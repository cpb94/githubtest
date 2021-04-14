$PBExportHeader$w_con_pedidos_bloqueos.srw
forward
global type w_con_pedidos_bloqueos from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_pedidos_bloqueos
end type
type dw_detalle from datawindow within w_con_pedidos_bloqueos
end type
type em_fechadesde from u_em_campo within w_con_pedidos_bloqueos
end type
type em_fechahasta from u_em_campo within w_con_pedidos_bloqueos
end type
type cb_1 from commandbutton within w_con_pedidos_bloqueos
end type
type gb_4 from groupbox within w_con_pedidos_bloqueos
end type
type gb_1 from groupbox within w_con_pedidos_bloqueos
end type
type uo_cliente from u_em_campo_2 within w_con_pedidos_bloqueos
end type
type gb_3 from groupbox within w_con_pedidos_bloqueos
end type
type st_1 from statictext within w_con_pedidos_bloqueos
end type
type uo_series from u_marca_lista within w_con_pedidos_bloqueos
end type
type ddlb_estado from dropdownlistbox within w_con_pedidos_bloqueos
end type
type tv_1 from treeview within w_con_pedidos_bloqueos
end type
type ddlb_esta_fabricado from dropdownlistbox within w_con_pedidos_bloqueos
end type
type gb_6 from groupbox within w_con_pedidos_bloqueos
end type
type gb_2 from groupbox within w_con_pedidos_bloqueos
end type
end forward

global type w_con_pedidos_bloqueos from w_int_con_empresa
integer width = 5253
integer height = 3212
string title = "Gestión de bloqueo de pedidos"
pb_1 pb_1
dw_detalle dw_detalle
em_fechadesde em_fechadesde
em_fechahasta em_fechahasta
cb_1 cb_1
gb_4 gb_4
gb_1 gb_1
uo_cliente uo_cliente
gb_3 gb_3
st_1 st_1
uo_series uo_series
ddlb_estado ddlb_estado
tv_1 tv_1
ddlb_esta_fabricado ddlb_esta_fabricado
gb_6 gb_6
gb_2 gb_2
end type
global w_con_pedidos_bloqueos w_con_pedidos_bloqueos

type variables
boolean detalle = true,valorado = true,muestras = false
end variables

forward prototypes
public subroutine f_control ()
end prototypes

public subroutine f_control ();Datetime fecha1,fecha2
String   series ,cliente, filtro, nombre_empresa, bloqueado, esta_fabricado

dw_detalle.Reset()
dw_detalle.selectrow(0,false)
dw_detalle.SelectRow(1,true)

if not isnull(em_fechadesde.Text) and em_fechadesde.Text <> '' and em_fechadesde.Text <> "00-00-00" &
	and not isnull(em_fechahasta.Text) and em_fechahasta.Text <> '' and em_fechahasta.Text <> "00-00-00" then
	fecha1 = Datetime(em_fechadesde.Text)
	fecha2 = Datetime(em_fechahasta.Text)
else
	fecha1 = Datetime(Date('01-01-2001'))
	fecha2 = Datetime(Date(Today()))
end if

if uo_cliente.em_codigo.text <> "" then
	cliente = uo_cliente.em_codigo.text
else
	cliente = "%"
end if

IF ddlb_estado.text = "BLOQUEADO" THEN
	bloqueado = " venliped_bloqueado = '1' "
ELSEIF ddlb_estado.text = "DISPONIBLE" THEN
	bloqueado = " venliped_bloqueado = '0' " 
ELSE
	bloqueado = " 1 = 1"
END IF

IF ddlb_esta_fabricado.text = "S" THEN
	esta_fabricado = " venliped_esta_fabricado = 'S' "
ELSEIF ddlb_esta_fabricado.text = "N" THEN
	esta_fabricado = " ( venliped_esta_fabricado = 'N' OR ISNULL(venliped_esta_fabricado) )"
ELSE
	esta_fabricado = " 1= 1 "
END IF

filtro = bloqueado+' and '+ esta_fabricado

dw_detalle.Retrieve(codigo_empresa,fecha1,fecha2,cliente)

dw_detalle.SetRedraw(false)
dw_detalle.SetFilter(filtro)
dw_detalle.Filter()
dw_detalle.Groupcalc()
dw_detalle.SetRedraw(true)


dw_detalle.TriggerEvent(rowfocuschanged!)
dw_detalle.SetFocus()

select nombre
into :nombre_empresa
from empresas
where empresa = :codigo_empresa
USING SQLCA;


//dw_detalle.object.titulo.text = nombre_empresa



end subroutine

event close;call super::close;dw_detalle.reset()

end event

event open;call super::open;istr_parametros.s_titulo_ventana="Gestión de bloqueo de pedidos"
This.title=istr_parametros.s_titulo_ventana
em_fechadesde.text = String(MDY(01,01,Year(Today())))
em_fechahasta.text = String(Today())
ddlb_estado.text = "BLOQUEADO"
ddlb_esta_fabricado.text = "TODOS"
dw_detalle.SetTransObject(SQLCA)
uo_series.f_cargar_datos("dw_ayuda_venseries","","","Serie","Descripción")
end event

on w_con_pedidos_bloqueos.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.dw_detalle=create dw_detalle
this.em_fechadesde=create em_fechadesde
this.em_fechahasta=create em_fechahasta
this.cb_1=create cb_1
this.gb_4=create gb_4
this.gb_1=create gb_1
this.uo_cliente=create uo_cliente
this.gb_3=create gb_3
this.st_1=create st_1
this.uo_series=create uo_series
this.ddlb_estado=create ddlb_estado
this.tv_1=create tv_1
this.ddlb_esta_fabricado=create ddlb_esta_fabricado
this.gb_6=create gb_6
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.dw_detalle
this.Control[iCurrent+3]=this.em_fechadesde
this.Control[iCurrent+4]=this.em_fechahasta
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.gb_4
this.Control[iCurrent+7]=this.gb_1
this.Control[iCurrent+8]=this.uo_cliente
this.Control[iCurrent+9]=this.gb_3
this.Control[iCurrent+10]=this.st_1
this.Control[iCurrent+11]=this.uo_series
this.Control[iCurrent+12]=this.ddlb_estado
this.Control[iCurrent+13]=this.tv_1
this.Control[iCurrent+14]=this.ddlb_esta_fabricado
this.Control[iCurrent+15]=this.gb_6
this.Control[iCurrent+16]=this.gb_2
end on

on w_con_pedidos_bloqueos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.dw_detalle)
destroy(this.em_fechadesde)
destroy(this.em_fechahasta)
destroy(this.cb_1)
destroy(this.gb_4)
destroy(this.gb_1)
destroy(this.uo_cliente)
destroy(this.gb_3)
destroy(this.st_1)
destroy(this.uo_series)
destroy(this.ddlb_estado)
destroy(this.tv_1)
destroy(this.ddlb_esta_fabricado)
destroy(this.gb_6)
destroy(this.gb_2)
end on

event ue_f5;call super::ue_f5;f_control()
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_pedidos_bloqueos
integer y = 612
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_pedidos_bloqueos
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_pedidos_bloqueos
integer x = 9
integer y = 8
integer width = 5019
integer height = 88
end type

type pb_1 from upb_salir within w_con_pedidos_bloqueos
integer x = 5070
integer y = 4
integer width = 128
integer height = 108
integer taborder = 0
end type

type dw_detalle from datawindow within w_con_pedidos_bloqueos
integer x = 5
integer y = 280
integer width = 5216
integer height = 1976
integer taborder = 80
string dataobject = "dw_con_pedidos_bloqueos"
richtexttoolbaractivation richtexttoolbaractivation = richtexttoolbaractivationalways!
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;str_parametros lstr_param
IF Row <> 0 Then
  lstr_param.i_nargumentos=3
  lstr_param.s_argumentos[2]=String(This.GetItemNumber(Row,"anyo"))
  lstr_param.s_argumentos[3]=String(This.GetItemNumber(Row,"pedido"))
  OpenWithParm(w_int_venped,lstr_param) 
End If
end event

event itemchanged;int rtn

rtn = 1
if row <> 0 then
	if String(dwo.Name) = 'venliped_bloqueado' then
		if String(this.object.venliped_bloqueado[row]) = '1' and data = '0' then
			this.object.venliped_fecha_intr[row] = DateTime(Today(),Time(0))
		elseif String(this.object.venliped_bloqueado[row]) = '0' and data = '1' then
			//NO ELIMINAR LA FECHA
			//this.object.venliped_fecha_intr[row] = datetime('')
		end if
		this.object.venliped_bloqueado[row] = data
		rtn = this.Update()
		if rtn = 1 then 
			commit using sqlca;
		else
			rollback using sqlca;
		end if
	end if
	
	
	this.selectrow(0,false)
	this.selectrow(row,true)
	//f_control()
end if

if dwo.Name = 'venliped_esta_fabricado' then
	this.object.venliped_esta_fabricado[row] = data
	rtn = this.Update()
	if rtn = 1 then 
		commit using sqlca;
	else
		rollback using sqlca;
	end if
	
end if
	

end event

event rowfocuschanged;
if currentrow <> 0 then
	if this.object.articulos_codigo[currentrow] <> "" then
		tv_1.deleteitem(0)
		f_escandallo_treeview( this.object.articulos_codigo[currentrow], 0, tv_1)
	end if
	this.selectrow(0,false)
	this.selectrow(currentrow,true)
else
	if this.rowcount() > 0 then
		this.selectrow(0,false)
		this.selectrow(1,true)
		tv_1.deleteitem(0)
		f_escandallo_treeview( this.object.articulos_codigo[1], 0, tv_1)
	else
		tv_1.deleteitem(0)
	end if
end if

end event

type em_fechadesde from u_em_campo within w_con_pedidos_bloqueos
integer x = 23
integer y = 168
integer width = 270
integer taborder = 10
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 33551858
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type em_fechahasta from u_em_campo within w_con_pedidos_bloqueos
integer x = 329
integer y = 168
integer width = 270
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 33551858
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type cb_1 from commandbutton within w_con_pedidos_bloqueos
integer x = 4896
integer y = 160
integer width = 288
integer height = 108
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Mostrar"
end type

event clicked; f_control()

end event

type gb_4 from groupbox within w_con_pedidos_bloqueos
integer x = 1893
integer y = 104
integer width = 631
integer height = 176
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Estado del pedido"
end type

type gb_1 from groupbox within w_con_pedidos_bloqueos
integer x = 9
integer y = 104
integer width = 613
integer height = 176
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fechas"
end type

type uo_cliente from u_em_campo_2 within w_con_pedidos_bloqueos
event destroy ( )
integer x = 635
integer y = 168
integer width = 1234
integer taborder = 30
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

event modificado;call super::modificado;uo_cliente.em_campo.text=f_nombre_cliente(codigo_empresa,"C",uo_cliente.em_codigo.text)
If Trim(uo_cliente.em_campo.text)="" then
	uo_cliente.em_campo.text=""
	uo_cliente.em_codigo.text=""
	Return
end if 


end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Clientes"
ue_datawindow ="dw_ayuda_clientes"
ue_filtro = ""
end event

type gb_3 from groupbox within w_con_pedidos_bloqueos
integer x = 622
integer y = 104
integer width = 1271
integer height = 176
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Cliente"
end type

type st_1 from statictext within w_con_pedidos_bloqueos
integer x = 288
integer y = 156
integer width = 46
integer height = 64
boolean bringtotop = true
integer textsize = -15
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "-"
alignment alignment = center!
boolean focusrectangle = false
end type

type uo_series from u_marca_lista within w_con_pedidos_bloqueos
event destroy ( )
boolean visible = false
integer x = 686
integer y = 240
boolean border = false
end type

on uo_series.destroy
call u_marca_lista::destroy
end on

type ddlb_estado from dropdownlistbox within w_con_pedidos_bloqueos
integer x = 1947
integer y = 160
integer width = 521
integer height = 352
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string item[] = {"BLOQUEADO","DISPONIBLE","TODOS"}
borderstyle borderstyle = stylelowered!
end type

type tv_1 from treeview within w_con_pedidos_bloqueos
integer y = 2272
integer width = 5216
integer height = 704
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
borderstyle borderstyle = stylelowered!
long picturemaskcolor = 536870912
long statepicturemaskcolor = 536870912
end type

type ddlb_esta_fabricado from dropdownlistbox within w_con_pedidos_bloqueos
integer x = 2578
integer y = 164
integer width = 521
integer height = 352
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string item[] = {"S","N","TODOS"}
borderstyle borderstyle = stylelowered!
end type

type gb_6 from groupbox within w_con_pedidos_bloqueos
integer x = 4882
integer y = 120
integer width = 320
integer height = 160
integer taborder = 70
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_2 from groupbox within w_con_pedidos_bloqueos
integer x = 2523
integer y = 108
integer width = 631
integer height = 176
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Pedido Fabricado"
end type

