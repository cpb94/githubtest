$PBExportHeader$w_con_liquidacion_agente.srw
$PBExportComments$€
forward
global type w_con_liquidacion_agente from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_liquidacion_agente
end type
type gb_2 from groupbox within w_con_liquidacion_agente
end type
type gb_fecha from groupbox within w_con_liquidacion_agente
end type
type cb_1 from commandbutton within w_con_liquidacion_agente
end type
type cb_2 from commandbutton within w_con_liquidacion_agente
end type
type st_4 from statictext within w_con_liquidacion_agente
end type
type uo_agente from u_em_campo_2 within w_con_liquidacion_agente
end type
type em_fechadesde from u_em_campo within w_con_liquidacion_agente
end type
type dw_1 from datawindow within w_con_liquidacion_agente
end type
type dw_listado from datawindow within w_con_liquidacion_agente
end type
type pb_impresora from picturebutton within w_con_liquidacion_agente
end type
type em_fechahasta from u_em_campo within w_con_liquidacion_agente
end type
type em_cobrofechadesde from u_em_campo within w_con_liquidacion_agente
end type
type em_cobrofechahasta from u_em_campo within w_con_liquidacion_agente
end type
type em_liquidacionfechadesde from u_em_campo within w_con_liquidacion_agente
end type
type em_liquidacionfechahasta from u_em_campo within w_con_liquidacion_agente
end type
type cbx_excluir_wow_usa from checkbox within w_con_liquidacion_agente
end type
type gb_1 from groupbox within w_con_liquidacion_agente
end type
type gb_3 from groupbox within w_con_liquidacion_agente
end type
end forward

global type w_con_liquidacion_agente from w_int_con_empresa
integer width = 4983
integer height = 3208
pb_1 pb_1
gb_2 gb_2
gb_fecha gb_fecha
cb_1 cb_1
cb_2 cb_2
st_4 st_4
uo_agente uo_agente
em_fechadesde em_fechadesde
dw_1 dw_1
dw_listado dw_listado
pb_impresora pb_impresora
em_fechahasta em_fechahasta
em_cobrofechadesde em_cobrofechadesde
em_cobrofechahasta em_cobrofechahasta
em_liquidacionfechadesde em_liquidacionfechadesde
em_liquidacionfechahasta em_liquidacionfechahasta
cbx_excluir_wow_usa cbx_excluir_wow_usa
gb_1 gb_1
gb_3 gb_3
end type
global w_con_liquidacion_agente w_con_liquidacion_agente

type variables
 string detalle="S"
end variables

forward prototypes
public subroutine f_cargar (datawindow data)
end prototypes

public subroutine f_cargar (datawindow data);String filtro,ag1,ag2,naci1,naci2
long filas


filtro = ""
data.SetFilter(filtro)
data.Filter()

ag1 = "."
ag2 = "Z"

IF uo_agente.em_codigo.text <> "" Then
	ag1 =	uo_agente.em_codigo.text
	ag2 = uo_agente.em_codigo.text
END IF



if tipo_vista = "Nacional" then
	naci1 = "S"
	naci2 = "S"
else
	if tipo_vista = "Exportacion" then
		naci1 = "N"
		naci2 = "N"
	else
		naci1 = "S"
		naci2 = "N"
	end if

end if



filas = data.retrieve(codigo_empresa,datetime(date(em_fechadesde.text)),datetime(date(em_fechahasta.text)),ag1,ag2,naci1,naci2,datetime(date(em_cobrofechadesde.text)),datetime(date(em_cobrofechahasta.text)), datetime(date(em_liquidacionfechadesde.text)) ,datetime(date(em_liquidacionfechahasta.text)))


if cbx_excluir_wow_usa.checked = true then
	
	filtro = "agente <> '31'"
	data.setfilter(filtro)
	data.filter()
	
end if


data.groupcalc()
data.setredraw(true)


if data.rowcount() = 0 then
	
	messagebox("Aviso","No existen registros")
	
end if
end subroutine

on w_con_liquidacion_agente.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.gb_2=create gb_2
this.gb_fecha=create gb_fecha
this.cb_1=create cb_1
this.cb_2=create cb_2
this.st_4=create st_4
this.uo_agente=create uo_agente
this.em_fechadesde=create em_fechadesde
this.dw_1=create dw_1
this.dw_listado=create dw_listado
this.pb_impresora=create pb_impresora
this.em_fechahasta=create em_fechahasta
this.em_cobrofechadesde=create em_cobrofechadesde
this.em_cobrofechahasta=create em_cobrofechahasta
this.em_liquidacionfechadesde=create em_liquidacionfechadesde
this.em_liquidacionfechahasta=create em_liquidacionfechahasta
this.cbx_excluir_wow_usa=create cbx_excluir_wow_usa
this.gb_1=create gb_1
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.gb_2
this.Control[iCurrent+3]=this.gb_fecha
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.cb_2
this.Control[iCurrent+6]=this.st_4
this.Control[iCurrent+7]=this.uo_agente
this.Control[iCurrent+8]=this.em_fechadesde
this.Control[iCurrent+9]=this.dw_1
this.Control[iCurrent+10]=this.dw_listado
this.Control[iCurrent+11]=this.pb_impresora
this.Control[iCurrent+12]=this.em_fechahasta
this.Control[iCurrent+13]=this.em_cobrofechadesde
this.Control[iCurrent+14]=this.em_cobrofechahasta
this.Control[iCurrent+15]=this.em_liquidacionfechadesde
this.Control[iCurrent+16]=this.em_liquidacionfechahasta
this.Control[iCurrent+17]=this.cbx_excluir_wow_usa
this.Control[iCurrent+18]=this.gb_1
this.Control[iCurrent+19]=this.gb_3
end on

on w_con_liquidacion_agente.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.gb_2)
destroy(this.gb_fecha)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.st_4)
destroy(this.uo_agente)
destroy(this.em_fechadesde)
destroy(this.dw_1)
destroy(this.dw_listado)
destroy(this.pb_impresora)
destroy(this.em_fechahasta)
destroy(this.em_cobrofechadesde)
destroy(this.em_cobrofechahasta)
destroy(this.em_liquidacionfechadesde)
destroy(this.em_liquidacionfechahasta)
destroy(this.cbx_excluir_wow_usa)
destroy(this.gb_1)
destroy(this.gb_3)
end on

event open;call super::open;istr_parametros.s_titulo_ventana =   "Consulta de Liquidaciones por Agentes"
istr_parametros.s_listado        =   ""
This.title                       =   istr_parametros.s_titulo_ventana

dw_1.SetTransObject(SQLCA)
dw_listado.SetTransObject(SQLCA)

em_fechahasta.text=string(today(),"dd-mm-yy")
em_fechadesde.text=string(mdy(01,01,Year(Today())),"dd-mm-yy")

em_cobrofechahasta.text=string(today(),"dd-mm-yy")
em_cobrofechadesde.text=string(mdy(01,01,Year(Today())),"dd-mm-yy")

em_liquidacionfechahasta.text=string(today(),"dd-mm-yy")
em_liquidacionfechadesde.text=string(mdy(01,01,Year(Today())),"dd-mm-yy")
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_liquidacion_agente
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_liquidacion_agente
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(em_fechahasta)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_con_liquidacion_agente
integer x = 14
integer y = 24
integer width = 3803
end type

type pb_1 from upb_salir within w_con_liquidacion_agente
integer x = 4768
integer y = 268
integer width = 110
integer height = 96
integer taborder = 0
string picturename = "exit!"
end type

type gb_2 from groupbox within w_con_liquidacion_agente
integer x = 4393
integer y = 156
integer width = 329
integer height = 204
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_fecha from groupbox within w_con_liquidacion_agente
integer x = 46
integer y = 180
integer width = 699
integer height = 152
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
string text = "Fecha Factura"
end type

type cb_1 from commandbutton within w_con_liquidacion_agente
integer x = 4407
integer y = 196
integer width = 302
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Detalle"
end type

event clicked;f_cargar(dw_1)
dw_1.Modify("DataWindow.detail.Height=89")
dw_1.Modify("DataWindow.trailer.1.Height=111")
dw_listado.Modify("DataWindow.detail.Height=73")
dw_listado.Modify("DataWindow.trailer.1.Height=111")

end event

type cb_2 from commandbutton within w_con_liquidacion_agente
integer x = 4407
integer y = 272
integer width = 302
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Resumen"
end type

event clicked;f_cargar(dw_1)
dw_1.Modify("DataWindow.detail.Height=0")
//dw_1.Modify("DataWindow.trailer.1.Height=0")
dw_listado.Modify("DataWindow.detail.Height=0")
//dw_listado.Modify("DataWindow.trailer.1.Height=0")

end event

type st_4 from statictext within w_con_liquidacion_agente
integer x = 2213
integer y = 176
integer width = 1157
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
boolean enabled = false
string text = "Agente"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type uo_agente from u_em_campo_2 within w_con_liquidacion_agente
event modificado pbm_custom01
event getfocus pbm_custom04
integer x = 2208
integer y = 252
integer width = 1157
integer taborder = 70
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_agente.em_campo.text=f_nombre_venagentes(codigo_empresa,uo_agente.em_codigo.text)
IF Trim(uo_agente.em_campo.text)="" THEN 
 IF Trim(uo_agente.em_codigo.text)<>"" Then uo_agente.em_campo.SetFocus()
 uo_agente.em_campo.text=""
 uo_agente.em_codigo.text=""
END IF





end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de agentes"
ue_datawindow = "dw_ayuda_venagentes"
ue_filtro     = ""
IF tipo_vista= "Nacional"    Then   ue_filtro     = "nacional = 'S'"
IF tipo_vista= "Exportacion" Then   ue_filtro     = "nacional = 'N'"



end event

on uo_agente.destroy
call u_em_campo_2::destroy
end on

type em_fechadesde from u_em_campo within w_con_liquidacion_agente
integer x = 87
integer y = 232
integer width = 297
integer taborder = 10
boolean bringtotop = true
integer textsize = -9
string facename = "Arial"
long backcolor = 16777215
alignment alignment = center!
maskdatatype maskdatatype = datetimemask!
string mask = "dd-mm-yy"
string displaydata = ""
end type

type dw_1 from datawindow within w_con_liquidacion_agente
integer x = 41
integer y = 408
integer width = 4869
integer height = 2588
string dataobject = "dw_con_liquidacion_agente"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;//if row=0 then Return
//string albaran
//date fec
//str_parametros lstr_param 
//  lstr_param.i_nargumentos=3
//  lstr_param.s_argumentos[2]=String(dw_1.GetItemNumber(This.GetRow(),"anyo"))
//  lstr_param.s_argumentos[3]=String(dw_1.GetItemNumber(This.GetRow(),"albaran"))
//  OpenWithParm(w_con_promalbaranes,lstr_param)
//
end event

type dw_listado from datawindow within w_con_liquidacion_agente
boolean visible = false
integer x = 50
integer width = 448
integer height = 488
boolean bringtotop = true
string dataobject = "report_con_liquidacion_agente"
boolean livescroll = true
end type

type pb_impresora from picturebutton within w_con_liquidacion_agente
event clicked pbm_bnclicked
integer x = 4763
integer y = 148
integer width = 110
integer height = 96
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "print!"
string disabledname = "c:\bmp\imp32_no.bmp"
end type

event clicked;f_cargar(dw_listado)

f_imprimir_datawindow(dw_listado)
end event

type em_fechahasta from u_em_campo within w_con_liquidacion_agente
integer x = 448
integer y = 232
integer width = 274
integer taborder = 20
boolean bringtotop = true
integer textsize = -9
string facename = "Arial"
long backcolor = 16777215
alignment alignment = center!
maskdatatype maskdatatype = datetimemask!
string mask = "dd-mm-yy"
string displaydata = ""
end type

type em_cobrofechadesde from u_em_campo within w_con_liquidacion_agente
integer x = 809
integer y = 232
integer width = 297
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
string facename = "Arial"
long backcolor = 16777215
alignment alignment = center!
maskdatatype maskdatatype = datetimemask!
string mask = "dd-mm-yy"
string displaydata = ""
end type

type em_cobrofechahasta from u_em_campo within w_con_liquidacion_agente
integer x = 1170
integer y = 236
integer width = 274
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
string facename = "Arial"
long backcolor = 16777215
alignment alignment = center!
maskdatatype maskdatatype = datetimemask!
string mask = "dd-mm-yy"
string displaydata = ""
end type

type em_liquidacionfechadesde from u_em_campo within w_con_liquidacion_agente
integer x = 1527
integer y = 232
integer width = 297
integer taborder = 50
boolean bringtotop = true
integer textsize = -9
string facename = "Arial"
long backcolor = 16777215
alignment alignment = center!
maskdatatype maskdatatype = datetimemask!
string mask = "dd-mm-yy"
string displaydata = ""
end type

type em_liquidacionfechahasta from u_em_campo within w_con_liquidacion_agente
integer x = 1893
integer y = 232
integer width = 274
integer taborder = 60
boolean bringtotop = true
integer textsize = -9
string facename = "Arial"
long backcolor = 16777215
alignment alignment = center!
maskdatatype maskdatatype = datetimemask!
string mask = "dd-mm-yy"
string displaydata = ""
end type

type cbx_excluir_wow_usa from checkbox within w_con_liquidacion_agente
integer x = 3602
integer y = 224
integer width = 535
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Excluir wow usa"
borderstyle borderstyle = styleraised!
end type

type gb_1 from groupbox within w_con_liquidacion_agente
integer x = 768
integer y = 180
integer width = 699
integer height = 152
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
string text = "Fecha Cobro"
end type

type gb_3 from groupbox within w_con_liquidacion_agente
integer x = 1490
integer y = 180
integer width = 699
integer height = 152
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
string text = "Fecha Liquidación"
end type

