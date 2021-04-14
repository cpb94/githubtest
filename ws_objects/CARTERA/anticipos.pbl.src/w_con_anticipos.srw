$PBExportHeader$w_con_anticipos.srw
forward
global type w_con_anticipos from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_anticipos
end type
type cb_consultar from commandbutton within w_con_anticipos
end type
type em_anyo from editmask within w_con_anticipos
end type
type st_8 from statictext within w_con_anticipos
end type
type em_vencimiento from u_em_campo within w_con_anticipos
end type
type em_plazo_real from u_em_campo within w_con_anticipos
end type
type st_9 from statictext within w_con_anticipos
end type
type st_nombre_banco from statictext within w_con_anticipos
end type
type em_banco from u_em_campo within w_con_anticipos
end type
type st_1 from statictext within w_con_anticipos
end type
type st_2 from statictext within w_con_anticipos
end type
type ddlb_1 from dropdownlistbox within w_con_anticipos
end type
type st_3 from statictext within w_con_anticipos
end type
type pb_cartas from picturebutton within w_con_anticipos
end type
type ddlb_2 from dropdownlistbox within w_con_anticipos
end type
type st_4 from statictext within w_con_anticipos
end type
type dw_listado from datawindow within w_con_anticipos
end type
type dw_1 from datawindow within w_con_anticipos
end type
end forward

global type w_con_anticipos from w_int_con_empresa
integer width = 3963
integer height = 2096
pb_1 pb_1
cb_consultar cb_consultar
em_anyo em_anyo
st_8 st_8
em_vencimiento em_vencimiento
em_plazo_real em_plazo_real
st_9 st_9
st_nombre_banco st_nombre_banco
em_banco em_banco
st_1 st_1
st_2 st_2
ddlb_1 ddlb_1
st_3 st_3
pb_cartas pb_cartas
ddlb_2 ddlb_2
st_4 st_4
dw_listado dw_listado
dw_1 dw_1
end type
global w_con_anticipos w_con_anticipos

type variables
string filtro

editmask isle_campo 
integer var_ejercicio
string istr_factura

int istr_prorroga

end variables

forward prototypes
public subroutine f_cargar (datawindow data)
end prototypes

public subroutine f_cargar (datawindow data);int situd,situh
string banco

choose case ddlb_1.text 
	case "Todos"
		situd = 0
		situh = 5
	case "Pendientes"
		situd = 0
		situh = 1
	case "Abonados"
		situd = 2
		situh = 3
	case "Cancelados"
		situd = 4
		situh = 4
end choose

if em_banco.text = "" then
	banco = "%"
else
	banco = em_banco.text 
end if

if ddlb_2.text = "Todas" then
	data.setfilter("")
	data.filter()
end if

if  ddlb_2.text = "Actual" then
	data.setfilter(" num_prorroga = prorroga_activa")
	data.filter()
end if

data.retrieve(codigo_empresa,integer(em_anyo.text),banco,situd,situh)
end subroutine

event open;call super::open;istr_parametros.s_titulo_ventana="Consulta de Anticipos por Banco y Situación"
This.title=istr_parametros.s_titulo_ventana

dw_1.settransobject(sqlca)

em_anyo.text = string(year(today()))

// En istr_prorroga tenemos la prorroga del anticipo seleccionado
// Inicialmente -1
istr_prorroga = -1

ddlb_1.text = "Todos"
ddlb_2.text = "Todas"
end event

on w_con_anticipos.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.cb_consultar=create cb_consultar
this.em_anyo=create em_anyo
this.st_8=create st_8
this.em_vencimiento=create em_vencimiento
this.em_plazo_real=create em_plazo_real
this.st_9=create st_9
this.st_nombre_banco=create st_nombre_banco
this.em_banco=create em_banco
this.st_1=create st_1
this.st_2=create st_2
this.ddlb_1=create ddlb_1
this.st_3=create st_3
this.pb_cartas=create pb_cartas
this.ddlb_2=create ddlb_2
this.st_4=create st_4
this.dw_listado=create dw_listado
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.cb_consultar
this.Control[iCurrent+3]=this.em_anyo
this.Control[iCurrent+4]=this.st_8
this.Control[iCurrent+5]=this.em_vencimiento
this.Control[iCurrent+6]=this.em_plazo_real
this.Control[iCurrent+7]=this.st_9
this.Control[iCurrent+8]=this.st_nombre_banco
this.Control[iCurrent+9]=this.em_banco
this.Control[iCurrent+10]=this.st_1
this.Control[iCurrent+11]=this.st_2
this.Control[iCurrent+12]=this.ddlb_1
this.Control[iCurrent+13]=this.st_3
this.Control[iCurrent+14]=this.pb_cartas
this.Control[iCurrent+15]=this.ddlb_2
this.Control[iCurrent+16]=this.st_4
this.Control[iCurrent+17]=this.dw_listado
this.Control[iCurrent+18]=this.dw_1
end on

on w_con_anticipos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.cb_consultar)
destroy(this.em_anyo)
destroy(this.st_8)
destroy(this.em_vencimiento)
destroy(this.em_plazo_real)
destroy(this.st_9)
destroy(this.st_nombre_banco)
destroy(this.em_banco)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.ddlb_1)
destroy(this.st_3)
destroy(this.pb_cartas)
destroy(this.ddlb_2)
destroy(this.st_4)
destroy(this.dw_listado)
destroy(this.dw_1)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_anticipos
integer x = 2112
integer y = 20
integer width = 485
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_anticipos
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_anticipos
integer x = 9
integer y = 12
integer width = 2427
integer height = 96
end type

type pb_1 from upb_salir within w_con_anticipos
integer x = 3808
integer y = 16
integer width = 142
integer height = 116
integer taborder = 0
end type

type cb_consultar from commandbutton within w_con_anticipos
integer x = 2240
integer y = 188
integer width = 306
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Consultar"
end type

event clicked;f_cargar(dw_1)


//int situd,situh
//string bancod,bancoh
//
//choose case ddlb_1.text 
//	case "Todos"
//		situd = 1
//		situh = 5
//	case "Liquidados"
//		situd = 4
//		situh = 4
//	case "Abonados"
//		situd = 2
//		situh = 3
//	case "Cancelados"
//		situd = 5
//		situh = 5
//
//
//end choose
//
//if em_banco.text = "" then
//	bancod = "."
//	bancoh = "Z"	
//else
//	bancod = em_banco.text 
//	bancoh = em_banco.text	
//end if
//
//
//if  ddlb_2.text = "Todas" then
//	dw_1.setfilter("")
//	dw_1.filter()
//end if
//
//if  ddlb_2.text = "Actual" then
//	dw_1.setfilter(" num_prorroga = prorroga_activa")
//	dw_1.filter()
//end if
//
//
//
//dw_1.retrieve(codigo_empresa,bancod,bancoh,situd,situh)
end event

type em_anyo from editmask within w_con_anticipos
integer x = 1093
integer y = 192
integer width = 219
integer height = 84
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datetimemask!
string mask = "yyyy"
string displaydata = "x"
end type

type st_8 from statictext within w_con_anticipos
integer x = 2958
integer y = 324
integer width = 416
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Vencimiento :"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_vencimiento from u_em_campo within w_con_anticipos
integer x = 3378
integer y = 332
integer width = 270
integer taborder = 0
boolean border = false
alignment alignment = right!
boolean displayonly = true
borderstyle borderstyle = stylebox!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yy"
string displaydata = ""
end type

type em_plazo_real from u_em_campo within w_con_anticipos
integer x = 3442
integer y = 424
integer width = 206
integer taborder = 0
boolean border = false
alignment alignment = right!
boolean displayonly = true
borderstyle borderstyle = stylebox!
maskdatatype maskdatatype = numericmask!
string mask = "##0"
string displaydata = "0"
end type

type st_9 from statictext within w_con_anticipos
integer x = 2935
integer y = 424
integer width = 379
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long backcolor = 12632256
boolean enabled = false
string text = "Plazo Real :"
boolean focusrectangle = false
end type

type st_nombre_banco from statictext within w_con_anticipos
integer x = 338
integer y = 196
integer width = 704
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type em_banco from u_em_campo within w_con_anticipos
event getfocus pbm_ensetfocus
event modificado pbm_custom02
integer x = 46
integer y = 192
integer width = 279
integer taborder = 10
boolean bringtotop = true
long backcolor = 16777215
alignment alignment = right!
string mask = "!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
end type

event getfocus;call super::getfocus;ue_titulo     = "AYUDA SELECCION BANCOS"
ue_datawindow = "dw_ayuda_carbancos"
ue_filtro     = ""		
isle_campo    = this

end event

event modificado;call super::modificado;st_nombre_banco.text=f_nombre_banco(codigo_empresa,em_banco.text)	
IF Trim(st_nombre_banco.text)="" THEN 
 IF Trim(st_nombre_banco.text)<>"" Then f_activar_campo(em_banco)
 em_banco.text=""
END IF
end event

type st_1 from statictext within w_con_anticipos
integer x = 50
integer y = 128
integer width = 229
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Banco "
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_con_anticipos
integer x = 1093
integer y = 128
integer width = 160
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Año "
alignment alignment = center!
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within w_con_anticipos
integer x = 1335
integer y = 192
integer width = 425
integer height = 536
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
boolean vscrollbar = true
string item[] = {"Todos","Abonados","Liquidados","Cancelados"}
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_con_anticipos
integer x = 1339
integer y = 128
integer width = 315
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Situación "
alignment alignment = center!
boolean focusrectangle = false
end type

type pb_cartas from picturebutton within w_con_anticipos
event clicked pbm_bnclicked
integer x = 3767
integer y = 152
integer width = 183
integer height = 160
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "\bmp\imp32.bmp"
string disabledname = "\bmp\imp32_no.bmp"
end type

event clicked;u_imprimir u_imp
u_imp = create u_imprimir
u_imp.ibCabecera  = true // Indica el report cabecera. "" sin cabecera
u_imp.isTitulo    = parent.title
u_imp.isSubTitulo = "Situación : "+ddlb_1.text
u_imp.ibLandscape = false
parent.OpenUserObject(u_imp.report)

u_imp.event ue_imprimir(dw_1)

destroy u_imp
end event

type ddlb_2 from dropdownlistbox within w_con_anticipos
integer x = 1778
integer y = 192
integer width = 439
integer height = 320
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
boolean vscrollbar = true
string item[] = {"Actual","Todas"}
borderstyle borderstyle = stylelowered!
end type

type st_4 from statictext within w_con_anticipos
integer x = 1778
integer y = 132
integer width = 325
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Prórroga "
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_listado from datawindow within w_con_anticipos
boolean visible = false
integer x = 343
integer y = 124
integer width = 786
integer height = 360
integer taborder = 21
boolean bringtotop = true
string dataobject = "report_con_anticipos"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;if isnull(dwo) then return
string orden
choose case dwo.name 
	case "contador_t"
		orden="empresa , bancofinan , contador "
		dw_1.setredraw(false)
		dw_1.setsort(orden)
		dw_listado.setsort(orden)
		dw_1.sort()
		dw_listado.sort()
		dw_1.groupcalc()
		dw_1.setredraw(True)		
	case "vencimiento_t"
		orden="empresa , bancofinan , vencimiento "
		dw_1.setredraw(false)
		dw_1.setsort(orden)
		dw_listado.setsort(orden)
		dw_1.sort()
		dw_listado.sort()
		dw_1.groupcalc()
		dw_1.setredraw(True)		
end choose		
end event

type dw_1 from datawindow within w_con_anticipos
integer x = 5
integer y = 320
integer width = 3945
integer height = 1616
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_con_anticipos"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;if dwo.name = "vencimiento_t" then
	dw_1.setsort("empresa, bancofinan, vencimiento")
	dw_1.sort()
end if


if dwo.name = "contador_t" then
	dw_1.setsort("empresa, bancofinan, contador, num_prorroga")
	dw_1.sort()
end if
end event

event retrieveend;long ll_indice,v_anyo,v_factura
dec  v_pendiente_cartera
string v_factura_string
datetime ldt_fecha_cobro

this.setredraw(false)

For ll_indice = 1 To rowcount	
	//f_mensaje_proceso("",ll_indice,total)	
	v_anyo           = this.object.anyo_fac[ll_indice]
	v_factura_string = this.object.factura[ll_indice]
	
	v_pendiente_cartera = 0
		
	select isnull(sum(importe_pendiente),0)
	into   :v_pendiente_cartera
	from (select isnull(sum(carefectos.importe),0) as importe_pendiente
			from   carefectos
			where  carefectos.empresa   = :codigo_empresa
			and    carefectos.anyofra   = :v_anyo
			and    carefectos.factura   = :v_factura_string
			and    situacion <> '9'
			and    situacion <> '3'
			union all
			select isnull(sum(agrupado_detalle.importe),0) as importe_pendiente
			from   carefectos as agrupado_cabecera,
					 carefectos as agrupado_detalle
			where  agrupado_cabecera.empresa = agrupado_detalle.empresa
			and    agrupado_cabecera.anyo    = agrupado_detalle.anyoagrupa
			and    agrupado_cabecera.orden   = agrupado_detalle.efectoagrupa
			and    agrupado_detalle.empresa  = :codigo_empresa
			and    agrupado_detalle.anyofra  = :v_anyo
			and    agrupado_detalle.factura  = :v_factura_string
			and    agrupado_detalle.situacion = '3'
			and    agrupado_cabecera.situacion <> '9'
			and    agrupado_cabecera.importe > 0) as resultado;		
	
	
	if isnull(v_pendiente_cartera) then v_pendiente_cartera = 0

	if v_pendiente_cartera = 0 then
		select max(fecha_cobro)
		into   :ldt_fecha_cobro
		from (select isnull(carhistorico.fcobro,carhistorico.fvto) as fecha_cobro
				from   carhistorico
				where  carhistorico.empresa   = :codigo_empresa
				and    carhistorico.anyofra   = :v_anyo
				and    carhistorico.factura   = :v_factura_string
				and    situacion <> '3'
				union all
				select isnull(agrupado_detalle.fcobro,agrupado_detalle.fvto) as fecha_cobro
				from   carhistorico as agrupado_cabecera,
						 carhistorico as agrupado_detalle
				where  agrupado_cabecera.empresa = agrupado_detalle.empresa
				and    agrupado_cabecera.anyo    = agrupado_detalle.anyoagrupa
				and    agrupado_cabecera.orden   = agrupado_detalle.efectoagrupa
				and    agrupado_detalle.empresa  = :codigo_empresa
				and    agrupado_detalle.anyofra  = :v_anyo
				and    agrupado_detalle.factura  = :v_factura_string
				and    agrupado_detalle.situacion = '3'
				and    agrupado_cabecera.importe > 0) as resultado;			
				
	else
		setnull(ldt_fecha_cobro)
	end if
	
	this.object.fecha_cobro[ll_indice] = ldt_fecha_cobro
next

this.setredraw(true)
end event

