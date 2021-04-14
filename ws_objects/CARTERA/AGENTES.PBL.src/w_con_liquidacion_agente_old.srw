$PBExportHeader$w_con_liquidacion_agente_old.srw
$PBExportComments$€
forward
global type w_con_liquidacion_agente_old from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_liquidacion_agente_old
end type
type gb_2 from groupbox within w_con_liquidacion_agente_old
end type
type gb_fecha from groupbox within w_con_liquidacion_agente_old
end type
type em_fechahasta from u_em_campo within w_con_liquidacion_agente_old
end type
type cb_1 from commandbutton within w_con_liquidacion_agente_old
end type
type cb_2 from commandbutton within w_con_liquidacion_agente_old
end type
type st_4 from statictext within w_con_liquidacion_agente_old
end type
type uo_agente from u_em_campo_2 within w_con_liquidacion_agente_old
end type
type em_fechadesde from u_em_campo within w_con_liquidacion_agente_old
end type
type st_1 from statictext within w_con_liquidacion_agente_old
end type
type dw_1 from datawindow within w_con_liquidacion_agente_old
end type
type dw_listado from datawindow within w_con_liquidacion_agente_old
end type
type pb_impresora from picturebutton within w_con_liquidacion_agente_old
end type
end forward

global type w_con_liquidacion_agente_old from w_int_con_empresa
integer width = 2976
integer height = 1652
pb_1 pb_1
gb_2 gb_2
gb_fecha gb_fecha
em_fechahasta em_fechahasta
cb_1 cb_1
cb_2 cb_2
st_4 st_4
uo_agente uo_agente
em_fechadesde em_fechadesde
st_1 st_1
dw_1 dw_1
dw_listado dw_listado
pb_impresora pb_impresora
end type
global w_con_liquidacion_agente_old w_con_liquidacion_agente_old

type variables
 string detalle="S"
end variables

forward prototypes
public subroutine f_cargar (datawindow data)
end prototypes

public subroutine f_cargar (datawindow data);String filtro,ag1,ag2,naci1,naci2
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


data.retrieve(codigo_empresa,datetime(date(em_fechadesde.text)),datetime(date(em_fechahasta.text)),ag1,ag2,naci1,naci2)


end subroutine

on w_con_liquidacion_agente_old.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.gb_2=create gb_2
this.gb_fecha=create gb_fecha
this.em_fechahasta=create em_fechahasta
this.cb_1=create cb_1
this.cb_2=create cb_2
this.st_4=create st_4
this.uo_agente=create uo_agente
this.em_fechadesde=create em_fechadesde
this.st_1=create st_1
this.dw_1=create dw_1
this.dw_listado=create dw_listado
this.pb_impresora=create pb_impresora
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.gb_2
this.Control[iCurrent+3]=this.gb_fecha
this.Control[iCurrent+4]=this.em_fechahasta
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.cb_2
this.Control[iCurrent+7]=this.st_4
this.Control[iCurrent+8]=this.uo_agente
this.Control[iCurrent+9]=this.em_fechadesde
this.Control[iCurrent+10]=this.st_1
this.Control[iCurrent+11]=this.dw_1
this.Control[iCurrent+12]=this.dw_listado
this.Control[iCurrent+13]=this.pb_impresora
end on

on w_con_liquidacion_agente_old.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.gb_2)
destroy(this.gb_fecha)
destroy(this.em_fechahasta)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.st_4)
destroy(this.uo_agente)
destroy(this.em_fechadesde)
destroy(this.st_1)
destroy(this.dw_1)
destroy(this.dw_listado)
destroy(this.pb_impresora)
end on

event open;call super::open;istr_parametros.s_titulo_ventana =   "Consulta de Liquidaciones por Agentes"
istr_parametros.s_listado        =   ""
This.title                       =   istr_parametros.s_titulo_ventana

dw_1.SetTransObject(SQLCA)
dw_listado.SetTransObject(SQLCA)

em_fechahasta.text=string(today(),"dd-mm-yy")
em_fechadesde.text=string(mdy(01,01,Year(Today())),"dd-mm-yy")
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_liquidacion_agente_old
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_liquidacion_agente_old
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(em_fechahasta)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_con_liquidacion_agente_old
integer x = 18
integer y = 20
end type

type pb_1 from upb_salir within w_con_liquidacion_agente_old
integer x = 2697
integer y = 196
integer width = 110
integer height = 96
integer taborder = 0
string picturename = "exit!"
end type

type gb_2 from groupbox within w_con_liquidacion_agente_old
integer x = 1906
integer y = 124
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

type gb_fecha from groupbox within w_con_liquidacion_agente_old
integer x = 9
integer y = 168
integer width = 699
integer height = 152
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fecha"
end type

type em_fechahasta from u_em_campo within w_con_liquidacion_agente_old
integer x = 411
integer y = 220
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

type cb_1 from commandbutton within w_con_liquidacion_agente_old
integer x = 1920
integer y = 164
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
dw_1.Modify("DataWindow.trailer.1.Height=101")
dw_listado.Modify("DataWindow.detail.Height=73")
dw_listado.Modify("DataWindow.trailer.1.Height=101")

end event

type cb_2 from commandbutton within w_con_liquidacion_agente_old
integer x = 1920
integer y = 240
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
dw_1.Modify("DataWindow.trailer.1.Height=0")
dw_listado.Modify("DataWindow.detail.Height=0")
dw_listado.Modify("DataWindow.trailer.1.Height=0")

end event

type st_4 from statictext within w_con_liquidacion_agente_old
integer x = 731
integer y = 164
integer width = 1157
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Agente"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type uo_agente from u_em_campo_2 within w_con_liquidacion_agente_old
event modificado pbm_custom01
event getfocus pbm_custom04
integer x = 731
integer y = 240
integer width = 1157
integer taborder = 30
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

type em_fechadesde from u_em_campo within w_con_liquidacion_agente_old
integer x = 50
integer y = 220
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

type st_1 from statictext within w_con_liquidacion_agente_old
integer x = 357
integer y = 208
integer width = 46
integer height = 88
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "_"
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_con_liquidacion_agente_old
integer y = 332
integer width = 2843
integer height = 1100
string dataobject = "dw_con_liquidacion_agente_old"
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

type dw_listado from datawindow within w_con_liquidacion_agente_old
boolean visible = false
integer x = 50
integer width = 448
integer height = 488
boolean bringtotop = true
string dataobject = "report_con_liquidacion_agente_old"
boolean livescroll = true
end type

type pb_impresora from picturebutton within w_con_liquidacion_agente_old
event clicked pbm_bnclicked
integer x = 2327
integer y = 196
integer width = 110
integer height = 96
integer taborder = 1
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

